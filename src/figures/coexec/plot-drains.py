#!/usr/bin/env python3
"""Why the zero-spill kernel speeds up: where the LDS waiting is concentrated.

`s_wait_dscnt N` waits until at most N DS operations are still outstanding. So
the number of ops a wait actually STALLS on is

    max(0, outstanding_at_that_point - N)

which is not the immediate, and not the number of ds_ instructions since the
previous wait. This script models the counter properly: every ds_* op (loads AND
stores -- both increment DSCNT) bumps `outstanding`, and each s_wait_dscnt draws
it down to its immediate.

Every DS op must be waited for exactly once before the counter can drain, so the
TOTAL waited-on is identical with and without the mutation. What differs is how
that total is distributed: a few huge stalls that no local WMMA work can cover,
versus many small ones that sit next to enough compute to hide them.

Shows only the counts the DSCNT model gives directly -- DS ops actually waited
on at each s_wait_dscnt. An earlier "WMMA cycles of cover per op" panel was
dropped: DS ops pipeline, so covering N of them does not require N x the LDS
latency, which made that ratio impossible to read against the ~60-cycle figure
and easy to challenge. Everything here is counting, with no cycle model.

Caveat: this is a linear pass over the listing, so `outstanding` does not model
carry across the loop backedge. It describes one pass through the emitted code.

Usage:
  plot-drains.py <off.s> <on.s> -o drains.png [--title ...] [--wmma-cycles 7]
"""
import argparse
import re
import statistics as stats

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Patch

import plotstyle

RE_DS = re.compile(r"^ds_[a-z0-9_]+")
RE_WMMA = re.compile(r"^v_wmma")
RE_WAIT = re.compile(r"^s_wait_dscnt\s+(0x[0-9a-fA-F]+|\d+)")


def waits(path, with_line=False):
    """Per s_wait_dscnt: (ops_waited_on, wmmas_in_interval, cumulative_wmmas).

    with_line appends the 1-based line number of the wait, which the website's
    assembly viewer needs to jump to it. Kept as an opt-in fourth element so the
    figure and extract-drains-data.py keep seeing the triples they expect --
    there must be exactly one DSCNT model, not one per consumer.
    """
    outstanding, wm, total, out = 0, 0, 0, []
    for lineno, raw in enumerate(open(path, errors="replace"), 1):
        l = raw.strip()
        m = RE_WAIT.match(l)
        if m:
            n = int(m.group(1), 0)              # immediates are hex: 0x34
            rec = (max(0, outstanding - n), wm, total)
            out.append(rec + (lineno,) if with_line else rec)
            outstanding = min(outstanding, n)
            wm = 0
            continue
        if RE_DS.match(l):                       # loads AND stores bump DSCNT
            outstanding += 1
        elif RE_WMMA.match(l):
            wm += 1
            total += 1
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("off", nargs="?", help="no-mutation .s (omit when using --data)")
    ap.add_argument("on", nargs="?", help="mutation .s (omit when using --data)")
    ap.add_argument("--data", metavar="FILE.json",
                    help="frozen data from extract-drains-data.py, instead of the .s files")
    ap.add_argument("-o", "--out", default="drains.png")
    ap.add_argument("--title", default="")
    ap.add_argument("--dark", action="store_true",
                    help="render for a black slide background")
    ap.add_argument("--animate", metavar="OUT.gif",
                    help="render the morph animation instead of the static chart")
    ap.add_argument("--stack", nargs=2, metavar=("OFF2", "ON2"),
                    help="second kernel, drawn as a second row of the same morph")
    ap.add_argument("--labels", default="",
                    help="comma-separated row labels for --stack")
    ap.add_argument("--dpi", type=int, default=300,
                    help="raster resolution; ignored for vector output "
                         "(-o foo.pdf / foo.svg), which never blurs on a slide")
    a = ap.parse_args()

    if a.animate:
        import os
        import re as _re
        still = _re.sub(r"-morph\.(gif|mp4)$", "-still.png", a.animate)
        if still == a.animate:
            still = os.path.splitext(a.animate)[0] + "-still.png"
        labels = [s.strip() for s in a.labels.split(",")] if a.labels else ["", ""]
        specs = [(labels[0], a.off, a.on)]
        if a.stack:
            specs.append((labels[1] if len(labels) > 1 else "", *a.stack))
        rows = None
        title = a.title
        if a.data:
            import figdata
            doc = figdata.load(a.data)
            rows = [(r["label"], r["off"], r["on"]) for r in doc["rows"]]
            specs = [(r[0], None, None) for r in rows]
            title = title or doc.get("title", "")
        animate(specs, a.animate, title=title, dark=a.dark, still=still, rows=rows)
        return

    P = plotstyle.apply(a.dark)

    data = [("CoExec  -  no mutation", a.off), ("CoExec  +  DAG mutation", a.on)]
    fig, axes = plt.subplots(1, 2, figsize=(15, 4.6), sharey=True,
                             gridspec_kw=dict(wspace=0.06))

    STALL = P["stall"]
    wmax = max(w[2] for _, p in data for w in waits(p))
    smax = max(w[0] for _, p in data for w in waits(p))

    for col, (label, path) in enumerate(data):
        segs = waits(path)
        x = [t for _, _, t in segs]
        stalled = [s for s, _, _ in segs]
        nz = [s for s in stalled if s]

        ax = axes[col]
        ax.bar(x, stalled, color=STALL, width=wmax / 90)
        med = stats.median(nz)
        ax.axhline(med, color=P["fg"], ls="--", lw=1)
        ax.text(wmax * 0.99, med, f" median {med:.0f}", va="bottom", ha="right",
                fontsize=9, color=P["fg"])
        ax.set_title(f"{label}\n{sum(stalled)} DS ops waited on, spread over "
                     f"{len(nz)} stalling waits (of {len(segs)})", fontsize=11)
        ax.set_ylabel("DS ops waited on\nat this s_wait_dscnt" if col == 0 else "")
        ax.set_xlabel("WMMAs issued")
        ax.set_xlim(-2, wmax + 2)
        ax.set_ylim(0, smax * 1.12)
        ax.grid(axis="y", alpha=P["grid_alpha"])


    if a.title:
        fig.suptitle(a.title, fontsize=13, y=0.98)
    fig.tight_layout(rect=(0, 0, 1, 0.95))
    fig.savefig(a.out, dpi=a.dpi, facecolor=fig.get_facecolor())
    print(f"wrote {a.out}")


# --------------------------------------------------------------------------
# Animated build: ONE panel pair that morphs from the no-mutation wait
# distribution into the mutated one.
#
# Unlike the lifelines chart there is no bar-to-bar correspondence -- the two
# schedules have a different NUMBER of s_wait_dscnt (20 vs 43 on f16) -- so this
# cross-fades the two sets rather than sliding bars. Grey ghosts of the
# un-mutated distribution stay put underneath, and the total waited-on is
# annotated as fixed, because it is: every DS op must be waited for exactly once,
# so the mutation redistributes the waiting rather than removing it.
# --------------------------------------------------------------------------
def animate(specs, out, title="", dark=False, dpi=200, fps=30, still=None,
            rows=None):
    """specs: [(label, off_asm, on_asm), ...] -- one stacked row per kernel, all
    morphing together. Rows share the WMMA axis (both kernels run 128) but keep
    independent y, since the wait magnitudes differ by ~2x."""
    import statistics as st2
    from matplotlib.animation import FuncAnimation, PillowWriter

    P = plotstyle.apply(dark)
    STALL = P["stall"]
    # rows may arrive pre-computed from the frozen JSON, in which case the DSCNT
    # model has already been run and the .s listings are not needed.
    if rows is None:
        rows = []
        for label, off_s, on_s in specs:
            A, B = waits(off_s), waits(on_s)
            rows.append((label, A, B))
    wmax = max(w[2] for _, A, B in rows for w in A + B)
    bw = wmax / 90

    fig, axes = plt.subplots(len(rows), 1, figsize=(13, 4.3 * len(rows)),
                             sharex=True, gridspec_kw=dict(hspace=0.30))
    if len(rows) == 1:
        axes = [axes]

    state = []
    for ax, (label, A, B) in zip(axes, rows):
        xa = [t for _, _, t in A]; sa = [v for v, _, _ in A]
        xb = [t for _, _, t in B]; sb = [v for v, _, _ in B]
        smax = max(sa + sb)
        med_a = st2.median([v for v in sa if v])
        med_b = st2.median([v for v in sb if v])
        nz_a = sum(1 for v in sa if v); nz_b = sum(1 for v in sb if v)
        total = sum(sa)

        ax.bar(xa, sa, color=P["fg"], alpha=0.25, width=bw, zorder=1)   # ghost
        ba = ax.bar(xa, sa, color=STALL, width=bw, zorder=3)
        bb = ax.bar(xb, sb, color=STALL, width=bw, zorder=3)
        hl = ax.axhline(med_a, color=P["fg"], ls="--", lw=1, zorder=4)
        ht = ax.text(wmax * 0.99, med_a, "", va="bottom", ha="right",
                     fontsize=10, color=P["fg"])
        head = ax.set_title("", fontsize=11.5)
        ax.set_ylabel("DS ops waited on\nat this s_wait_dscnt")
        ax.set_xlim(-2, wmax + 2)
        ax.set_ylim(0, smax * 1.16)
        ax.grid(axis="y", alpha=P["grid_alpha"])
        state.append((label, ba, bb, hl, ht, head,
                      med_a, med_b, nz_a, nz_b, len(A), len(B), total))

    axes[-1].set_xlabel("WMMAs issued")
    sub = fig.text(0.5, 0.945, "", ha="center", fontsize=12.5, color=P["fg"])
    if title:
        fig.suptitle(title, fontsize=13.5, y=0.985)
    fig.tight_layout(rect=(0, 0.01, 1, 0.925))

    HOLD_A, MORPH, HOLD_B = 24, 54, 42

    def ease(t):
        return t * t * (3 - 2 * t)

    def frame(n):
        if n < HOLD_A:
            u = 0.0
        elif n < HOLD_A + MORPH:
            u = ease((n - HOLD_A) / MORPH)
        else:
            u = 1.0
        for (label, ba, bb, hl, ht, head, ma, mb, na, nb, la, lb, tot) in state:
            for r in ba:
                r.set_alpha(1 - u)
            for r in bb:
                r.set_alpha(u)
            m = ma + (mb - ma) * u
            hl.set_ydata([m, m])
            ht.set_position((wmax * 0.99, m))
            ht.set_text(f" median {m:.0f}")
            nz, ln = (na, la) if u < 0.5 else (nb, lb)
            head.set_text(f"{label}   -   {tot} DS ops waited on, "
                          f"{nz} stalling waits (of {ln})")
            head.set_color(P["fg"])
        sub.set_text("CoExec  -  no mutation" if u < 0.5 else "CoExec  +  DAG mutation")
        return ()

    frame(0)
    if still:
        fig.savefig(still, dpi=dpi, facecolor=fig.get_facecolor())
        print(f"wrote {still}")

    anim = FuncAnimation(fig, frame, frames=HOLD_A + MORPH + HOLD_B, interval=1000 / fps)
    if out.endswith(".mp4"):
        # Same encoder settings plot-lifelines.py uses and documents: CRF 14 keeps
        # the flat saturated red exact, where the default bitrate mottles it.
        from matplotlib.animation import FFMpegWriter
        anim.save(out, writer=FFMpegWriter(
                      fps=fps, codec="libx264", bitrate=-1,
                      extra_args=["-crf", "14", "-preset", "slow", "-pix_fmt", "yuv420p"]),
                  savefig_kwargs=dict(facecolor=fig.get_facecolor()), dpi=dpi)
        print(f"wrote {out}")
        return
    anim.save(out, writer=PillowWriter(fps=fps),
              savefig_kwargs=dict(facecolor=fig.get_facecolor()), dpi=dpi)
    # same two PillowWriter fixes as the lifelines morph: drop the infinite loop
    # and restore the holds PIL's frame-dedup silently discarded
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
        f_.info.pop("loop", None)
    step = int(1000 / fps)
    dur = [step] * len(fr)
    dur[0] = int(HOLD_A * 1000 / fps)
    dur[-1] = int(HOLD_B * 1000 / fps)
    fr[0].save(out, save_all=True, append_images=fr[1:], duration=dur, disposal=1)
    print(f"wrote {out}  ({len(rows)} kernels, {len(fr)} frames, plays once)")


if __name__ == "__main__":
    main()
