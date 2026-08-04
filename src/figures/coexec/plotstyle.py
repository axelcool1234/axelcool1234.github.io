"""Shared light/dark theming for the scheduler charts.

Kept in one place so the two plot scripts can't drift apart, and so a dark
variant is a flag rather than a fork (same reason gen_dag_edges.py takes --dark
instead of being copied).

On a black slide the lightness relationships invert: fills that read as "solid
object" on white become lamps on black, and the dark-blue accent sinks into the
background. So the accents move to their brighter tints and the two blues are
pushed further apart (pale vs vivid) to stay distinguishable.
"""
import matplotlib as mpl

LIGHT = dict(
    bg="#ffffff",
    fg="#111827",          # axis labels, titles, annotation text
    grid="#111827",
    grid_alpha=0.25,
    held="#dc2626",        # live but not yet read
    inuse="#93c5fd",       # in use
    clamp="#1d4ed8",       # in use, gained a WMMA -> ds_load edge
    stall="#dc2626",       # drains: ops waited on
    cover="#1d4ed8",       # drains: cycles available to cover
    press="#b45309",       # pressure curve
    press_alpha=0.18,
)

DARK = dict(
    bg="#000000",
    fg="#e5e7eb",
    grid="#9ca3af",
    grid_alpha=0.22,
    held="#ef4444",
    inuse="#bfdbfe",       # pale blue, pushed lighter
    clamp="#3b82f6",       # vivid blue, pushed brighter
    stall="#ef4444",
    cover="#3b82f6",
    press="#fbbf24",
    press_alpha=0.22,
)


def apply(dark):
    """Set rcParams for the chosen theme and return its palette."""
    p = DARK if dark else LIGHT
    mpl.rcParams.update({
        "figure.facecolor": p["bg"],
        "savefig.facecolor": p["bg"],
        "axes.facecolor": p["bg"],
        "axes.edgecolor": p["fg"],
        "axes.labelcolor": p["fg"],
        "text.color": p["fg"],
        "xtick.color": p["fg"],
        "ytick.color": p["fg"],
        "grid.color": p["grid"],
    })
    return p
