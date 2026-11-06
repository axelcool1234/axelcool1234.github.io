"""Repair the pinned manim-slides template without rerendering its videos."""

import pathlib
import sys

source, destination = map(pathlib.Path, sys.argv[1:])
html = source.read_text()
replacements = {
    '<html>': '<html lang="en">',
    'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no':
        'width=device-width, initial-scale=1',
    '<title>Manim Slides</title>': '<title>CoExec scheduler slide deck</title>',
    'embedded: false,': 'embedded: true,\n        scrollActivationWidth: null,',
    # Percentage slide sizes become 0/0 while an iframe is hidden or resized,
    # causing Reveal to dispatch resize events recursively. Use the video ratio.
    "width: '100%',": 'width: 1280,',
    "height: '100%',": 'height: 720,',
    '<div class="reveal">': '''<main aria-label="CoExec scheduler slides" style="height:100vh;width:100%"><div class="reveal" aria-label="Interactive slides">
      <h1 style="position:absolute;width:1px;height:1px;overflow:hidden;clip-path:inset(50%)">CoExec scheduler slide deck</h1>''',
    '    </div>\n\n    <script src=': '    </div></main>\n\n    <script src=',
    '<body>': '<body style="margin:0;background:#000">',
}
for old, new in replacements.items():
    if html.count(old) != 1:
        raise ValueError(f'Expected exactly one template fragment: {old}')
    html = html.replace(old, new)
destination.write_text(html)
