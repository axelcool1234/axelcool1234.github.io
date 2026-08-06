#!/usr/bin/env python3
"""Show, per ds_load, how far ahead of its OWN consuming WMMA it was issued --
and which scheduler heuristic made that call.

This is the join the argument needs. Two debug streams from ONE llc run:

  -debug-only=amdgpu-wmma-sched   -> for each ds_load, its earliest consuming
                                     WMMA (MinPos); for each fragment, the VGPR
                                     width and the earliest position the RP
                                     budget would allow ("floor").
  -debug-only=machine-scheduler   -> the actual pick order, so we know how many
                                     WMMAs had been issued when each load went,
                                     plus the heuristic that decided it.

Run with -amdgpu-wmma-sched-analyze-only to get the UNMUTATED schedule together
with what the mutation would have constrained -- that combination is what lets a
single command say "SU119 was issued at W[34]; nothing reads it until W[88]".

Usage:
  llc ... -amdgpu-sched-strategy=coexec -amdgpu-wmma-sched-analyze-only \
      -debug-only=machine-scheduler,amdgpu-wmma-sched k.llir -o /dev/null 2>t.log
  early-loads.py t.log
  early-loads.py t.log --top 15        # worst offenders only
  early-loads.py t.log --clamped       # only fragments the mutation would clamp
"""
import argparse
import importlib.util
import os
import re
import sys
from collections import Counter

_here = os.path.dirname(os.path.abspath(__file__))
_spec = importlib.util.spec_from_file_location(
    "sched_tape", os.path.join(_here, "sched-tape.py"))
st = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(st)

RE_LOAD = re.compile(r"^\[2\] ds_load SU(\d+): MinPos=(\d+) MaxPos=(\d+)")
RE_FRAG = re.compile(
    r"^\[6\] frag \(([^)]*)\) \(vgprs=(\d+), consumers W\[(\d+)\.\.(\d+)\]\) "
    r"earliest=W\[(\d+)\]\s*(.*)$")
RE_BUDGET = re.compile(r"budget = (\d+)")
RE_SU = re.compile(r"SU(\d+)")


RE_REGION_BANNER = re.compile(r"^\*+ MI Scheduling \*+")


def parse_mutation(path):
    """Parse the mutation's analysis, keyed by scheduling-region index.

    The pass re-runs on every region that gets (re)scheduled, and SU numbers are
    renumbered per region -- so with a later stage like Live Interval RP
    Reschedule the SAME SU number denotes a different instruction with a
    different consumer window. Keying by region is what keeps the join honest;
    flattening these into one dict silently mixes two DAGs.

    -> {region: (loads{su:(min,max)}, frags{su:info}, budget)}
    """
    per = {}
    region = -1
    nfrag = 0
    for ln in open(path, errors="replace"):
        if RE_REGION_BANNER.match(ln):
            region += 1
            nfrag = 0
            continue
        cur = per.setdefault(region, ({}, {}, [None]))
        m = RE_LOAD.match(ln)
        if m:
            cur[0][int(m.group(1))] = (int(m.group(2)), int(m.group(3)))
            continue
        m = RE_FRAG.match(ln)
        if m:
            subs = [int(x) for x in RE_SU.findall(m.group(1))]
            info = dict(vgprs=int(m.group(2)), cmin=int(m.group(3)),
                        cmax=int(m.group(4)), floor=int(m.group(5)),
                        clamped="unconstrained" not in m.group(6),
                        subs=subs, fid=nfrag)
            nfrag += 1
            for s in subs:
                cur[1][s] = info
            continue
        if cur[2][0] is None:
            m = RE_BUDGET.search(ln)
            if m:
                cur[2][0] = int(m.group(1))
    return {r: (l, f, b[0]) for r, (l, f, b) in per.items() if l}


def drilldown(path, su):
    """Print the unedited log lines that justify one row of the table, so the
    claim can be checked against the scheduler's raw output on screen."""
    want_frag = re.compile(r"^\[6\] frag \(([^)]*)\)")
    print(f"=== raw evidence for ds_load SU{su} "
          f"(unedited lines from the trace) ===\n")
    print("--- mutation analysis: its consumer window and RP ceiling ---")
    region = -1
    for ln in open(path, errors="replace"):
        if RE_REGION_BANNER.match(ln):
            region += 1
            continue
        if ln.startswith(f"[2] ds_load SU{su}:"):
            print(f"  [region {region}] " + ln.rstrip())
        m = want_frag.match(ln)
        if m and su in [int(x) for x in RE_SU.findall(m.group(1))]:
            print(f"  [region {region}] " + ln.rstrip())
    print("  NOTE: a region appearing twice means a later stage re-scheduled it;"
          "\n        SU numbers are renumbered per region, so only compare a"
          "\n        region's analysis with that same region's picks.")

    print("\n--- the pick itself: ready queue, winner, deciding heuristic ---")
    buf, hit = [], False
    for ln in open(path, errors="replace"):
        buf.append(ln.rstrip())
        if len(buf) > 400:
            buf.pop(0)
        if ln.startswith(f"Scheduling SU({su}) ") and "DS_READ" in ln:
            hit = True
            break
    if not hit:
        print(f"  (no 'Scheduling SU({su})' for a ds_load in this log)")
        return
    # Walk back to the queue dump that preceded this pick.
    start = 0
    for i in range(len(buf) - 1, -1, -1):
        if buf[i].startswith("Queue TopQ.A:"):
            start = i
            break
    # Keep the queue dump and the pick verdict; of the per-candidate stall
    # comparisons keep only the last few, which are the ones that decided it.
    keep = [ln for ln in buf[start:]
            if ln.startswith(("Queue TopQ.", "=== Pick @", "Picked:",
                              "  Reason:", "Scheduling SU("))]
    stalls = [ln for ln in buf[start:] if ln.startswith("Effective stalls:")]
    for ln in stalls[-3:]:
        print("  " + (ln[:150] + "…" if len(ln) > 150 else ln))
    if len(stalls) > 3:
        print(f"  ({len(stalls) - 3} earlier candidate comparisons omitted)")
    for ln in keep:
        print("  " + (ln[:150] + "…" if len(ln) > 150 else ln))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("log")
    ap.add_argument("--top", type=int, default=0, help="show only the N earliest")
    ap.add_argument("--clamped", action="store_true",
                    help="only loads in fragments the mutation would clamp")
    ap.add_argument("--region", type=int, default=None)
    ap.add_argument("--su", type=int, default=None,
                    help="drill down on one ds_load: print the raw debug lines "
                         "(mutation analysis + the pick) straight from the log")
    a = ap.parse_args()

    if a.su is not None:
        return drilldown(a.log, a.su)

    per_region = parse_mutation(a.log)
    if not per_region:
        sys.exit("no '[2] ds_load' lines found -- add -debug-only=amdgpu-wmma-sched")

    t = st.Tape()
    t.feed(open(a.log, errors="replace"))
    t.finish()

    # The region of interest is the one that actually schedules WMMAs. If the
    # region was re-scheduled by a later stage, take the FIRST one: that is the
    # DAG the mutation analysis was computed against (SU numbers are per-region
    # and get renumbered on a re-schedule, so mixing them would be wrong).
    wmma_by_region = Counter(
        r["region"] for r in t.rows if st.kind(r["op"]) == "wmma")
    if not wmma_by_region:
        sys.exit("no WMMA picks found -- add -debug-only=machine-scheduler")
    region = a.region if a.region is not None else min(
        rg for rg, n in wmma_by_region.items() if n == max(wmma_by_region.values()))
    if region not in per_region:
        sys.exit(f"region {region} has no mutation analysis in this log "
                 f"(have: {sorted(per_region)})")
    minpos, frags, budget = per_region[region]
    rows = [r for r in t.rows if r["region"] == region]

    # Walk the pick order, tracking how many WMMAs have issued.
    seen_w = 0
    recs = []
    for r in rows:
        k = st.kind(r["op"])
        if k == "wmma":
            seen_w += 1
            continue
        if k != "ds" or r["su"] not in minpos:
            continue
        cmin, _cmax = minpos[r["su"]]
        f = frags.get(r["su"])
        recs.append(dict(su=r["su"], at=seen_w, cmin=cmin,
                         early=cmin - seen_w, frag=f, row=r))

    if a.clamped:
        recs = [x for x in recs if x["frag"] and x["frag"]["clamped"]]
    recs.sort(key=lambda x: -x["early"])
    shown = recs[:a.top] if a.top else recs

    label = t.regions[region][0] if region < len(t.regions) else "?"
    stage = rows[0].get("stage", "?") if rows else "?"
    print(f"region {region}  {label}   stage: {stage}")
    print(f"{len(recs)} ds_loads with a WMMA consumer; "
          f"RP budget = {budget} VGPRs")
    print()
    hdr = (f"{'load':<8}{'frag':>5}{'vgpr':>5}  {'issued':>7} {'1st use':>8} "
           f"{'EARLY BY':>9} {'floor':>7}  {'reason':<17} readyQ ds/wmma/oth")
    print(hdr)
    print("-" * len(hdr))
    for x in shown:
        f = x["frag"]
        r = x["row"]
        q = f"{r['nds']}/{r['nwmma']}/{r['noth']}"
        fid = f"f{f['fid']}" if f else "-"
        vg = f["vgprs"] if f else 0
        floor = f"W[{f['floor']}]" if f and f["clamped"] else "-"
        print(f"SU{x['su']:<6}{fid:>5}{vg:>5}  {('W[%d]' % x['at']):>7} "
              f"{('W[%d]' % x['cmin']):>8} {x['early']:>9} {floor:>7}  "
              f"{r.get('reason','?'):<17} {q}")
    if a.top and len(recs) > a.top:
        print(f"... {len(recs) - a.top} more (drop --top to see all)")

    # Cost of the earliness: VGPRs held live, summed over the slots they were
    # held for nothing. This is the quantity that turns into spills.
    def cost(sel):
        # Per SUBLOAD, so charge only that subload's share of the fragment's
        # width. A vreg_512 is ONE virtual register written by four subregister
        # stores -- billing all 16 VGPRs to each of the four subloads inflates
        # the total ~4x.
        return sum(x["early"] * (x["frag"]["vgprs"] / len(x["frag"]["subs"])
                                 if x["frag"] else 0)
                   for x in sel if x["early"] > 0)
    clamped = [x for x in recs if x["frag"] and x["frag"]["clamped"]]
    print(f"\nearliness (WMMA slots): mean {sum(x['early'] for x in recs)/len(recs):.1f}"
          f"  max {max(x['early'] for x in recs)}")
    print(f"VGPR-slots held early (VGPRs x WMMA-slots): all loads {cost(recs):.0f},"
          f"  fragments the mutation clamps {cost(clamped):.0f}"
          f"  ({100*cost(clamped)/max(1,cost(recs)):.0f}% of it,"
          f" from {len(clamped)}/{len(recs)} loads)")
    print("\nheuristic that issued each early load:")
    for reason, n in Counter(x["row"].get("reason", "?")
                             for x in recs if x["early"] > 0).most_common():
        print(f"  {reason:<20} {n:>4}")


if __name__ == "__main__":
    main()
