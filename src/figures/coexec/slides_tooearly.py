"""SLIDE-DECK build (manim-slides) of VIDEO 2 (the problem): loads issued far ahead of anything that reads them.

Every number is real: the fragments, their consumers, their VGPR widths and the
WMMA index each was issued at all come from sched_data.py, which extract-anim-data.py
parses out of the same trace that produced lifelines-canonical.png. These are the
dark-blue fragments in that chart -- the ones the mutation constrains.

The closing beat is the precise version of "it cannot decline". The scheduler CAN
let time pass -- SchedBoundary::pickOnlyChoice does it 128 times in this region:

    for (unsigned i = 0; Available.empty(); ++i) {
        bumpCycle(CurrCycle + 1);
        releasePending();
    }

but that path is gated on the queue being EMPTY, and a function that compares two
candidates has no way to empty it.

Render (click-through deck):
  manim-slides render -qm <this file> TooEarlySlides
  manim-slides convert --to=pptx TooEarlySlides deck.pptx

Original video build:
  manim -qm --format=gif anim_tooearly.py TooEarly
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


class TooEarlySlides(Slide):
    def ctr_to(self, ctr, value):
        return Transform(ctr, Text(str(value), font_size=30,
                                   color=HOT).move_to(ctr))

    def move_now(self, marker, to_w, run_time=0.35, ctr=None, value=None):
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
        title = Text("CoExecScheduler (No Mutation) on a Real Kernel", font_size=30, color=TITLE)
        title.to_edge(UP, buff=0.22)
        sub = Text(f"Scheduling {len(FR)} ds_load fragments on {sched_data.KERNEL}", font_size=17, color=DIM)
        sub.next_to(title, DOWN, buff=0.12)
        self.play(FadeIn(title), FadeIn(sub))

        axis, ticks, marker = timeline(self, start)
        self.play(Create(axis), FadeIn(ticks), Create(marker[0]), FadeIn(marker[1]))

        qlab = Text("Available queue", font_size=17, color=DIM)
        blocks = VGroup(*[load_block(f["cmin"]) for f in FR])
        for i, b in enumerate(blocks):
            b.move_to([QUEUE_X, QUEUE_TOP - i * QUEUE_PITCH, 0])
        qlab.next_to(blocks, UP, buff=0.20)
        self.play(FadeIn(qlab), LaggedStartMap(FadeIn, blocks, lag_ratio=0.08))

        none_w = Text("0 WMMAs available - they are all waiting on these loads",
                      font_size=17, color=HOT).move_to([1.6, 1.45, 0])
        self.play(FadeIn(none_w))
        self.wait(0.9)

        comp = RoundedRectangle(corner_radius=0.1, width=3.0, height=0.9,
                                stroke_color=DIM, stroke_width=2, fill_opacity=0)
        comp.move_to(COMP_C)
        ctext = Text("tryCandidateCoexec", font_size=16, color=TITLE).move_to(comp.get_center())
        self.play(Create(comp), FadeIn(ctext))

        ctr_lab = Text("VGPRs held unread", font_size=15, color=DIM).move_to(CTR_C)
        ctr = Text("0", font_size=30, color=DIM).next_to(ctr_lab, DOWN, buff=0.12)
        self.play(FadeIn(ctr_lab), FadeIn(ctr))

        self.next_slide()
        # loads start issuing now, so retire the standing caption
        self.play(FadeOut(none_w), run_time=0.3)

        issued = []
        for row, (b, f) in enumerate(zip(blocks, FR)):
            self.move_now(marker, f["issue_off"], ctr=ctr,
                          value=live_vgprs(issued, f["issue_off"]))
            self.play(b.animate.move_to(comp.get_center() + UP * 0.8).scale(0.9),
                      run_time=0.3)
            v = Text("tryEffectiveStall: stall 0", font_size=15, color=HOT)
            v.next_to(comp, DOWN, buff=0.16)
            self.play(FadeIn(v), run_time=0.2)
            bar = held_bar(f["issue_off"], f["cmin"], row)
            self.play(FadeOut(b, shift=RIGHT * 0.4), FadeIn(bar, shift=RIGHT * 0.2),
                      run_time=0.4)
            issued.append(f)
            live = live_vgprs(issued, f["issue_off"])
            self.play(self.ctr_to(ctr, live), FadeOut(v), run_time=0.25)

        gap = Text(f"issued at W[{FR[0]['issue_off']}-{FR[-1]['issue_off']}]"
                   f" - first read at W[{FR[0]['cmin']}-{FR[-1]['cmin']}]",
                   font_size=17, color=HOT)
        gap.move_to([1.6, 0.85, 0])
        self.play(FadeIn(gap))
        self.wait(1.2)

        self.next_slide()
        self.play(FadeOut(qlab), FadeOut(gap), FadeOut(comp),
                  FadeOut(ctext), run_time=0.5)
        code = Text("while (Available.empty())\n    bumpCycle();",
                    font_size=19, color=DIM, line_spacing=0.7)
        box = RoundedRectangle(corner_radius=0.1, width=5.6, height=1.35,
                               stroke_color=DIM, stroke_width=2, fill_opacity=0)
        code.move_to(box.get_center())
        grp = VGroup(box, code).move_to([-2.6, 1.5, 0])
        note = Text("it CAN issue nothing - but only with an empty queue",
                    font_size=16, color=DIM).next_to(grp, DOWN, buff=0.22)
        self.play(Create(box), FadeIn(code), FadeIn(note))
        self.wait(2.2)
