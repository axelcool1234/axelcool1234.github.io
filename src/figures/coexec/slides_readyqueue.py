"""SLIDE-DECK build (manim-slides) of: the PROBLEM slide - how CoExec picks, and why it cannot decline.

Mirrors AMDGPUCoExecSchedStrategy::pickNodeFromQueue exactly:

    auto EvaluateQueue = [&](ReadyQueue &Q, bool FromPending) {
      for (SUnit *SU : Q) {                          # ONE pass over the WHOLE queue
        SchedCandidate TryCand(...);                 # candidate
        tryCandidateCoexec(Cand, TryCand, ZoneArg);  # vs reigning winner
        if (TryCand.Reason != NoCand)
          Cand.setBest(TryCand);                     # candidate becomes winner
        # else winner stays, candidate is discarded
      }
    };
    EvaluateQueue(Zone.Available, false);
    EvaluateQueue(Zone.Pending,  true);

Nothing is issued mid-scan. The queue is drained of candidates, and only when the
pass is over does pickNode() schedule whichever winner survived -- which is why
there is no opportunity to answer "none of these".

tryCandidateCoexec is a CASCADE: it runs the heuristics in a fixed order and
returns at the first one that discriminates. That is why `Stall` (near the top)
decided 83 of 83 early loads while RegMax (#13) never fired once, and it is why
the highlight below stops at a rung instead of running the whole list.

Render (click-through deck):
  manim-slides render -qm <this file> ReadyQueueSlides
  manim-slides convert --to=pptx ReadyQueueSlides deck.pptx

Original video build:
  manim -qm --format=gif anim_readyqueue.py ReadyQueue
"""
from manim import *
from manim_slides import Slide

config.background_color = "#000000"
MONO = "DejaVu Sans Mono"
Text.set_default(font=MONO)

DS_F, DS_S = "#0f2f5e", "#7dd3fc"      # ds_load  (matches dag-edges dark)
WM_F, WM_S = "#1d4ed8", "#93c5fd"      # WMMA
DIM = "#94a3b8"
HOT = "#ef4444"
OK = "#34d399"
TITLE = "#bfdbfe"

# tryCandidateCoexec, in source order. Trimmed to the rungs that actually fire on
# these kernels, plus both register-pressure ones -- their POSITIONS are the
# argument: RegExcess sits high and never discriminates, RegMax sits too low to
# be reached.
LADDER = [
    "biasPhysReg",
    "tryPressure  (RegExcess)",
    "tryEffectiveStall",
    "tryMemoryPipeline",
    "tryCoexecSlot",
    "tryShadowMix",
    "tryCriticalResource / Dep / Prio",
    "Clustering / getWeakLeft",
    "tryPressure  (RegMax)",
    "tryLatency",
    "NodeOrder",
]

# (candidate index, rung that fires, does the candidate win?)
# Mix drawn from the real reason histogram: Stall and CritResourceDep dominate,
# CritResource third, CoexecSlot occasionally.
ROUNDS = [
    (1, 2, True),    # tryEffectiveStall        -> candidate wins
    (2, 6, False),   # tryCriticalResource*     -> winner stays
    (3, 2, True),    # tryEffectiveStall        -> candidate wins
    (4, 6, False),   # tryCriticalResource*     -> winner stays
    (5, 4, True),    # tryCoexecSlot            -> candidate wins (the WMMA)
]


def op_block(kind, w=1.5, h=0.44):
    f, s = (DS_F, DS_S) if kind == "ds" else (WM_F, WM_S)
    r = RoundedRectangle(corner_radius=0.08, width=w, height=h,
                         fill_color=f, fill_opacity=1, stroke_color=s,
                         stroke_width=2)
    t = Text("ds_load" if kind == "ds" else "WMMA", font_size=16,
             color="#e0f2fe" if kind == "ds" else WHITE)
    t.move_to(r.get_center())
    return VGroup(r, t)


class ReadyQueueSlides(Slide):
    def construct(self):
        title = Text("How CoExecScheduler picks the next instruction", font_size=30,
                     color=TITLE).to_edge(UP, buff=0.22)
        sub = Text("one pass over the whole queue, then the winner is issued",
                   font_size=19, color=DIM).next_to(title, DOWN, buff=0.12)
        self.play(FadeIn(title), FadeIn(sub))

        # ---- the queue -------------------------------------------------
        kinds = ["ds"] * 5 + ["wmma"]
        blocks = VGroup(*[op_block(k) for k in kinds])
        blocks.arrange(DOWN, buff=0.14).to_edge(LEFT, buff=0.4).shift(DOWN * 0.9)
        pitch = blocks[1].get_center()[1] - blocks[0].get_center()[1]   # negative
        queue_home = blocks.get_center()
        qlabel = Text("Available queue", font_size=19, color=DIM)
        qlabel.next_to(blocks, UP, buff=0.25)
        self.play(FadeIn(qlabel), LaggedStartMap(FadeIn, blocks, lag_ratio=0.12))

        # ---- the comparator --------------------------------------------
        # Build the rungs first and fit the box to them: a fixed width left a
        # huge dead margin either side once the longest rung was known.
        rungs = VGroup(*[Text(n, font_size=14, color=DIM) for n in LADDER])
        rungs.arrange(DOWN, buff=0.10, aligned_edge=LEFT)
        comp = RoundedRectangle(corner_radius=0.12,
                                width=rungs.width + 0.70,
                                height=rungs.height + 0.42,
                                stroke_color=DIM, stroke_width=2,
                                fill_opacity=0).shift(RIGHT * 0.9 + DOWN * 0.55)
        rungs.move_to(comp.get_center())
        ctitle = Text("tryCandidateCoexec", font_size=19, color=TITLE)
        ctitle.next_to(comp, UP, buff=0.10)
        self.play(Create(comp), FadeIn(ctitle),
                  LaggedStartMap(FadeIn, rungs, lag_ratio=0.04))

        # ---- the two destinations --------------------------------------
        # Outcomes are places the block travels to, not arrows out of a box: the
        # winner goes back UP to the winner slot, the loser goes RIGHT into the
        # bin. The motion is the explanation, and the fact that there is nowhere
        # else to go is the point of the slide.
        champ_slot = comp.get_top() + UP * 1.10 + LEFT * 1.35
        chall_slot = comp.get_top() + UP * 1.10 + RIGHT * 1.35
        clabel = Text("winner", font_size=15, color=DIM).move_to(champ_slot + UP * 0.42)
        hlabel = Text("candidate", font_size=15, color=DIM).move_to(chall_slot + UP * 0.42)

        bin_box = DashedVMobject(
            RoundedRectangle(corner_radius=0.1, width=1.9, height=0.8,
                             stroke_color=DIM, stroke_width=2, fill_opacity=0),
            num_dashes=34)
        bin_box.move_to(comp.get_right() + RIGHT * 1.85 + UP * 0.55)
        blabel = Text("discarded", font_size=15, color=DIM).next_to(bin_box, UP, buff=0.12)
        self.play(FadeIn(clabel), FadeIn(hlabel), Create(bin_box), FadeIn(blabel))

        caption_at = comp.get_bottom() + DOWN * 0.30

        def drain(from_index):
            rest = [blocks[j] for j in range(from_index + 1, len(blocks))]
            if rest:
                self.play(*[b.animate.shift(UP * (-pitch)) for b in rest], run_time=0.3)

        self.next_slide()
        # ---- round 0: FirstValid, no comparison ------------------------
        champ = blocks[0]
        self.play(champ.animate.move_to(champ_slot), run_time=0.6)
        drain(0)
        cap = Text("FirstValid: no comparison",
                   font_size=17, color=OK).move_to(caption_at)
        self.play(FadeIn(cap))
        self.wait(0.7)
        self.play(FadeOut(cap))

        # ---- rounds 1..N (same slide: FirstValid is the first round, not a
        # ---- separate idea) --------------------------------------------
        for idx, rung, chall_wins in ROUNDS:
            chall = blocks[idx]
            self.play(chall.animate.move_to(chall_slot), run_time=0.45)
            drain(idx)

            hl = Rectangle(width=rungs[0].width + 0.16,
                           height=rungs[0].height + 0.13,
                           color=DIM, stroke_width=3).move_to(rungs[0].get_center())
            self.play(Create(hl), run_time=0.2)
            for k in range(1, rung + 1):
                self.play(hl.animate
                          .stretch_to_fit_width(rungs[k].width + 0.16)
                          .stretch_to_fit_height(rungs[k].height + 0.13)
                          .move_to(rungs[k].get_center()), run_time=0.15)
            self.play(hl.animate.set_color(HOT),
                      rungs[rung].animate.set_color(HOT), run_time=0.2)
            cap = Text(f"{LADDER[rung].split()[0]} decides",
                       font_size=17, color=HOT).move_to(caption_at)
            self.play(FadeIn(cap), run_time=0.25)

            winner, loser = (chall, champ) if chall_wins else (champ, chall)
            self.play(Flash(winner.get_center(), color=OK, line_length=0.16,
                            flash_radius=0.55), run_time=0.4)
            self.play(loser.animate.move_to(bin_box.get_center()).scale(0.8),
                      run_time=0.5)
            self.play(FadeOut(loser), run_time=0.25)
            if chall_wins:
                self.play(winner.animate.move_to(champ_slot), run_time=0.4)
            champ = winner

            self.play(FadeOut(hl), FadeOut(cap),
                      rungs[rung].animate.set_color(DIM), run_time=0.22)

        # ---- queue exhausted -> the winner is scheduled ---------------
        empty = Text("queue exhausted", font_size=17, color=DIM).move_to(queue_home)
        self.play(FadeIn(empty))
        self.wait(0.4)
        cap = Text("the winner is scheduled",
                   font_size=18, color=OK).move_to(caption_at)
        self.play(FadeIn(cap))
        self.play(champ.animate.scale(1.15).move_to(caption_at + DOWN * 0.62),
                  run_time=0.7)
        self.wait(1.4)
