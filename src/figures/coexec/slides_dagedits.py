"""SLIDE-DECK build (manim-slides) of the SOLUTION slide: the four DAG edits, made one at a time.

Animated counterpart to dag-edges-dark.excalidraw. Showing them arrive in order
matters: the schedulable WINDOW around L1 does not exist until the last edit
lands, so building it up makes the point the static picture can only assert.

Fidelity note carried over from the excalidraw version: only THREE of the four
add an edge. Move [2] rewrites the latency of an ds_load -> consumer data edge
that is already in the DAG (SDep::setLatency), so that edge is drawn faint from
the start and is thickened rather than created.

Render (click-through deck):
  manim-slides render -qm <this file> DagEditsSlides

Original video build:
  manim -qm --format=gif anim_dagedits.py DagEdits
"""
from manim import *
from manim_slides import Slide
from sched_common import MONO, TITLE, DIM

config.background_color = "#000000"
Text.set_default(font=MONO)

WM_F, WM_S = "#1d4ed8", "#93c5fd"
DS_F, DS_S = "#0f2f5e", "#7dd3fc"
# E_ORDER must NOT be grey: grey is the pre-existing data edges, so an
# added edge and an already-there edge would look identical.
E_ORDER, E_SPACE, E_LAT, E_BUDG = "#f472b6", "#fb923c", "#34d399", "#a78bfa"

WX, LX = 3.2, -1.0                       # WMMA column x, ds_load column x
WY = [2.15, 1.05, -0.05, -1.15]          # W0..W3
L1Y, L2Y = 0.72, -0.40
BRX = -3.05                              # window bracket x


def node(label, fill, stroke, w, h, txt):
    r = RoundedRectangle(corner_radius=0.09, width=w, height=h, fill_color=fill,
                         fill_opacity=1, stroke_color=stroke, stroke_width=2.5)
    t = Text(label, font_size=17, color=txt).move_to(r.get_center())
    return VGroup(r, t)


def edge(a, b, color, width=3.2, dash=False):
    """Arrow between the facing edges of two boxes."""
    s, e = a.get_center(), b.get_center()
    start = a.get_right() if e[0] > s[0] else a.get_left()
    end = b.get_left() if e[0] > s[0] else b.get_right()
    if abs(e[0] - s[0]) < 0.4:                  # same column: go vertical
        start = a.get_bottom() if e[1] < s[1] else a.get_top()
        end = b.get_top() if e[1] < s[1] else b.get_bottom()
    return Arrow(start, end, buff=0.05, color=color, stroke_width=width,
                 max_tip_length_to_length_ratio=0.32,
                 tip_length=0.18)


class DagEditsSlides(Slide):
    def construct(self):
        title = Text("The four DAG edits the mutation makes", font_size=30,
                     color=TITLE).to_edge(UP, buff=0.22)
        sub = Text("three added edge types plus one latency correction",
                   font_size=18, color=DIM).next_to(title, DOWN, buff=0.12)
        self.play(FadeIn(title), FadeIn(sub))

        # ---- the nodes, and the data edges already in the DAG ----------
        wm = [node(f"WMMA W{k}", WM_F, WM_S, 1.95, 0.48, WHITE).move_to([WX, y, 0])
              for k, y in enumerate(WY)]
        l1 = node("ds_load L1", DS_F, DS_S, 2.1, 0.46, "#e0f2fe").move_to([LX, L1Y, 0])
        l2 = node("ds_load L2", DS_F, DS_S, 2.1, 0.46, "#e0f2fe").move_to([LX, L2Y, 0])
        self.play(LaggedStartMap(FadeIn, VGroup(*wm), lag_ratio=0.12),
                  FadeIn(l1), FadeIn(l2))

        # these already exist: ds_load -> its earliest consuming WMMA
        pre = VGroup(edge(l1, wm[2], DIM, 1.6), edge(l2, wm[3], DIM, 1.6))
        prelab = Text("data edges already in the DAG", font_size=15, color=DIM)
        prelab.to_edge(DOWN, buff=0.45)
        self.play(*[GrowArrow(a) for a in pre], FadeIn(prelab))
        self.wait(0.6)
        self.play(FadeOut(prelab))

        legend, rows = VGroup(), []

        def add_legend(color, text):
            y = -2.05 - 0.44 * len(rows)
            a = Arrow([-6.6, y, 0], [-5.6, y, 0], buff=0, color=color, stroke_width=4,
                      max_tip_length_to_length_ratio=0.35)
            t = Text(text, font_size=15, color=DIM).next_to(a, RIGHT, buff=0.22)
            g = VGroup(a, t)
            rows.append(g)
            legend.add(g)
            return g

        # ---- edit 1: WMMA -> WMMA, program order -----------------------
        self.next_beat()
        order = VGroup(*[edge(wm[k], wm[k + 1], E_ORDER, 2.8) for k in range(3)])
        self.play(LaggedStart(*[GrowArrow(a) for a in order], lag_ratio=0.2),
                  FadeIn(add_legend(E_ORDER, "added: WMMA -> WMMA, program order")))
        self.wait(0.5)

        # ---- edit 2: ds_load -> ds_load, LDS bus spacing ---------------
        self.next_beat()
        space = edge(l1, l2, E_SPACE, 3.0)
        self.play(GrowArrow(space),
                  FadeIn(add_legend(E_SPACE, "added: ds_load -> ds_load, LDS bus spacing")))
        self.wait(0.5)

        # ---- edit 3: latency CORRECTED on an edge that already exists --
        self.next_beat()
        lat = VGroup(edge(l1, wm[2], E_LAT, 3.2), edge(l2, wm[3], E_LAT, 3.2))
        self.play(FadeOut(pre), *[GrowArrow(a) for a in lat],
                  FadeIn(add_legend(E_LAT, "corrected: ds_load -> earliest WMMA, real LDS latency")))
        self.wait(0.5)

        # ---- edit 4: earlier WMMA -> ds_load, budget window ------------
        self.next_beat()
        budg = VGroup(edge(wm[0], l1, E_BUDG, 3.2), edge(wm[1], l2, E_BUDG, 3.2))
        self.play(LaggedStart(*[GrowArrow(a) for a in budg], lag_ratio=0.25),
                  FadeIn(add_legend(E_BUDG, "added: earlier WMMA -> ds_load, budget window")))
        self.wait(0.5)

        # ---- and only now does L1 have a window ------------------------
        self.next_beat()
        top, bot = WY[0], WY[2]
        br = VGroup(
            Line([BRX, top, 0], [BRX, bot, 0], stroke_color=E_BUDG, stroke_width=3),
            Line([BRX, top, 0], [BRX + 0.28, top, 0], stroke_color=E_BUDG, stroke_width=3),
            Line([BRX, bot, 0], [BRX + 0.28, bot, 0], stroke_color=E_BUDG, stroke_width=3))
        wl = VGroup(Text("L1's window", font_size=17, color=E_BUDG),
                    Text("(W0 -> W2)", font_size=14, color=DIM))
        wl.arrange(DOWN, buff=0.06).next_to(br, UP, buff=0.16)
        self.play(Create(br), FadeIn(wl))
        self.wait(1.6)

    def next_beat(self):
        """One click per DAG edit."""
        self.next_slide()
