#!/usr/bin/env python3
"""The results slide: four metrics, two kernels, morphing from no-mutation to
mutation -- the same device as the lifelines and drains morphs.

Two bars per panel (one per kernel); the before/after is the animation, not a
second pair of bars. Grey ghosts mark where each bar started, plus a grey cap
line at the original height so the reference stays visible even for the metrics
that go UP (XDL) and would otherwise hide their own ghost behind the new bar.

Every number is measured, not quoted:
  XDL% and dispatch cycles  AM report.html  (artifact output/<ts>/<cfg>/<kernel>)
  vgpr_spill_count          kernel.amdgcn metadata
  hide                      the artifact's own scripts/analyze_asm.py

Usage:
  plot-results.py -o results-morph.gif [--dark]      # animation + matching still
  plot-results.py -o results.png       [--dark]      # static (no-mutation state)
"""
import argparse
import os
import re
import sys

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.patheffects as pe
import numpy as np

# plotstyle.py sits beside this script in the site bundle, and in repro/ in the
# lab; probe rather than hardcode so the same file works unpacked anywhere.
for _p in (os.path.dirname(os.path.abspath(__file__)),
           "/home/asorenso/work/gfx1250/repro"):
    if os.path.exists(os.path.join(_p, "plotstyle.py")):
        sys.path.insert(0, _p)
        break
import plotstyle

import figdata

_D = figdata.load("results.json")
XT = _D["kernels"]
#  title, off=[canon, f16], on=[canon, f16], scale, fmt, caption
PANELS = [(q["title"], q["off"], q["on"], q["scale"], q["fmt"], q["caption"])
          for q in _D["panels"]]

HOLD_A, MORPH, HOLD_B, FPS = 24, 54, 42, 30


def ease(t):
    return t * t * (3 - 2 * t)


def build(dark):
    P = plotstyle.apply(dark)
    fig, axes = plt.subplots(1, 4, figsize=(15.5, 5.5))
    x = np.arange(2)
    w = 0.46
    bars, labels, caps = [], [], []

    for ax, (title, off, on, scale, fmt, cap) in zip(axes, PANELS):
        if scale == "log":
            ax.set_yscale("log")
            ax.set_ylim(1e4, max(off) * 3.0)
            base = 1e4
        else:
            top = max(off + on)
            ax.set_ylim(0, (top if top else 1) * 1.32)
            base = 0
        ax.bar(x, off, w, color=P["fg"], alpha=0.30, zorder=1)          # ghost body
        b = ax.bar(x, off, w, color=P["clamp"], zorder=2)               # live bars
        for xi, v in zip(x, off):                                       # ghost cap
            ax.plot([xi - w / 2, xi + w / 2], [v, v], color=P["fg"],
                    lw=1.6, alpha=0.75, zorder=4, solid_capstyle="butt")
        lab = [ax.annotate("", (xi, v), textcoords="offset points",
                           xytext=(0, 5), ha="center", fontsize=10.5,
                           color=P["fg"], zorder=6,
                           path_effects=[pe.withStroke(linewidth=3.0,
                                                       foreground=P["bg"])])
               for xi, v in zip(x, off)]
        ax.set_title(title, fontsize=11, pad=10)
        ax.set_xticks(x)
        ax.set_xticklabels(XT, fontsize=9.5)
        ax.grid(axis="y", alpha=P["grid_alpha"])
        ax.set_axisbelow(True)
        caps.append(ax.set_xlabel("", fontsize=10.5, color=P["fg"], labelpad=8))
        bars.append((b, off, on, fmt, base))
        labels.append(lab)

    sub = fig.text(0.5, 0.905, "", ha="center", fontsize=12.5, color=P["fg"])
    fig.suptitle("Additional Stats", fontsize=13.5, y=0.975)
    # No legend: the subtitle already says which state is showing, and the grey
    # ghost reads as "before" from the motion alone.
    fig.tight_layout(rect=(0, 0.04, 1, 0.90))

    def frame(u):
        for (b, off, on, fmt, base), lab in zip(bars, labels):
            for r, o, n, t in zip(b, off, on, lab):
                v = o + (n - o) * u
                r.set_height(max(v - base, 0) if base else v)
                if base:
                    r.set_y(base)
                t.set_text(fmt.format(v))
                t.xy = (r.get_x() + r.get_width() / 2, v)
        for c, (_t, _o, _n, _s, _f, cap) in zip(caps, PANELS):
            c.set_text(cap if u > 0.98 else "")
        sub.set_text("CoExec  -  no mutation" if u < 0.5 else "CoExec  +  DAG mutation")
        return ()

    return fig, frame


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("-o", "--out", default="results-morph.gif")
    ap.add_argument("--dark", action="store_true")
    ap.add_argument("--dpi", type=int, default=200)
    a = ap.parse_args()

    fig, frame = build(a.dark)
    if not a.out.endswith((".gif", ".mp4")):
        frame(0.0)
        fig.savefig(a.out, dpi=a.dpi, facecolor=fig.get_facecolor())
        print(f"wrote {a.out}")
        return

    from matplotlib.animation import FuncAnimation, PillowWriter
    still = re.sub(r"-morph\.(gif|mp4)$", "-still.png", a.out)
    if still == a.out:
        still = os.path.splitext(a.out)[0] + "-still.png"
    frame(0.0)
    fig.savefig(still, dpi=a.dpi, facecolor=fig.get_facecolor())
    print(f"wrote {still}")

    n_total = HOLD_A + MORPH + HOLD_B

    def by_index(n):
        if n < HOLD_A:
            return frame(0.0)
        if n < HOLD_A + MORPH:
            return frame(ease((n - HOLD_A) / MORPH))
        return frame(1.0)

    anim = FuncAnimation(fig, by_index, frames=n_total, interval=1000 / FPS)
    if a.out.endswith(".mp4"):
        # Same encoder settings plot-lifelines.py uses and documents: CRF 14 keeps
        # the flat saturated red exact, where the default bitrate mottles it.
        from matplotlib.animation import FFMpegWriter
        anim.save(a.out, writer=FFMpegWriter(
                      fps=FPS, codec="libx264", bitrate=-1,
                      extra_args=["-crf", "14", "-preset", "slow", "-pix_fmt", "yuv420p"]),
                  savefig_kwargs=dict(facecolor=fig.get_facecolor()), dpi=a.dpi)
        print(f"wrote {a.out}")
        return
    anim.save(a.out, writer=PillowWriter(fps=FPS),
              savefig_kwargs=dict(facecolor=fig.get_facecolor()), dpi=a.dpi)
    # PillowWriter loops forever and PIL's encoder drops the duration of merged
    # duplicate frames, which would delete both holds -- same fix as the others.
    from PIL import Image as _I
    src = _I.open(a.out)
    fr = []
    try:
        while True:
            fr.append(src.copy())
            src.seek(src.tell() + 1)
    except EOFError:
        pass
    for f_ in fr:
        f_.info.pop("loop", None)
    step = int(1000 / FPS)
    dur = [step] * len(fr)
    dur[0] = int(HOLD_A * 1000 / FPS)
    dur[-1] = int(HOLD_B * 1000 / FPS)
    fr[0].save(a.out, save_all=True, append_images=fr[1:], duration=dur, disposal=1)
    print(f"wrote {a.out}  ({len(fr)} frames, holds {dur[0]}/{dur[-1]} ms, plays once)")


if __name__ == "__main__":
    main()
