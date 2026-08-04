"""The matplotlib figures, as manim-slides slides.

manim-slides can carry external media directly: `next_slide(src=...)` copies a
video or image in as its own slide, with no animations of its own. That is all
these scenes do, and it is what lets the whole deck -- animations and charts --
come out of a single `manim-slides convert` call instead of being stitched
together afterwards with python-pptx.

Split into two scenes rather than one because the figures do not sit in a single
block: the budget derivation belongs immediately after the four DAG edits, since
it is where the W[] numbers in the following animation come from, while the
results belong at the end. Scene order at convert time is the deck order.

The videos are produced by plot-*.py into ./fig/ before these scenes render.
"""
from pathlib import Path

from manim_slides import Slide

FIG = Path("fig")


class _FromFiles(Slide):
    """Two slides per figure: the static chart, then the same chart animating.

    The pause matters. Each of these figures is a before/after morph, and landing
    on it mid-flight gives you no chance to read the "before". So the still goes
    up first and the animation runs on the next keypress -- you talk over the
    static chart, then advance and let it move.

    Advancing cannot jump, because the still is frame 0 of the video: plot-*.py
    writes <name>-still.png from the same figure it then animates.

    manim-slides picks the slide type from the file's mimetype, so a .png becomes
    an image slide and a .mp4 a video slide; nothing else is needed.
    """

    files: list[str] = []

    def construct(self):
        for name in self.files:
            video = FIG / name
            still = video.with_name(f"{video.stem}-still.png")
            for path in (still, video):
                if not path.exists():
                    # Fail loudly: a missing figure would otherwise just be a
                    # slide that silently is not there.
                    raise FileNotFoundError(f"{path} -- render the plots first")
                self.next_slide(src=path)


class BudgetSlides(_FromFiles):
    """Where the VGPR budget comes from, per kernel."""

    files = ["budget-f16.mp4", "budget-canonical.mp4"]


class ResultSlides(_FromFiles):
    """What the mutation did: live ranges, LDS waits, and the summary stats."""

    files = [
        "lifelines-f16.mp4",
        "lifelines-canonical.mp4",
        "drains.mp4",
        "results.mp4",
    ]
