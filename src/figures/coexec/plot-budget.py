#!/usr/bin/env python3
"""Calculating each load fragment's window: where the VGPR budget comes from.

The slide that answers "where did W[59] come from?" -- the one number a
maintainer will reach for first, because a mutation with a tuned constant in it
is a mutation they can reject on principle. There is no tuned constant: the
budget is the peak of the as-late-as-possible schedule, measured from the DAG.

Two panels, same visual language as the lifelines charts so it reads as a
continuation rather than a new chart:

  top     one bar per fragment, red from issue to its first consumer (held but
          unread) and blue across its consumers. Bars slide LEFT as the debunch
          pulls each fragment earlier.
  bottom  the live-VGPR histogram those bars produce, against the budget line.

The story the motion tells: ALAP is the minimum-pressure schedule but issues
every load right before its first use, so there is no room to hide LDS latency.
Its own peak (228) becomes the ceiling. The debunch then buys as much hiding as
that ceiling allows -- and the peak does not move. It fills the valleys; it does
not raise the roof.

Every number is read from budget_data.py, which is generated from a
-debug-only=amdgpu-wmma-sched run and cross-checked against the pass's own
running histogram. Nothing here is hand-tuned.

Usage:
  plot-budget.py -o budget-morph.gif [--dark]      # animation + matching still
  plot-budget.py -o budget.png       [--dark]      # static (ALAP state)
"""
import argparse
import os
import re
import sys

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.patheffects as pe
from matplotlib.lines import Line2D
from matplotlib.patches import Patch
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

HOLD_A, REVEAL, PER_FRAG, HOLD_B, FPS = 30, 16, 4, 48, 30

# One generated data module per kernel, chosen by --data. Bound in main() so a
# second kernel is a flag rather than a copy of this file.
D = None
N = NF = 0


def load_data(name):
    global D, N, NF
    D = figdata.Bag(figdata.load(name))
    N, NF = D.NWMMA, len(D.FRAGS)


def ease(t):
    return t * t * (3 - 2 * t)


def hist_at(i, u):
    """Exact histogram while fragment i is mid-slide (u in [0,1]).

    Not an interpolation between the pass's steps: a fragment whose left edge
    currently sits at L contributes over [L, alap), so every intermediate frame
    is a real histogram, and u=1 lands exactly on HIST_STEPS[i].
    """
    base = D.HIST_STEPS[i - 1] if i else D.HIST_BEFORE
    f = D.FRAGS[i]
    h = list(base)
    for p in range(int(round(left_at(f, u))), f["alap"]):
        h[p] += f["vgprs"]
    return h


def left_at(f, u):
    return f["alap"] + (f["earliest"] - f["alap"]) * ease(u)


def build(dark):
    P = plotstyle.apply(dark)
    fig, (axb, axh) = plt.subplots(
        2, 1, figsize=(13, 7.4), sharex=True,
        gridspec_kw=dict(height_ratios=[3, 1], hspace=0.12))

    # ---- top: one live-range bar per fragment -------------------------
    # Row index as the y value, numeric ticks left on, same as plot-lifelines.py
    held, inuse = [], []
    for r, f in enumerate(D.FRAGS):
        h = axb.barh(r, f["cmin"] - f["alap"], left=f["alap"], height=0.75,
                     color=P["held"], zorder=3)
        u = axb.barh(r, f["maxpos"] - f["cmin"], left=f["cmin"], height=0.75,
                     color=P["clamp"] if f["clamped"] else P["inuse"], zorder=3)
        held.append(h[0])
        inuse.append(u[0])
    axb.set_ylim(-1, NF)
    axb.set_ylabel("ds_load fragment", fontsize=10.5)
    axb.grid(axis="x", alpha=P["grid_alpha"])
    axb.set_axisbelow(True)

    # ---- bottom: the histogram those bars add up to -------------------
    grid = np.arange(N)
    y0 = np.array(D.HIST_BEFORE, dtype=float)
    fill = [axh.fill_between(grid, y0, step="post", color=P["press"],
                             alpha=P["press_alpha"], zorder=2)]
    (curve,) = axh.plot(grid, y0, drawstyle="steps-post", lw=1.6,
                        color=P["press"], zorder=3)
    bline = axh.axhline(D.BUDGET, ls="--", lw=1.5, color=P["held"],
                        zorder=4, visible=False)
    btext = axh.annotate("", (N - 1, D.BUDGET), textcoords="offset points",
                         xytext=(-6, 6), ha="right", fontsize=11,
                         color=P["held"], zorder=6, visible=False,
                         path_effects=[pe.withStroke(linewidth=3.0,
                                                     foreground=P["bg"])])
    axh.set_ylim(0, D.BUDGET * 1.30)
    axh.set_xlim(0, N - 1)
    axh.set_xlabel("WMMAs issued", fontsize=10.5)
    axh.set_ylabel("live VGPRs\n(calculated by mutation)", fontsize=10.5)
    axh.grid(alpha=P["grid_alpha"])
    axh.set_axisbelow(True)

    # Upper-left of the BAR panel: the fragments that end up nearest the top of
    # the axis are the clamped ones, and they never reach further left than
    # W[59], so this corner stays empty in both the ALAP and debunched states.
    axb.legend(handles=[
        Patch(color=P["held"], label="load fragment's window - held live but not yet read"),
        Patch(color=P["inuse"], label="in use (first to last consumer)"),
        Patch(color=P["clamp"], label="in use, gained a WMMA -> ds_load edge"),
    ], loc="upper left", fontsize=9.5, framealpha=0, ncol=1,
        labelcolor=P["fg"], handlelength=1.4, borderaxespad=0.8,
        labelspacing=0.45)

    status = fig.text(0.5, 0.905, "", ha="center", fontsize=12.5, color=P["fg"])
    sub = fig.text(0.5, 0.868, "", ha="center", fontsize=10.5, color=P["fg"],
                   alpha=0.85)
    fig.suptitle(f"{D.KERNEL} - Calculating Each Load Fragment's Window",
                 fontsize=13.5, y=0.972)
    fig.subplots_adjust(left=0.105, right=0.985, top=0.845, bottom=0.09,
                        hspace=0.12)

    def phase_text(k):
        return (f"extending each fragment's window as early as the budget allows"
                f"  ({k}/{NF})")

    def draw_hist(h):
        fill[0].remove()
        y = np.array(h, dtype=float)
        fill[0] = axh.fill_between(grid, y, step="post", color=P["press"],
                                   alpha=P["press_alpha"], zorder=2)
        curve.set_ydata(y)

    def frame(stage, i=0, u=0.0):
        if stage == "alap":
            for r, f in enumerate(D.FRAGS):
                held[r].set_x(f["alap"])
                held[r].set_width(f["cmin"] - f["alap"])
            draw_hist(D.HIST_BEFORE)
            bline.set_visible(False)
            btext.set_visible(False)
            status.set_text("as late as possible: every fragment issued just before its first use")
            sub.set_text("")
        elif stage == "reveal":
            # The chart has not changed, so the ALAP caption stays put and only
            # the line arrives; its own annotation is the whole message.
            bline.set_visible(True)
            btext.set_visible(True)
            btext.set_text(f"budget = {D.BUDGET} VGPRs")
        elif stage == "debunch":
            f = D.FRAGS[i]
            for r in range(i):
                g = D.FRAGS[r]
                held[r].set_x(g["earliest"])
                held[r].set_width(g["cmin"] - g["earliest"])
            L = left_at(f, u)
            held[i].set_x(L)
            held[i].set_width(f["cmin"] - L)
            draw_hist(hist_at(i, u))
            status.set_text(phase_text(i + 1))
            sub.set_text("")
        else:  # final
            for r, f in enumerate(D.FRAGS):
                held[r].set_x(f["earliest"])
                held[r].set_width(f["cmin"] - f["earliest"])
            draw_hist(D.HIST_AFTER)
            nc = sum(f["clamped"] for f in D.FRAGS)
            status.set_text(phase_text(NF))
            sub.set_text(f"{nc} of {NF} fragments needed an edge")
        return ()

    return fig, frame


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("-o", "--out", default="budget-morph.gif")
    ap.add_argument("--dark", action="store_true")
    ap.add_argument("--dpi", type=int, default=200)
    ap.add_argument("--data", default="budget-canonical.json",
                    help="generated data file (see extract-budget-data.py)")
    a = ap.parse_args()

    load_data(a.data)
    fig, frame = build(a.dark)
    if not a.out.endswith((".gif", ".mp4")):
        frame("alap")
        fig.savefig(a.out, dpi=a.dpi, facecolor=fig.get_facecolor())
        print(f"wrote {a.out}")
        return

    from matplotlib.animation import FuncAnimation, PillowWriter
    still = re.sub(r"-morph\.(gif|mp4)$", "-still.png", a.out)
    if still == a.out:
        still = os.path.splitext(a.out)[0] + "-still.png"
    frame("alap")
    fig.savefig(still, dpi=a.dpi, facecolor=fig.get_facecolor())
    print(f"wrote {still}")

    n_total = HOLD_A + REVEAL + NF * PER_FRAG + HOLD_B

    def by_index(n):
        if n < HOLD_A:
            return frame("alap")
        n -= HOLD_A
        if n < REVEAL:
            return frame("reveal")
        n -= REVEAL
        if n < NF * PER_FRAG:
            return frame("debunch", n // PER_FRAG, (n % PER_FRAG + 1) / PER_FRAG)
        return frame("final")

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
    # Each run of identical frames collapses to one, so the three static beats
    # (hold, budget reveal, hold) each need their duration restored by hand --
    # the reveal one especially, or the budget line appears and is gone.
    dur[0] = int(HOLD_A * 1000 / FPS)
    dur[1] = int(REVEAL * 1000 / FPS)
    dur[-1] = int(HOLD_B * 1000 / FPS)
    fr[0].save(a.out, save_all=True, append_images=fr[1:], duration=dur, disposal=1)
    print(f"wrote {a.out}  ({len(fr)} frames, "
          f"holds {dur[0]}/{dur[1]}/{dur[-1]} ms, plays once)")


if __name__ == "__main__":
    main()
