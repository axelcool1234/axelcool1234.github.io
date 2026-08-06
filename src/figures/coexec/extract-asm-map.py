#!/usr/bin/env python3
"""Map each ds_load fragment to the assembly lines it actually occupies.

This is what lets the website highlight a fragment's subloads and the WMMAs
that consume them in the real listing, instead of describing them. It runs
OFFLINE, once, against the 130 MB scheduler logs that only exist on the machine
that produced them; the result is a few KB folded into lifelines-<kernel>.json
and committed alongside the .s files.

Two mappings, both exact, both asserted rather than assumed:

  WMMA index -> line   Every .s file contains exactly `nwmma` v_wmma
                       instructions and they all sit in one hot loop, so W[k]
                       is simply the k-th of them.

  ds_load SU -> line   The i-th ds_load in the scheduler tape is the i-th
                       ds_load in the hot loop. Post-RA scheduling does move
                       loads across WMMA boundaries -- bucketing by "which WMMA
                       gap is it in" disagrees on 7 of 50 gaps for one of the
                       four builds -- but it never reorders the loads among
                       themselves, so a straight in-order pairing holds. The
                       widths are checked pairwise to catch it if that ever
                       stops being true.

Register numbers: GFX1250 addresses more than 256 VGPRs through an MSB set by
s_set_vgpr_msb, and the assembler prints the resolved register as a comment
whenever that MSB is non-zero -- `v[64:67] /*v[320:323]*/`. So the rule is just
"use the comment if there is one, otherwise the literal number", and the bank
state never has to be modelled here.

Usage:
  extract-asm-map.py --data lifelines-canonical.json \
      --tape-off nomut.log --tape-on mut.log \
      --asm-off canonical-NOMUT.s --asm-on canonical-MUT.s \
      -o lifelines-canonical.json
"""
import argparse
import collections
import importlib.util
import json
import os
import re
import sys

REPRO = os.environ.get("REPRO_DIR", "/home/asorenso/work/gfx1250/repro")
HERE = os.path.dirname(os.path.abspath(__file__))

RE_LOOP = re.compile(r"^(\.LBB\d+_\d+):")
RE_DS = re.compile(r"^\s+(ds_load\S*)\s+(.*)")
RE_WMMA = re.compile(r"^\s+(v_wmma\S*)\s+(.*)")
# A register operand, with the assembler's resolved form when the VGPR MSB is
# non-zero. Single registers appear as plain vNN.
RE_REG = re.compile(r"v\[(\d+):(\d+)\](?:\s*/\*v\[(\d+):(\d+)\]\*/)?|v(\d+)(?:\s*/\*v(\d+)\*/)?")


def load_parser(name, path):
    """plot-drains.py sits beside this script; the log parsers live in REPRO."""
    base = HERE if os.path.exists(os.path.join(HERE, path)) else REPRO
    spec = importlib.util.spec_from_file_location(name, os.path.join(base, path))
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def real_range(m):
    """-> (lo, hi) of a register operand, resolving the VGPR MSB comment."""
    if m.group(1) is not None:
        return (int(m.group(3)), int(m.group(4))) if m.group(3) else (int(m.group(1)), int(m.group(2)))
    n = int(m.group(6)) if m.group(6) else int(m.group(5))
    return (n, n)


def tape_ds_order(log):
    """-> ([SU numbers], nwmma) for the hot region, in scheduled order."""
    st = load_parser("sched_tape", "sched-tape.py")
    t = st.Tape()
    t.feed(open(log, errors="replace"))
    t.finish()
    by = collections.Counter(r["region"] for r in t.rows if st.kind(r["op"]) == "wmma")
    region = min(rg for rg, n in by.items() if n == max(by.values()))
    rows = [r for r in t.rows if r["region"] == region]
    ds = [(r["su"], "read2" if "READ2" in r["op"] else "b128")
          for r in rows if st.kind(r["op"]) == "ds"]
    return ds, sum(1 for r in rows if st.kind(r["op"]) == "wmma")


def parse_asm(path):
    """-> dict describing the hot loop: its bounds, its loads and its WMMAs."""
    lines = open(path).read().splitlines()
    labels = {}
    for i, ln in enumerate(lines):
        m = RE_LOOP.match(ln)
        if m:
            labels[m.group(1)] = i
    # the backward branch enclosing the most WMMAs is the hot loop
    best = None
    for i, ln in enumerate(lines):
        m = re.match(r"^\s+s_cbranch\w*\s+(\.LBB\d+_\d+)", ln)
        if m and m.group(1) in labels and labels[m.group(1)] < i:
            a, b = labels[m.group(1)], i
            n = sum(1 for L in lines[a:b] if RE_WMMA.match(L))
            if n and (best is None or n > best[0]):
                best = (n, a, b)
    assert best, f"{path}: no loop containing WMMAs"
    _, a, b = best

    # Every instruction in the loop, in order, with what it defines and what it
    # reads. The def is needed to end a fragment's live range: the registers get
    # reused, and a WMMA reading them afterwards is reading a different value.
    loads, wmmas, insts = [], [], []
    for i in range(a, b):
        ln = lines[i]
        s = ln.strip()
        if s and not s.startswith((".", ";", "//")) and " " in s:
            mn, rest = s.split(None, 1)
            regs = [real_range(r) for r in RE_REG.finditer(rest)]
            if regs:
                # stores and scalar ops define no VGPR; for everything else the
                # first register operand is the destination
                defines = not (mn.startswith("s_") or "store" in mn or mn.startswith("ds_"))
                if mn.startswith("ds_load"):
                    defines = True
                insts.append({
                    "line": i + 1, "mn": mn,
                    "def": regs[0] if defines else None,
                    "srcs": regs[1:] if defines else regs,
                })
        m = RE_DS.match(ln)
        if m:
            regs = list(RE_REG.finditer(m.group(2)))
            assert regs, f"{path}:{i+1}: ds_load with no register operand"
            loads.append({
                "line": i + 1,
                "width": "read2" if "read2" in m.group(1) or "2addr" in ln else "b128",
                "dst": real_range(regs[0]),
            })
            continue
        m = RE_WMMA.match(ln)
        if m:
            regs = [real_range(r) for r in RE_REG.finditer(m.group(2))]
            assert regs, f"{path}:{i+1}: v_wmma with no register operand"
            # operand 0 is the destination; the rest are sources
            wmmas.append({"line": i + 1, "dst": regs[0], "srcs": regs[1:]})
    for k, w in enumerate(wmmas):
        w["index"] = k
    by_line = {w["line"]: w for w in wmmas}
    for ins in insts:
        ins["wmma"] = by_line[ins["line"]]["index"] if ins["line"] in by_line else None
    return {"file": os.path.basename(path), "loop": [a + 1, b + 1],
            "loads": loads, "wmmas": wmmas, "insts": insts}


def overlaps(a, b):
    return a[0] <= b[1] and b[0] <= a[1]


def consumers_of(asm, frag_lines, frag_regs):
    """WMMA indices that read the fragment's registers before they are rewritten.

    Walks forward from the fragment's last subload and stops at the first
    instruction that writes into those registers -- ANY instruction, not just
    another load. The reuse is often a v_mov_b64_e32 shuffling accumulators, and
    only counting ds_loads let the walk run on and collect WMMAs that were
    reading a completely different value out of the same physical registers.

    A WMMA is tested for consumption before its own destination is tested for
    the kill, since it reads its sources before it writes its result.
    """
    last = max(frag_lines)
    out = []
    for ins in asm["insts"]:
        if ins["line"] <= last:
            continue
        if ins["wmma"] is not None and any(
                overlaps(s, r) for s in ins["srcs"] for r in frag_regs):
            out.append(ins["wmma"])
        if ins["def"] is not None and any(overlaps(ins["def"], r) for r in frag_regs):
            break
    return out


def annotate(side_data, asm, tape_ds, nwmma, tag):
    n_t, n_a = len(tape_ds), len(asm["loads"])
    assert n_t == n_a, f"{tag}: {n_t} ds_load in the tape, {n_a} in the asm loop"
    for i, ((su, kt), ld) in enumerate(zip(tape_ds, asm["loads"])):
        assert kt == ld["width"], f"{tag}: ds_load #{i} is {kt} in the tape, {ld['width']} in the asm"
    assert len(asm["wmmas"]) == nwmma, \
        f"{tag}: {len(asm['wmmas'])} v_wmma in the asm loop, {nwmma} in the tape"

    su_line = {su: ld["line"] for (su, _), ld in zip(tape_ds, asm["loads"])}
    by_line = {ld["line"]: ld for ld in asm["loads"]}

    bad = 0
    for bar in side_data["bars"]:
        lines = sorted(su_line[su] for su in bar["key"] if su in su_line)
        assert lines, f"{tag}: fragment {bar['key']} has no subload in the loop"
        bar["lines"] = lines
        regs = [by_line[l]["dst"] for l in lines]
        # 4 VGPRs per b128, 2 per read2 -- must add up to the fragment's width
        width = sum(r[1] - r[0] + 1 for r in regs)
        assert width == bar["vgprs"], \
            f"{tag}: fragment at {lines} covers {width} VGPRs, data says {bar['vgprs']}"
        cons = consumers_of(asm, lines, regs)
        bar["consumers"] = cons
        if not cons or min(cons) != bar["cmin"] or max(cons) != bar["cmax"]:
            bad += 1
            print(f"    {tag}: fragment at {lines} -> consumers {cons[:6]}"
                  f"{'...' if len(cons) > 6 else ''}, expected to bracket "
                  f"W[{bar['cmin']}..{bar['cmax']}]", file=sys.stderr)
    return bad


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--data", required=True)
    ap.add_argument("--tape-off", required=True)
    ap.add_argument("--tape-on", required=True)
    ap.add_argument("--asm-off", required=True)
    ap.add_argument("--asm-on", required=True)
    ap.add_argument("-o", "--out", required=True)
    ap.add_argument("--allow-consumer-mismatch", action="store_true",
                    help="report bracketing failures instead of failing (diagnosis only)")
    a = ap.parse_args()

    doc = json.load(open(a.data))
    bad = 0
    doc["asm"] = {}
    for side, tape_log, asm_path in (("off", a.tape_off, a.asm_off), ("on", a.tape_on, a.asm_on)):
        ds, nwmma = tape_ds_order(tape_log)
        asm = parse_asm(asm_path)
        bad += annotate(doc[side], asm, ds, nwmma, f"{doc['kernel']}/{side}")
        # The LDS wait stalls, from plot-drains.py's DSCNT model, with the line
        # each s_wait_dscnt sits on so the viewer can jump to it. Only the ones
        # inside the hot loop: the model is a linear pass over the whole file,
        # but the figure and the widget are both about the loop.
        pd = load_parser("plot_drains", "plot-drains.py")
        lo, hi = asm["loop"]
        waits = [{"stalled": s, "wmma": w, "line": ln, "ops": ops}
                 for s, _, w, ln, ops in pd.waits(asm_path, with_line=True) if lo <= ln <= hi]
        for w in waits:
            assert len(w["ops"]) == w["stalled"], \
                f"{tag}: wait at line {w['line']} stalls on {w['stalled']} ops but lists {len(w['ops'])}"
        doc["asm"][side] = {
            "file": asm["file"],
            "loop": asm["loop"],
            "wmma": [w["line"] for w in asm["wmmas"]],
            "waits": waits,
        }
        print(f"  {doc['kernel']}/{side}: {asm['file']} loop {asm['loop'][0]}..{asm['loop'][1]}, "
              f"{len(asm['loads'])} loads, {len(asm['wmmas'])} wmma, "
              f"{len(doc[side]['bars'])} fragments mapped")
    if bad and not a.allow_consumer_mismatch:
        raise SystemExit(f"{bad} fragment(s) whose derived consumers do not bracket cmin..cmax")
    json.dump(doc, open(a.out, "w"), indent=1, sort_keys=True)
    print(f"  wrote {a.out}" + (f"  ({bad} consumer mismatches allowed)" if bad else ""))


if __name__ == "__main__":
    main()
