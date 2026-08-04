"""Shared geometry and palette for the scheduler animations.

anim_tooearly.py (the problem) and anim_dagedges.py (the fix) are shown back to
back with the dag-edges slide between them, so they MUST agree on every
coordinate -- the whole point is that the viewer sees one frame change behaviour,
not two different diagrams. Anything positional lives here, not in the scenes.

Palette matches dag-edges-dark.excalidraw and the matplotlib charts:
red = held live but not yet read, blue = WMMA / in use.
"""
from manim import *

MONO = "DejaVu Sans Mono"

DS_F, DS_S = "#0f2f5e", "#7dd3fc"      # ds_load
WM_F, WM_S = "#1d4ed8", "#93c5fd"      # WMMA
HELD = "#ef4444"                        # live-but-unread bar (matches charts)
DIM = "#94a3b8"
OK = "#34d399"
HOT = "#ef4444"
TITLE = "#bfdbfe"
LOCK = "#475569"                        # a gated (not-yet-eligible) load

WMAX = 127                              # WMMA index range drawn on the timeline
X0, X1 = -0.6, 6.5                      # timeline extent in scene units
AXIS_Y = -3.05                          # y of the timeline axis
ROW0, ROWH = -2.72, 0.26                # first bar row, row pitch

QUEUE_X = -4.3                          # centre x of the queue column
QUEUE_TOP = 1.95                        # centre y of the topmost queue slot
QUEUE_PITCH = 0.42

COMP_C = np.array([-4.3, -2.15, 0])     # comparator centre
CTR_C = np.array([5.15, 2.35, 0])        # counter centre (clears a 2-line subtitle)


def wx(w):
    """WMMA index -> scene x."""
    return X0 + (X1 - X0) * (w / WMAX)


def load_block(consumer, w=2.45, h=0.4, gated=False):
    """A ds_load in the queue, tagged with the WMMA that first reads it."""
    f = "#12233d" if gated else DS_F
    s = LOCK if gated else DS_S
    r = RoundedRectangle(corner_radius=0.07, width=w, height=h, fill_color=f,
                         fill_opacity=1, stroke_color=s, stroke_width=2)
    t = Text(f"ds_load -> W[{consumer}]", font_size=14,
             color="#7b8ea3" if gated else "#e0f2fe", font=MONO)
    t.move_to(r.get_center())
    g = VGroup(r, t)
    g.consumer = consumer
    return g


def timeline(scene, now_w, label="now"):
    """The WMMA axis plus a movable 'now' marker. Returns (axis, marker_group)."""
    axis = Line([X0, AXIS_Y, 0], [X1, AXIS_Y, 0], stroke_color=DIM, stroke_width=2)
    ticks = VGroup()
    for w in (0, 32, 64, 96, 127):
        t = Line([wx(w), AXIS_Y - 0.08, 0], [wx(w), AXIS_Y + 0.08, 0],
                 stroke_color=DIM, stroke_width=2)
        lab = Text(f"W[{w}]", font_size=12, color=DIM, font=MONO)
        lab.next_to(t, DOWN, buff=0.08)
        ticks.add(VGroup(t, lab))
    marker = DashedLine([wx(now_w), AXIS_Y, 0], [wx(now_w), AXIS_Y + 2.9, 0],
                        stroke_color=OK, stroke_width=3, dash_length=0.09)
    mlab = Text(f"{label}: W[{now_w}]", font_size=15, color=OK, font=MONO)
    mlab.next_to(marker, UP, buff=0.08)
    return axis, ticks, VGroup(marker, mlab)


def held_bar(start_w, end_w, row):
    """A red 'held live but not yet read' bar, same semantics as the charts."""
    x0, x1 = wx(start_w), wx(end_w)
    r = Rectangle(width=max(x1 - x0, 0.03), height=0.17,
                  fill_color=HELD, fill_opacity=1, stroke_width=0)
    r.move_to([(x0 + x1) / 2, ROW0 + row * ROWH, 0])
    return r
