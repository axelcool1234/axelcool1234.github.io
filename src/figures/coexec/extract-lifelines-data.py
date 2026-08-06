#!/usr/bin/env python3
"""Freeze the lifelines figure's inputs as JSON, so the plot no longer needs the logs.

plot-lifelines.py reads the raw -debug-only=machine-scheduler streams, which run
24-108 MB apiece and cannot live in a git repo. Everything it actually uses out
of them is tiny: one record per ds_load fragment, plus the scheduler's own
VGPR_32 pressure readout sampled per pick. That is a few hundred numbers.

This distils exactly what plot-lifelines.animate() consumes -- no more, so the
JSON cannot drift into carrying claims the figure does not make:

    bars      one per fragment: the subload SUs that identify it (key), the WMMA
              index it was issued at, its first/last consumer, its VGPR width,
              and whether the mutation gave it an edge
    pressure  (x, y) = WMMAs issued so far, live VGPRs, straight from the
              scheduler's "Top Pressure: ... VGPR_32=" lines

Both schedules are captured in one file, since the figure is a morph between
them and they must come from the same extraction to be comparable.

Usage:
  extract-lifelines-data.py <nomut.log> <mut.log> -o lifelines-<kernel>.json \
      --kernel mxfp_gemm_canonical_32t [--title "..."]
"""
import argparse
import importlib.util
import json
import os

HERE = os.path.dirname(os.path.abspath(__file__))


def _load(name, filename):
    """Import a sibling script whose filename isn't a valid module name."""
    spec = importlib.util.spec_from_file_location(name, os.path.join(HERE, filename))
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


def side(pl, path):
    """One schedule's contribution, via plot-lifelines' own collect()."""
    bars, (px, py), region, budget = pl.collect(path)
    return dict(
        region=region,
        budget=budget,
        bars=[dict(key=list(b["key"]), issued=b["issued"], cmin=b["cmin"],
                   cmax=b["cmax"], vgprs=b["vgprs"], clamped=bool(b["clamped"]))
              for b in bars],
        pressure=dict(x=[int(v) for v in px], y=[int(v) for v in py]),
    )


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("nomut")
    ap.add_argument("mut")
    ap.add_argument("-o", "--out", required=True)
    ap.add_argument("--kernel", required=True)
    ap.add_argument("--title", default="")
    a = ap.parse_args()

    pl = _load("plot_lifelines", "plot-lifelines.py")
    off, on = side(pl, a.nomut), side(pl, a.mut)

    # The figure pairs fragments across the two schedules by their subload tuple;
    # if a fragment only exists on one side the morph would silently drop it, so
    # say so here rather than let the plot quietly show fewer bars.
    koff = {tuple(b["key"]) for b in off["bars"]}
    kon = {tuple(b["key"]) for b in on["bars"]}
    if koff != kon:
        raise SystemExit(f"fragment sets differ: {len(koff - kon)} only in no-mut, "
                         f"{len(kon - koff)} only in mut -- the morph would drop them")
    if off["budget"] != on["budget"]:
        raise SystemExit(f"budget differs between schedules: {off['budget']} vs {on['budget']}")

    doc = dict(kernel=a.kernel,
               title=a.title or f"{a.kernel} - ds_load fragment live ranges vs WMMAs scheduled in order",
               budget=off["budget"], off=off, on=on)
    with open(a.out, "w") as fh:
        json.dump(doc, fh, separators=(",", ":"))
        fh.write("\n")

    moved = sum(1 for b in off["bars"]
                if b["issued"] != next(x for x in on["bars"] if x["key"] == b["key"])["issued"])
    clamped = sum(b["clamped"] for b in on["bars"])
    print(f"wrote {a.out}  ({os.path.getsize(a.out) / 1024:.1f} KB)")
    print(f"  {len(off['bars'])} fragments, {moved} move, {clamped} gained an edge")
    print(f"  budget {off['budget']} VGPRs, regions off={off['region']} on={on['region']}")
    print(f"  pressure samples: off={len(off['pressure']['x'])} on={len(on['pressure']['x'])}, "
          f"VGPR_32 off {min(off['pressure']['y'])}-{max(off['pressure']['y'])} "
          f"on {min(on['pressure']['y'])}-{max(on['pressure']['y'])}")


if __name__ == "__main__":
    main()
