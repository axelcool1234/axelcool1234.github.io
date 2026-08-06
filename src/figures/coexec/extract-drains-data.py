#!/usr/bin/env python3
"""Freeze the drains figure's inputs as JSON, so the plot no longer needs the .s files.

plot-drains.py runs a DSCNT model over the emitted assembly and reduces each
listing to one record per s_wait_dscnt. The listings are 532 KB of assembly for
what ends up being a few dozen triples, so the model is run once here and only
its output is kept.

Each record is (ops_waited_on, wmmas_in_interval, cumulative_wmmas), exactly
what plot-drains.waits() returns and animate() consumes.

One row per kernel, in the stacking order the figure uses (top row first).

Usage:
  extract-drains-data.py -o drains.json \
      --row "f16_bm256_bk256:f16-NOMUT.s:f16-MUT.s" \
      --row "mxfp_gemm_canonical_32t:canonical-NOMUT.s:canonical-MUT.s"
"""
import argparse
import importlib.util
import json
import os

HERE = os.path.dirname(os.path.abspath(__file__))


def _load(name, filename):
    spec = importlib.util.spec_from_file_location(name, os.path.join(HERE, filename))
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("-o", "--out", required=True)
    ap.add_argument("--row", action="append", required=True,
                    metavar="LABEL:OFF.s:ON.s",
                    help="one stacked row per kernel, top row first")
    ap.add_argument("--title", default="")
    a = ap.parse_args()

    pd = _load("plot_drains", "plot-drains.py")
    rows = []
    for spec in a.row:
        label, off_s, on_s = spec.rsplit(":", 2)
        A, B = pd.waits(off_s), pd.waits(on_s)
        # Every DS op must be waited for exactly once, so the totals are equal by
        # construction -- that invariant is the figure's whole point, so check it
        # here rather than let a broken parse quietly redraw the story.
        ta, tb = sum(v for v, _, _ in A), sum(v for v, _, _ in B)
        if ta != tb:
            raise SystemExit(f"{label}: total waited-on differs, {ta} vs {tb} -- "
                             f"the DSCNT model or the input is wrong")
        rows.append(dict(label=label, off=A, on=B))

    doc = dict(title=a.title, rows=rows)
    with open(a.out, "w") as fh:
        json.dump(doc, fh, separators=(",", ":"))
        fh.write("\n")

    print(f"wrote {a.out}  ({os.path.getsize(a.out) / 1024:.1f} KB)")
    for r in rows:
        na, nb = len(r["off"]), len(r["on"])
        tot = sum(v for v, _, _ in r["off"])
        mx_a = max(v for v, _, _ in r["off"])
        mx_b = max(v for v, _, _ in r["on"])
        print(f"  {r['label']:26} waits {na:3} -> {nb:3}   total waited-on {tot:4} "
              f"(identical)   largest single wait {mx_a:3} -> {mx_b:3}")


if __name__ == "__main__":
    main()
