"""Shim: the clamped-fragment data now lives in data/sched-data.json.

Kept as a module so the manim scenes can go on saying `import sched_data` and
`sched_data.CLAMPED` -- those scenes are the approved talk animations and there
was no reason to touch them when the data moved to JSON.

Regenerate with:
  extract-anim-data.py <nomut.log> <mut.log> -o data/sched-data.json
"""
from figdata import load

_d = load("sched-data.json")

KERNEL = _d["kernel"]
WMAX = _d["wmax"]
CLAMPED = _d["clamped"]
