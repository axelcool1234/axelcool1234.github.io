"""SLIDE-DECK build (manim-slides) of VIDEO 3 (the fix): the DAG edge gates eligibility, so the clock advances.

Deliberately the SAME frame as anim_tooearly.py -- same timeline, same queue, same
comparator, same counter -- so played after the dag-edges slide it reads as one
picture changing behaviour. All geometry comes from sched_common, all numbers from
sched_data (extracted from the traces), so the two videos cannot disagree with each
other or with lifelines-canonical.png.

Note how tightly the edges bind: each fragment issues one WMMA slot after its
budget floor.

Render (click-through deck):
  manim-slides render -qm <this file> DagEdgesSlides
  manim-slides convert --to=pptx DagEdgesSlides deck.pptx

Original video build:
  manim -qm --format=gif anim_dagedges.py DagEdges
"""
from manim import *
from manim_slides import Slide
from sched_common import *
import sched_data

config.background_color = "#000000"
Text.set_default(font=MONO)

def keep_on_frame(m, left=-6.95):
    """Nudge right if a long caption would start off-frame."""
    d = left - m.get_left()[0]
    if d > 0:
        m.shift(RIGHT * d)
    return m


FR = sched_data.CLAMPED          # the 7 fragments the mutation clamps


def live_vgprs(issued, now):
    """Registers actually held: a fragment is live from issue until its first
    consumer reads it, so one whose consumer is already behind `now` is gone."""
    return sum(f["vgprs"] for f in issued if f["cmin"] > now)


# The single clock advance that FREES registers: by then some fragments have been
# read, so the counter falls instead of rising. That beat gets its own slide.
DROP_ROW = next(r for r in range(1, len(FR))
                if live_vgprs(FR[:r], FR[r]["issue_on"])
                < live_vgprs(FR[:r], FR[r - 1]["issue_on"]))


class DagEdgesSlides(Slide):
    def ctr_to(self, ctr, value):
        return Transform(ctr, Text(str(value), font_size=30,
                                   color=HOT).move_to(ctr))

    def move_now(self, marker, to_w, run_time=0.5, ctr=None, value=None):
        line = DashedLine([wx(to_w), AXIS_Y, 0], [wx(to_w), AXIS_Y + 2.9, 0],
                          stroke_color=OK, stroke_width=3, dash_length=0.09)
        lab = Text(f"now: W[{to_w}]", font_size=15, color=OK).next_to(line, UP, buff=0.08)
        anims = [Transform(marker[0], line), Transform(marker[1], lab)]
        if ctr is not None:
            # advancing the clock can only RELEASE registers, never add any
            anims.append(self.ctr_to(ctr, value))
        self.play(*anims, run_time=run_time)

    def construct(self):
        start = FR[0]["issue_off"]
        title = Text("CoExecScheduler (With Mutation) on a Real Kernel", font_size=30, color=TITLE)
        title.to_edge(UP, buff=0.22)
        # one line measures 16.6 units against a 14.22-wide frame, so it wraps
        sub = Text(f"Scheduling {len(FR)} ds_load fragments, each having gained an\n"
                   f"incoming edge from an earlier WMMA on {sched_data.KERNEL}",
                   font_size=15, color=DIM, line_spacing=0.6)
        sub.next_to(title, DOWN, buff=0.12)
        self.play(FadeIn(title), FadeIn(sub))

        axis, ticks, marker = timeline(self, start)
        self.play(Create(axis), FadeIn(ticks), Create(marker[0]), FadeIn(marker[1]))

        qlab = Text("Available queue", font_size=17, color=DIM)
        blocks = VGroup(*[load_block(f["cmin"], gated=True) for f in FR])
        gates = VGroup()
        for i, (b, f) in enumerate(zip(blocks, FR)):
            b.move_to([QUEUE_X, QUEUE_TOP - i * QUEUE_PITCH, 0])
            g = Text(f">= W[{f['floor']}]", font_size=13, color=LOCK)
            g.next_to(b, RIGHT, buff=0.16)
            gates.add(g)
        qlab.next_to(blocks, UP, buff=0.20)
        self.play(FadeIn(qlab), LaggedStartMap(FadeIn, blocks, lag_ratio=0.08),
                  LaggedStartMap(FadeIn, gates, lag_ratio=0.08))

        gated = Text("none are eligible yet - Available is EMPTY",
                     font_size=15, color=OK)
        keep_on_frame(gated.move_to([-3.45, QUEUE_TOP - len(FR) * QUEUE_PITCH + 0.02, 0]))
        self.play(FadeIn(gated))
        self.wait(0.8)

        comp = RoundedRectangle(corner_radius=0.1, width=3.0, height=0.9,
                                stroke_color=DIM, stroke_width=2, fill_opacity=0)
        comp.move_to(COMP_C)
        ctext = Text("tryCandidateCoexec", font_size=16, color=TITLE).move_to(comp.get_center())
        self.play(Create(comp), FadeIn(ctext))

        ctr_lab = Text("VGPRs held unread", font_size=15, color=DIM).move_to(CTR_C)
        ctr = Text("0", font_size=30, color=DIM).next_to(ctr_lab, DOWN, buff=0.12)
        self.play(FadeIn(ctr_lab), FadeIn(ctr))

        code = Text("while (Available.empty())\n    bumpCycle();",
                    font_size=17, color=OK, line_spacing=0.7)
        box = RoundedRectangle(corner_radius=0.1, width=4.6, height=1.15,
                               stroke_color=OK, stroke_width=2, fill_opacity=0)
        code.move_to(box.get_center())
        grp = VGroup(box, code).move_to([1.25, 1.9, 0])
        reach = Text("queue empty: can schedule nothing", font_size=16, color=OK)
        reach.next_to(grp, DOWN, buff=0.16)
        self.play(Create(box), FadeIn(code), FadeIn(reach))
        self.wait(0.7)

        self.next_slide()
        def set_loop(color):
            """The bumpCycle loop only runs while Available is EMPTY, so gray the
            whole statement out for as long as anything in the queue is eligible."""
            return [box.animate.set_stroke(color), code.animate.set_color(color),
                    reach.animate.set_color(color)]

        # Fragments become eligible in GROUPS, not one at a time: two of them
        # share the floor W[64], so when the clock reaches it both un-gray at
        # once and the queue stays non-empty until both have been scheduled.
        groups = []
        for row, f in enumerate(FR):
            if groups and FR[groups[-1][0]]["issue_on"] == f["issue_on"]:
                groups[-1].append(row)
            else:
                groups.append([row])

        # the queue is about to stop being empty, so retire the caption
        self.play(FadeOut(gated), run_time=0.3)

        issued = []
        for gi, rows in enumerate(groups):
            w = FR[rows[0]]["issue_on"]
            if rows[0] == DROP_ROW:
                self.next_slide()          # end the run of issues before the drop
            self.move_now(marker, w, run_time=0.6 if gi == 0 else 0.4, ctr=ctr,
                          value=live_vgprs(issued, w))
            if rows[0] == DROP_ROW:
                self.next_slide()          # the clock move alone: 66 -> 34
            # every fragment gated on this W[] becomes eligible together, and
            # the loop stops applying the moment the first of them does
            self.play(*[a for r in rows for a in (
                            blocks[r][0].animate.set_fill(DS_F, opacity=1)
                                              .set_stroke(DS_S),
                            blocks[r][1].animate.set_color("#e0f2fe"),
                            gates[r].animate.set_color(OK))],
                      *set_loop(DIM), run_time=0.25)
            for row in rows:
                b, f = blocks[row], FR[row]
                self.play(b.animate.move_to(comp.get_center() + UP * 0.8).scale(0.9),
                          FadeOut(gates[row]), run_time=0.3)
                v = Text("tryEffectiveStall: stall 0", font_size=15, color=HOT)
                v.next_to(comp, DOWN, buff=0.16)
                self.play(FadeIn(v), run_time=0.2)
                bar = held_bar(f["issue_on"], f["cmin"], row)
                self.play(FadeOut(b, shift=RIGHT * 0.4), FadeIn(bar, shift=RIGHT * 0.2),
                          run_time=0.4)
                issued.append(f)
                self.play(self.ctr_to(ctr, live_vgprs(issued, f["issue_on"])),
                          FadeOut(v), run_time=0.25)
            # queue drained again -> the loop is back in force
            self.play(*set_loop(OK), run_time=0.25)

        self.next_slide()
        self.play(FadeOut(qlab), FadeOut(comp), FadeOut(ctext),
                  FadeOut(grp), FadeOut(reach), run_time=0.5)
        ghosts = VGroup(*[
            Rectangle(width=wx(f["cmin"]) - wx(f["issue_off"]), height=0.17,
                      fill_color=DIM, fill_opacity=0.30, stroke_width=0)
            .move_to([(wx(f["issue_off"]) + wx(f["cmin"])) / 2, ROW0 + r * ROWH, 0])
            .set_z_index(-1)
            for r, f in enumerate(FR)])
        glab = Text("gray: where CoExec issued them without the mutation",
                    font_size=16, color=DIM).move_to([1.5, 0.6, 0])
        self.play(LaggedStartMap(FadeIn, ghosts, lag_ratio=0.1), FadeIn(glab))
        self.wait(0.9)
        punch = Text("same loads, same order - issued later\n"
                     "shorter live ranges, waits better hidden by WMMA latency",
                     font_size=20, color=OK, line_spacing=0.7)
        punch.move_to([-0.8, 1.55, 0])
        self.play(FadeIn(punch))
        self.wait(2.4)
