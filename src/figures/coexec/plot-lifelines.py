#!/usr/bin/env python3
"""Draw the thing the ISA listing cannot show: how long each ds_load fragment
sits live, against the WMMA timeline, with the register pressure it causes.

Top panel  : one bar per fragment, from the WMMA index where its first subload
             was issued to the WMMA index of its last consumer. The red/blue
             boundary is the first consumer, so a long red run is a fragment
             held live for nothing.
Bottom panel: the scheduler's own VGPR pressure readout over the same region.

Two columns: mutation off vs on, shared axes, so the difference is visual
rather than tabular.

Usage:
  plot-lifelines.py <off.log> <on.log> -o lifelines.png [--title ...]
"""
import argparse
import importlib.util
import os
import re

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Patch

import plotstyle

_here = os.path.dirname(os.path.abspath(__file__))


def _load(name, path):
    spec = importlib.util.spec_from_file_location(name, os.path.join(_here, path))
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


# Loaded on demand, not at import: these two parse the raw scheduler logs, and
# the JSON path (--data) never needs them -- nor are they shipped alongside the
# figure scripts in the website bundle.
st = el = None


def _load_parsers():
    global st, el
    if st is None:
        st = _load("sched_tape", "sched-tape.py")
        el = _load("early_loads", "early-loads.py")

RE_SCHED = re.compile(r"^Scheduling SU\((\d+)\) (.*)")
RE_PRESS = re.compile(r"^Top Pressure: SReg_32=(\d+) VGPR_32=(\d+)")
RE_BANNER = re.compile(r"^\*+ MI Scheduling \*+")


def pressure_vs_wmma(path, region):
    """VGPR pressure sampled after each pick, x-axis = WMMAs issued so far."""
    reg, last, w, xs, ys = -1, None, 0, [], []
    for ln in open(path, errors="replace"):
        if RE_BANNER.match(ln):
            reg += 1
            continue
        if reg != region:
            continue
        m = RE_SCHED.match(ln)
        if m:
            t = m.group(2)
            op = (t.split("=", 1)[1] if "=" in t else t).split()[0].strip(",")
            last = "wmma" if "WMMA" in op else "other"
            continue
        m = RE_PRESS.match(ln)
        if m and last:
            if last == "wmma":
                w += 1
            xs.append(w)
            ys.append(int(m.group(2)))
            last = None
    return xs, ys


def from_json(doc, which):
    """Same shape as collect(), from the frozen JSON instead of a 100 MB log.

    `key` must come back as a tuple: animate() pairs the two schedules' bars by
    it, and a list would not hash.
    """
    s = doc[which]
    bars = [dict(b, key=tuple(b["key"])) for b in s["bars"]]
    return bars, (s["pressure"]["x"], s["pressure"]["y"]), s["region"], s["budget"]


def collect(path):
    _load_parsers()
    per = el.parse_mutation(path)
    t = st.Tape()
    t.feed(open(path, errors="replace"))
    t.finish()
    from collections import Counter
    byreg = Counter(r["region"] for r in t.rows if st.kind(r["op"]) == "wmma")
    region = min(rg for rg, n in byreg.items() if n == max(byreg.values()))
    minpos, frags, budget = per[region]
    rows = [r for r in t.rows if r["region"] == region]

    # First issue point (in WMMA index) of each fragment, and its consumer span.
    w, first = 0, {}
    for r in rows:
        k = st.kind(r["op"])
        if k == "wmma":
            w += 1
        elif k == "ds" and r["su"] in frags:
            f = frags[r["su"]]
            key = tuple(f["subs"])
            if key not in first:
                first[key] = (w, f)
    bars = []
    for key, (issued, f) in first.items():
        bars.append(dict(key=key, issued=issued, cmin=f["cmin"], cmax=f["cmax"],
                         vgprs=f["vgprs"], clamped=f["clamped"]))
    bars.sort(key=lambda b: (b["cmin"], b["issued"]))
    return bars, pressure_vs_wmma(path, region), region, budget


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("off", nargs="?", help="no-mutation log (omit when using --data)")
    ap.add_argument("on", nargs="?", help="mutation log (omit when using --data)")
    ap.add_argument("--data", metavar="FILE.json",
                    help="frozen data from extract-lifelines-data.py, instead of the logs")
    ap.add_argument("-o", "--out", default="lifelines.png")
    ap.add_argument("--title", default="")
    ap.add_argument("--dark", action="store_true",
                    help="render for a black slide background")
    ap.add_argument("--animate", metavar="OUT.mp4",
                    help="render the morph animation instead of the static chart")
    ap.add_argument("--dpi", type=int, default=300,
                    help="raster resolution; ignored for vector output "
                         "(-o foo.pdf / foo.svg), which never blurs on a slide")
    a = ap.parse_args()

    if a.animate:
        import os
        import re as _re
        still = _re.sub(r"-morph\.(mp4|gif)$", "-still.png", a.animate)
        if still == a.animate:
            still = os.path.splitext(a.animate)[0] + "-still.png"
        doc = None
        title = a.title
        if a.data:
            import figdata
            doc = figdata.load(a.data)
            title = title or doc.get("title", "")
        animate(a.off, a.on, a.animate, title=title, dark=a.dark, still=still, doc=doc)
        return

    P = plotstyle.apply(a.dark)

    data = [("CoExec  -  no mutation", a.off), ("CoExec  +  DAG mutation", a.on)]
    fig, axes = plt.subplots(
        2, 2, figsize=(15, 8.5), sharex="col",
        gridspec_kw=dict(height_ratios=[3, 1], hspace=0.12, wspace=0.09))

    HELD, LIVE, CLAMP = P["held"], P["inuse"], P["clamp"]
    xmax = 0
    for col, (label, path) in enumerate(data):
        bars, (px, py), region, budget = collect(path)
        ax = axes[0][col]
        for i, b in enumerate(bars):
            held = b["cmin"] - b["issued"]          # live but unread
            used = b["cmax"] - b["cmin"]            # genuinely in use
            ax.barh(i, held, left=b["issued"], height=0.75,
                    color=HELD if held > 0 else "none",
                    edgecolor="none", zorder=2)
            ax.barh(i, used, left=b["cmin"], height=0.75,
                    color=CLAMP if b["clamped"] else LIVE,
                    edgecolor="none", zorder=2)
            # No tick at cmin: the red/blue colour change already marks it, and a
            # foreground-coloured hairline there reads as a pale seam between the
            # two segments (very visible on the dark variant).
        ax.set_title(f"{label}\n{len(bars)} fragments", fontsize=11)
        ax.set_ylabel("ds_load fragment" if col == 0 else "")
        ax.set_ylim(-1, len(bars))
        ax.grid(axis="x", alpha=P["grid_alpha"], zorder=0)
        if col:
            ax.set_yticklabels([])

        axp = axes[1][col]
        axp.plot(px, py, lw=1.2, color=P["press"])
        axp.fill_between(px, py, alpha=P["press_alpha"], color=P["press"])
        axp.set_xlabel("WMMAs issued")
        axp.set_ylabel("live VGPRs" if col == 0 else "")
        axp.grid(alpha=P["grid_alpha"])
        if col:
            axp.set_yticklabels([])
        xmax = max(xmax, max(px) if px else 0)

    for col in (0, 1):
        axes[0][col].set_xlim(0, xmax)
        axes[1][col].set_xlim(0, xmax)
    # Zoom the pressure axis to the data range. Anchoring at 0 makes a 90-VGPR
    # sustained difference look like nothing, which is the whole point of the panel.
    ys = [y for c in (0, 1) for y in axes[1][c].lines[0].get_ydata()]
    lo, hi = min(ys), max(ys)
    pad = max(8, (hi - lo) * 0.12)
    for c in (0, 1):
        axes[1][c].set_ylim(lo - pad, hi + pad)

    fig.legend(handles=[
        Patch(color=HELD, label="held live but not yet read"),
        Patch(color=LIVE, label="in use (first to last consumer)"),
        Patch(color=CLAMP, label="in use (first to last consumer), gained a WMMA -> ds_load edge"),
    ], loc="lower center", ncol=3, frameon=False, fontsize=10,
        bbox_to_anchor=(0.5, -0.005))

    if a.title:
        fig.suptitle(a.title, fontsize=13, y=0.985)
    fig.tight_layout(rect=(0, 0.045, 1, 0.97))
    fig.savefig(a.out, dpi=a.dpi, facecolor=fig.get_facecolor())
    print(f"wrote {a.out}")




# --------------------------------------------------------------------------
# Animated build: ONE panel that morphs from the no-mutation schedule into the
# mutated one. Same data and styling as the static two-panel chart, but the
# before/after lands in the same retinal position instead of asking the viewer
# to eye-travel between panels.
#
# Consumers do not move -- only the issue point does -- so the blue "in use"
# segment is identical in both schedules and ONLY the red held-unread segment
# shrinks. Grey ghosts sit at each fragment's original red extent, so the
# coloured bar starts flush against its ghost and uncovers it as it slides.
# --------------------------------------------------------------------------
def animate(off_log, on_log, out, title="", dark=False, dpi=200, fps=30,
            still=None, doc=None):
    import numpy as np
    from matplotlib.animation import FuncAnimation, FFMpegWriter
    from matplotlib.patches import Rectangle

    P = plotstyle.apply(dark)
    if doc is not None:
        a_bars, (apx, apy), _, _ = from_json(doc, "off")
        b_bars, (bpx, bpy), _, _ = from_json(doc, "on")
    else:
        a_bars, (apx, apy), _, _ = collect(off_log)
        b_bars, (bpx, bpy), _, _ = collect(on_log)
    b_by_key = {b["key"]: b for b in b_bars}
    pairs = [(a, b_by_key[a["key"]]) for a in a_bars if a["key"] in b_by_key]
    moved = sum(1 for a, b in pairs if b["issued"] != a["issued"])

    xmax = max(max(apx or [0]), max(bpx or [0]))
    fig, (ax, axp) = plt.subplots(
        2, 1, figsize=(13, 7.4), sharex=True,
        gridspec_kw=dict(height_ratios=[3, 1], hspace=0.12))

    HELD, LIVE, CLAMP = P["held"], P["inuse"], P["clamp"]
    for i, (a, b) in enumerate(pairs):                       # ghosts: where it was
        ax.add_patch(Rectangle((a["issued"], i - 0.38), a["cmin"] - a["issued"], 0.75,
                               facecolor=P["fg"], alpha=0.28, linewidth=0, zorder=1))
    reds = []
    for i, (a, b) in enumerate(pairs):
        ax.add_patch(Rectangle((a["cmin"], i - 0.38), a["cmax"] - a["cmin"], 0.75,
                               facecolor=CLAMP if a["clamped"] else LIVE,
                               linewidth=0, zorder=3))       # blue never moves
        r = Rectangle((a["issued"], i - 0.38), a["cmin"] - a["issued"], 0.75,
                      facecolor=HELD, linewidth=0, zorder=2)
        ax.add_patch(r)
        reds.append(r)

    ax.set_xlim(0, xmax)
    ax.set_ylim(-1, len(pairs))
    ax.set_ylabel("ds_load fragment")
    ax.grid(axis="x", alpha=P["grid_alpha"], zorder=0)

    grid = np.linspace(0, xmax, 400)
    ay = np.interp(grid, apx, apy)
    by = np.interp(grid, bpx, bpy)
    # ghost of the un-mutated pressure curve, same device as the bar ghosts:
    # the live curve drops away from it so the reduction is visible in place
    axp.fill_between(grid, ay, color=P["fg"], alpha=0.22, linewidth=0, zorder=1)
    axp.plot(grid, ay, lw=1.0, color=P["fg"], alpha=0.45, zorder=2)
    (line,) = axp.plot(grid, ay, lw=1.4, color=P["press"], zorder=4)
    fillc = [axp.fill_between(grid, ay, alpha=P["press_alpha"], color=P["press"],
                              zorder=3)]
    axp.set_xlabel("WMMAs issued")
    axp.set_ylabel("live VGPRs")
    axp.grid(alpha=P["grid_alpha"])
    lo, hi = min(ay.min(), by.min()), max(ay.max(), by.max())
    pad = max(8, (hi - lo) * 0.12)
    axp.set_ylim(lo - pad, hi + pad)

    head = ax.set_title("", fontsize=12)
    if title:
        fig.suptitle(title, fontsize=13, y=0.985)
    fig.legend(handles=[
        Patch(color=HELD, label="held live but not yet read"),
        Patch(color=LIVE, label="in use (first to last consumer)"),
        Patch(color=CLAMP, label="in use (first to last consumer), gained a WMMA -> ds_load edge"),
    ], loc="lower center", ncol=3, frameon=False, fontsize=10,
        bbox_to_anchor=(0.5, -0.004))
    fig.tight_layout(rect=(0, 0.05, 1, 0.96))

    HOLD_A, MORPH, HOLD_B = 24, 54, 42

    def ease(t):                       # smoothstep, so it settles rather than stops
        return t * t * (3 - 2 * t)

    def frame(n):
        if n < HOLD_A:
            u = 0.0
        elif n < HOLD_A + MORPH:
            u = ease((n - HOLD_A) / MORPH)
        else:
            u = 1.0
        for r, (a, b) in zip(reds, pairs):
            issued = a["issued"] + (b["issued"] - a["issued"]) * u
            r.set_x(issued)
            r.set_width(max(a["cmin"] - issued, 0))
        y = ay + (by - ay) * u
        line.set_ydata(y)
        fillc[0].remove()
        fillc[0] = axp.fill_between(grid, y, alpha=P["press_alpha"],
                                    color=P["press"], zorder=3)
        head.set_text("CoExec  -  no mutation" if u < 0.5 else
                      "CoExec  +  DAG mutation")
        head.set_color(P["fg"])
        return ()

    if still:
        frame(0)                       # lossless slide-1 image, straight from matplotlib
        fig.savefig(still, dpi=dpi, facecolor=fig.get_facecolor())
        print(f"wrote {still}")

    # Flat saturated red on black is the worst case for 4:2:0 chroma subsampling;
    # at the default bitrate it mottles and visibly loses vibrance against the
    # static PNG. CRF 14 keeps the flat fills essentially exact. yuv420p is kept
    # for player compatibility (yuv444p would be cleaner but risks PowerPoint).
    anim = FuncAnimation(fig, frame, frames=HOLD_A + MORPH + HOLD_B, interval=1000 / fps)
    if out.endswith(".gif"):
        # These charts use a handful of flat colours, so a 256-entry palette is
        # exact -- no chroma subsampling, no mottling of the saturated red.
        from matplotlib.animation import PillowWriter
        anim.save(out, writer=PillowWriter(fps=fps),
                  savefig_kwargs=dict(facecolor=fig.get_facecolor()), dpi=dpi)
        # Two PillowWriter behaviours to undo:
        #  * it hard-codes loop=0, so the chart would keep snapping back to the
        #    un-mutated state mid-discussion;
        #  * PIL's GIF encoder merges identical consecutive frames AND discards
        #    their duration, so the opening and closing holds vanish and the
        #    morph starts the instant the slide appears.
        # Re-timing the surviving first/last frames restores both holds in far
        # fewer frames. Frames stay in palette mode, so colours are untouched.
        from PIL import Image as _I
        src = _I.open(out)
        fr = []
        try:
            while True:
                fr.append(src.copy())
                src.seek(src.tell() + 1)
        except EOFError:
            pass
        for f_ in fr:
            f_.info.pop("loop", None)          # omit the Netscape loop block
        step = int(1000 / fps)
        dur = [step] * len(fr)
        dur[0] = int(HOLD_A * 1000 / fps)
        dur[-1] = int(HOLD_B * 1000 / fps)
        fr[0].save(out, save_all=True, append_images=fr[1:], duration=dur, disposal=1)
        print(f"wrote {out}  ({len(pairs)} fragments, {moved} move, "
              f"{len(fr)} frames, holds {dur[0]}/{dur[-1]} ms, plays once)")
        return
    anim.save(out, writer=FFMpegWriter(
                  fps=fps, codec="libx264", bitrate=-1,
                  extra_args=["-crf", "14", "-preset", "slow", "-pix_fmt", "yuv420p"]),
              savefig_kwargs=dict(facecolor=fig.get_facecolor()), dpi=dpi)
    print(f"wrote {out}  ({len(pairs)} fragments, {moved} move)")


if __name__ == "__main__":
    main()
