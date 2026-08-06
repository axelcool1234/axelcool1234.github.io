#!/usr/bin/env python3
"""Generate budget_data.py for the VGPR-budget animation, from the real trace.

Same discipline as extract-anim-data.py: every number the animation draws comes
out of one -debug-only=amdgpu-wmma-sched run, so the slide and the pass cannot
disagree. Nothing here is hand-typed.

Reads the [hist] / [5] / [6] sections emitted by WMMASchedule::apply():
    [hist] WmmaLatency=  LoadLatency=  WMMAs=
    [hist] frag (SUs) (vgprs=, LatestCycle=) live over W[alap..maxpos]
    [5] live-VGPR histogram BEFORE slack (min VGPRs / budget = B)
    [6] frag (SUs) (vgprs=, consumers W[min..max]) earliest=W[E] <edge added|unconstrained>
    [6]   alap=W[A] blocked at W[P]: hist=H + vgprs=V > budget=B
    [6]   hist-step: v0,v1,...,v127
    [6] live-VGPR histogram AFTER slack (peak = P)

The hist-step lines are the pass's own running histogram after each fragment is
placed, so the cumulative "later fragments only get the leftover slack" story is
replayed rather than recomputed. We still recompute it independently and assert
the two agree -- that check is the whole reason the print was added.

Usage:
  extract-budget-data.py canonical-wmmasched.log [-o budget_data.py]
"""
import argparse
import re
import sys

RE_LAT = re.compile(r"^\[hist\] WmmaLatency=(-?\d+) LoadLatency=(-?\d+) WMMAs=(\d+)")
RE_HFRAG = re.compile(r"^\[hist\] frag \(([^)]*)\) \(vgprs=(\d+), LatestCycle=(-?\d+)\)"
                      r" live over W\[(\d+)\.\.(\d+)\]")
RE_BUDGET = re.compile(r"^\[5\] live-VGPR histogram BEFORE slack .*budget = (\d+)\)")
RE_PEAK = re.compile(r"^\[6\] live-VGPR histogram AFTER slack \(peak = (\d+)\)")
RE_BIN = re.compile(r"^\s+W\[(\d+)\] = (\d+)")
RE_6FRAG = re.compile(r"^\[6\] frag \(([^)]*)\) \(vgprs=(\d+), consumers W\[(\d+)\.\.(\d+)\]\)"
                      r" earliest=W\[(\d+)\](.*)")
RE_BLOCK = re.compile(r"^\[6\]\s+alap=W\[(\d+)\] (?:blocked at W\[(\d+)\]: hist=(\d+)"
                      r" \+ vgprs=(\d+) > budget=(\d+)|scan reached W\[0\])")
RE_STEP = re.compile(r"^\[6\]\s+hist-step: (.*)")


def parse(path):
    lat = {}
    hfrag, frags, steps = [], [], []
    budget = peak = None
    before, after = {}, {}
    sink = None
    for line in open(path, errors="replace"):
        line = line.rstrip("\n")
        if m := RE_LAT.match(line):
            lat = dict(wmma=int(m[1]), load=int(m[2]), nwmma=int(m[3]))
        elif m := RE_HFRAG.match(line):
            hfrag.append(dict(subs=m[1], vgprs=int(m[2]), latest=int(m[3]),
                              alap=int(m[4]), maxpos=int(m[5])))
        elif m := RE_BUDGET.match(line):
            budget, sink = int(m[1]), before
        elif m := RE_PEAK.match(line):
            peak, sink = int(m[1]), after
        elif m := RE_BIN.match(line):
            if sink is not None:
                sink[int(m[1])] = int(m[2])
        elif m := RE_6FRAG.match(line):
            sink = None
            frags.append(dict(subs=m[1], vgprs=int(m[2]), cmin=int(m[3]),
                              cmax=int(m[4]), earliest=int(m[5]),
                              clamped="edge" in m[6]))
        elif m := RE_BLOCK.match(line):
            frags[-1]["alap"] = int(m[1])
            frags[-1]["blocked_at"] = int(m[2]) if m[2] else None
            frags[-1]["blocked_hist"] = int(m[3]) if m[3] else None
        elif m := RE_STEP.match(line):
            steps.append([int(v) for v in m[1].split(",")])
    return lat, hfrag, frags, steps, budget, peak, before, after


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("log")
    ap.add_argument("-o", "--out", default="budget_data.py")
    ap.add_argument("--kernel", default="mxfp_gemm_canonical_32t")
    a = ap.parse_args()

    lat, hfrag, frags, steps, budget, peak, before, after = parse(a.log)
    n = lat["nwmma"]
    assert len(hfrag) == len(frags) == len(steps), \
        f"section mismatch: {len(hfrag)} [hist] / {len(frags)} [6] / {len(steps)} steps"

    # [hist] and [6] iterate the same MapVector, so row i is the same fragment;
    # carry the ALAP window over and cross-check the two prints agree.
    for h, f in zip(hfrag, frags):
        assert h["subs"] == f["subs"], f"fragment order differs: {h['subs']} vs {f['subs']}"
        assert h["vgprs"] == f["vgprs"], f"vgprs differ for {f['subs']}"
        assert h["alap"] == f["alap"], f"alap differs for {f['subs']}"
        f["maxpos"], f["latest"] = h["maxpos"], h["latest"]

    hist0 = [before.get(p, 0) for p in range(n)]
    assert max(hist0) == budget, f"budget {budget} is not the peak {max(hist0)} of [5]"

    # Independently replay the debunch and confirm it matches the pass's own
    # hist-step lines. If this ever fires, the animation is lying.
    run = list(hist0)
    for i, f in enumerate(frags):
        for p in range(f["earliest"], f["alap"]):
            run[p] += f["vgprs"]
        assert run == steps[i], f"replay diverges from the pass at fragment {i} ({f['subs']})"
    assert run == [after.get(p, 0) for p in range(n)], "replay does not reach the AFTER histogram"
    assert max(run) == peak <= budget, f"peak {peak} exceeds budget {budget}"

    hist_after = [after.get(p, 0) for p in range(n)]
    fields = ["vgprs", "alap", "earliest", "cmin", "cmax", "maxpos", "clamped",
              "blocked_at", "blocked_hist"]

    if a.out.endswith(".json"):
        import json
        doc = dict(kernel=a.kernel, nwmma=n, wmma_latency=lat["wmma"],
                   load_latency=lat["load"], budget=budget, peak_after=peak,
                   hist_before=hist0, hist_after=hist_after,
                   frags=[{k: f[k] for k in fields} for f in frags],
                   hist_steps=steps)
        with open(a.out, "w") as fh:
            json.dump(doc, fh, separators=(",", ":"))
            fh.write("\n")
    else:
        with open(a.out, "w") as fh:
            fh.write('"""GENERATED by extract-budget-data.py -- do not edit by hand.\n\n'
                     'The VGPR budget derivation for the WMMA DAG mutation, parsed from a\n'
                     '-debug-only=amdgpu-wmma-sched run. HIST_STEPS are the pass\'s own\n'
                     'running histogram after each fragment is placed; the extractor\n'
                     'replays the debunch independently and asserts they match.\n"""\n')
            fh.write(f"KERNEL = {a.kernel!r}\n")
            fh.write(f"NWMMA = {n}\nWMMA_LATENCY = {lat['wmma']}\nLOAD_LATENCY = {lat['load']}\n")
            fh.write(f"BUDGET = {budget}\nPEAK_AFTER = {peak}\n")
            fh.write(f"HIST_BEFORE = {hist0!r}\n")
            fh.write(f"HIST_AFTER = {hist_after!r}\n")
            fh.write("FRAGS = [\n")
            for f in frags:
                fh.write("    dict(" + ", ".join(f"{k}={f[k]!r}" for k in fields) + "),\n")
            fh.write("]\n")
            fh.write(f"HIST_STEPS = {steps!r}\n")

    nc = sum(f["clamped"] for f in frags)
    print(f"wrote {a.out}: {len(frags)} fragments ({nc} clamped, {len(frags)-nc} unconstrained)")
    print(f"  budget {budget} = peak of ALAP; after debunch peak {peak}")
    print(f"  WmmaLatency={lat['wmma']} LoadLatency={lat['load']} WMMAs={n}")
    at = [p for p, v in enumerate(after.get(p, 0) for p in range(n)) if v == budget]
    print(f"  positions pinned at budget after debunch: {len(at)}"
          + (f" (W[{min(at)}..{max(at)}])" if at else ""))
    print(f"{'vgprs':>6}{'alap':>6}{'early':>7}{'consumers':>12}{'blocked':>9}")
    for f in frags:
        b = "-" if f["blocked_at"] is None else f"W[{f['blocked_at']}]"
        cons = "W[{}..{}]".format(f["cmin"], f["cmax"])
        print(f"{f['vgprs']:>6}{f['alap']:>6}{f['earliest']:>7}{cons:>12}{b:>9}")


if __name__ == "__main__":
    main()
