#!/usr/bin/env python3
"""Distil the CoExec scheduler's own debug stream into one row per pick.

The scheduler already prints everything needed; it is just buried. This reads
`-debug-only=machine-scheduler` output (stdin or a file) and emits a compact
tape:

  step cycle picked                 flavor reason           readyQ ds/wmma/oth  runner-up
     7     3 DS_READ_B128_gfx9 SU34 DS     Stall                   18/8/3       V_WMMA SU120

plus a rollup: which heuristic decided each pick, and — the number that matters
for the argument — how many times a ds_load beat a WMMA, broken down by the
heuristic that made the call.

Nothing here modifies the scheduler. Every field is parsed out of the stock
LLVM_DEBUG output of an unmodified AMDGPUCoExecSchedStrategy.cpp, which is the
point: the numbers are the maintainers' own scheduler talking.

Usage:
  llc ... -debug-only=machine-scheduler ... 2>&1 | sched-tape.py
  sched-tape.py trace.log --max 60
  sched-tape.py trace.log --only-ds-beats-wmma
"""
import argparse
import re
import sys
from collections import Counter

RE_STAGE = re.compile(r"^Starting scheduling stage: (.*)")
RE_REGION = re.compile(r"^\*+ MI Scheduling \*+")
RE_REGION_HDR = re.compile(r"^(\S+):(%bb\.\S+)")
RE_REGION_N = re.compile(r"^\s*RegionInstrs: (\d+)")
RE_PICK = re.compile(r"^=== Pick @ Cycle (\d+) ===")
RE_PICKED = re.compile(r"^Picked: SU\((\d+)\) (.*)")
RE_REASON = re.compile(r"^  Reason: (.*)")
# Authoritative pick record: printed for EVERY scheduled node, including the ones
# taken by pickOnlyChoice (which never reach dumpPickSummary, so they have no
# '=== Pick @ Cycle ===' block and no heuristic reason).
RE_SCHEDULING = re.compile(r"^Scheduling SU\((\d+)\) (.*)")
RE_CYCLE = re.compile(r"^Cycle: (\d+)")
RE_QUEUE = re.compile(r"^Queue TopQ\.([AP]): (.*)")
RE_SU_TEXT = re.compile(r"^(?:Prefer:|Not:)\s+SU\((\d+)\):\s+(.*)")
RE_FLAVOR = re.compile(r"\[([A-Za-z0-9_()]+)\]\s*$")
RE_CMP = re.compile(r"^Reason:\s+Cand SU\((\d+)\) (.*?)\s*$")


def opcode(text):
    """Best-effort opcode from a printed MachineInstr."""
    t = text.split(";")[0].strip()
    rhs = t.split("=", 1)[1].strip() if "=" in t else t
    tok = rhs.split()[0] if rhs.split() else "?"
    return tok.strip(",")


def short(op, width=20):
    """Abbreviate an opcode for display. The gfx1250 WMMA mnemonics
    (V_WMMA_SCALE_F32_16X16X128_F8F6F4_f8_f8_w32_twoaddr) are 50 chars and blow
    the row width; nothing downstream keys off the display form."""
    return op if len(op) <= width else op[:width - 1] + "…"


def kind(op):
    if op.startswith("DS_READ") or op.startswith("DS_LOAD"):
        return "ds"
    if "WMMA" in op or "MFMA" in op:
        return "wmma"
    return "oth"


class Tape:
    """SU numbers restart at 0 in every scheduling region, so the SU -> text map
    must be reset at each '******* MI Scheduling *******' banner. Rows carry the
    region index so the two are never mixed up downstream."""

    def __init__(self):
        self.text = {}       # SU num -> printed instruction (current region only)
        self.rows = []
        self.queue = []      # last seen Available queue (SU numbers)
        self.regions = []    # per-region (label, instr count)
        self.region = -1
        self.stage = "(pre-stage)"

    def feed(self, lines):
        cycle = None
        pending = None
        want_hdr = False
        for ln in lines:
            m = RE_STAGE.match(ln)
            if m:
                self.stage = m.group(1).strip()
                continue
            if RE_REGION.match(ln):
                self.region += 1
                self.text, self.queue = {}, []
                self.regions.append(["?", 0])
                want_hdr = True
                continue
            if want_hdr:
                m = RE_REGION_HDR.match(ln)
                if m:
                    self.regions[-1][0] = f"{m.group(1)}:{m.group(2)}"
                    want_hdr = False
            m = RE_REGION_N.match(ln)
            if m and self.regions:
                self.regions[-1][1] = int(m.group(1))

            m = RE_SU_TEXT.match(ln)
            if m:
                self.text.setdefault(int(m.group(1)), m.group(2))
                continue

            m = RE_QUEUE.match(ln)
            if m and m.group(1) == "A":
                self.queue = [int(x) for x in m.group(2).split() if x.isdigit()]
                continue

            m = RE_PICK.match(ln)
            if m:
                cycle = int(m.group(1))
                continue

            m = RE_PICKED.match(ln)
            if m:
                su, body = int(m.group(1)), m.group(2)
                fl = RE_FLAVOR.search(body)
                flavor = fl.group(1) if fl else "?"
                body = RE_FLAVOR.sub("", body).strip()
                self.text.setdefault(su, body)
                pending = dict(cycle=cycle, su=su, op=opcode(body),
                               flavor=flavor, queue=list(self.queue),
                               region=self.region, stage=self.stage)
                continue

            m = RE_REASON.match(ln)
            if m and pending is not None:
                pending["reason"] = m.group(1).strip()
                continue

            m = RE_CYCLE.match(ln)
            if m:
                cycle = int(m.group(1))
                continue

            # One row per actually-scheduled node. If no candidate comparison
            # preceded it, the node was forced (pickOnlyChoice) -- the DAG left
            # the scheduler no decision to make.
            m = RE_SCHEDULING.match(ln)
            if m:
                su, body = int(m.group(1)), m.group(2)
                if pending is not None and pending["su"] == su:
                    row = pending
                else:
                    self.text.setdefault(su, body)
                    row = dict(cycle=cycle, su=su, op=opcode(body), flavor="",
                               queue=list(self.queue), region=self.region,
                               stage=self.stage, reason="OnlyChoice")
                row.setdefault("reason", "?")
                # Classify the ready queue now, while this region's SU -> text
                # map is still the live one (it is cleared at the next region).
                self._classify(row)
                self.rows.append(row)
                pending = None

    def _classify(self, r):
        q = r["queue"]
        kinds = {s: kind(opcode(self.text.get(s, "?"))) for s in q}
        counts = Counter(kinds.values())
        r["nds"], r["nwmma"], r["noth"] = (
            counts["ds"], counts["wmma"], counts["oth"])
        r["unknown"] = sum(1 for s in q if s not in self.text)
        wm = [s for s in q if kinds[s] == "wmma" and s != r["su"]]
        r["runner"] = f"{short(opcode(self.text[wm[0]]))} SU{wm[0]}" if wm else ""
        r["ds_beat_wmma"] = kind(r["op"]) == "ds" and bool(wm)

    def finish(self):
        for i, r in enumerate(self.rows):
            r["step"] = i


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("log", nargs="?", help="trace file (default: stdin)")
    ap.add_argument("--max", type=int, default=0, help="print only the first N picks")
    ap.add_argument("--only-ds-beats-wmma", action="store_true",
                    help="print only picks where a ds_load won with WMMAs waiting")
    ap.add_argument("--no-rollup", action="store_true")
    ap.add_argument("--regions", action="store_true",
                    help="list scheduling regions (index, stage, label, picks) and exit")
    ap.add_argument("--region", type=int, default=None,
                    help="restrict output to one region index (see --regions)")
    ap.add_argument("--stage", default=None,
                    help="restrict output to one scheduling stage (substring match)")
    ap.add_argument("--only-ds-wmma", action="store_true",
                    help="print only ds_load and WMMA picks")
    ap.add_argument("--lw-tape", action="store_true",
                    help="print just the L/W pick-order string (L=ds_load, W=WMMA)")
    a = ap.parse_args()

    src = open(a.log, errors="replace") if a.log else sys.stdin
    t = Tape()
    t.feed(src)
    t.finish()

    if a.regions:
        seen = {}
        for r in t.rows:
            k = (r["region"], r.get("stage", "?"))
            d = seen.setdefault(k, dict(picks=0, ds=0, wmma=0))
            d["picks"] += 1
            if kind(r["op"]) == "ds":
                d["ds"] += 1
            elif kind(r["op"]) == "wmma":
                d["wmma"] += 1
        print(f"{'idx':>4} {'picks':>6} {'ds':>5} {'wmma':>5}  {'label':<28} stage")
        for (ridx, stage), d in sorted(seen.items()):
            label = t.regions[ridx][0] if 0 <= ridx < len(t.regions) else "?"
            print(f"{ridx:>4} {d['picks']:>6} {d['ds']:>5} {d['wmma']:>5}  "
                  f"{label:<28} {stage}")
        return

    rows = t.rows
    if a.region is not None:
        rows = [r for r in rows if r["region"] == a.region]
    if a.stage:
        rows = [r for r in rows if a.stage.lower() in r.get("stage", "").lower()]
    if a.only_ds_beats_wmma:
        rows = [r for r in rows if r["ds_beat_wmma"]]
    if a.only_ds_wmma:
        rows = [r for r in rows if kind(r["op"]) in ("ds", "wmma")]

    if a.lw_tape:
        print("".join("L" if kind(r["op"]) == "ds" else "W"
                      for r in rows if kind(r["op"]) in ("ds", "wmma")))
        return

    shown = rows[:a.max] if a.max else rows

    hdr = (f"{'step':>5} {'cyc':>5} {'picked':<26} {'flavor':<8} "
           f"{'reason':<18} {'ds/wmma/oth':>12}  runner-up")
    print(hdr)
    print("-" * len(hdr))
    for r in shown:
        pick = f"{short(r['op'])} SU{r['su']}"
        # No spaces inside the ds/wmma/oth triple: it keeps the row parseable by
        # awk '$7' and friends, which is how these get post-processed.
        q = f"{r['nds']}/{r['nwmma']}/{r['noth']}"
        print(f"{r['step']:>5} {r['cycle']:>5} {pick:<26} {r['flavor']:<8} "
              f"{r.get('reason','?'):<18} {q:>12}  {r['runner']}")
    if a.max and len(rows) > a.max:
        print(f"... {len(rows) - a.max} more picks (raise --max to see them)")

    if a.no_rollup:
        return
    print(f"\n{len(t.rows)} picks total")
    print("\nreason histogram (all picks):")
    for reason, n in Counter(r.get("reason", "?") for r in t.rows).most_common():
        print(f"  {reason:<22} {n:>5}")

    beats = [r for r in t.rows if r["ds_beat_wmma"]]
    print(f"\nds_load picked while >=1 WMMA sat in the ready queue: "
          f"{len(beats)} / {len(t.rows)} picks")
    if beats:
        print("  by deciding heuristic:")
        for reason, n in Counter(r.get("reason", "?") for r in beats).most_common():
            print(f"    {reason:<22} {n:>5}")


if __name__ == "__main__":
    main()
