"""Load the generated figure-data JSON.

The figures used to read the scheduler's raw debug streams directly -- 237 MB of
them -- which is fine on the machine that produced them and impossible anywhere
else. The extractors (extract-*-data.py) now distil those down to ~76 KB of JSON
under data/, and everything that draws reads it through here.

FIGURE_DATA overrides the directory, so a sandboxed build can point at its own
copy without the scripts caring where they were unpacked.
"""
import json
import os

DATA_DIR = os.environ.get(
    "FIGURE_DATA", os.path.join(os.path.dirname(os.path.abspath(__file__)), "data"))


def load(name):
    """-> dict, the parsed contents of DATA_DIR/<name>."""
    with open(os.path.join(DATA_DIR, name)) as fh:
        return json.load(fh)


class Bag:
    """Attribute access over a JSON object, upper-cased.

    The plot scripts were written against generated Python modules and say
    D.BUDGET / D.HIST_STEPS. Keeping that spelling means the drawing code did not
    have to change when the data moved to JSON.
    """

    def __init__(self, doc):
        self._doc = doc
        for k, v in doc.items():
            setattr(self, k.upper(), v)
