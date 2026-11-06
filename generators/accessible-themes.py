"""Keep generated theme text at WCAG AA contrast without changing source palettes."""

import pathlib
import re
import sys


def rgb(value):
    return tuple(int(value[i:i + 2], 16) for i in (1, 3, 5))


def luminance(color):
    channels = [v / 255 for v in color]
    linear = [v / 12.92 if v <= 0.04045 else ((v + 0.055) / 1.055) ** 2.4 for v in channels]
    return sum(v * w for v, w in zip(linear, (0.2126, 0.7152, 0.0722)))


def contrast(a, b):
    lo, hi = sorted((luminance(a), luminance(b)))
    return (hi + 0.05) / (lo + 0.05)


def readable(color, backgrounds, minimum=4.51):
    if all(contrast(color, bg) >= minimum for bg in backgrounds):
        return color
    candidates = []
    for end in (0, 255):
        if not all(contrast((end,) * 3, bg) >= minimum for bg in backgrounds):
            continue
        low, high = 0.0, 1.0
        for _ in range(24):
            amount = (low + high) / 2
            mixed = tuple(round(v + (end - v) * amount) for v in color)
            if all(contrast(mixed, bg) >= minimum for bg in backgrounds):
                high = amount
            else:
                low = amount
        candidate = tuple(round(v + (end - v) * high) for v in color)
        candidates.append((high, candidate))
    if not candidates:
        raise ValueError(f'No readable foreground for {backgrounds}')
    return min(candidates)[1]


def adjust_block(match):
    block = match[0]
    colors = {name: rgb(value) for name, value in re.findall(r'--([\w_]+):\s*(#[\da-fA-F]{6});', block)}
    if 'surface' not in colors:
        return block
    # Accents serve as text on both page and widget surfaces. Their paired
    # foregrounds must then be checked against the adjusted accent backgrounds.
    pairs = {
        'on_surface': ['surface', 'surface_variant'],
        'on_surface_variant': ['surface', 'surface_variant'],
        'primary': ['surface', 'surface_variant'],
        'secondary': ['surface', 'surface_variant'],
        'tertiary': ['surface', 'surface_variant'],
        'error': ['surface', 'surface_variant'],
        'on_primary': ['primary'],
        'on_secondary': ['secondary'],
        'on_tertiary': ['tertiary'],
        'on_error': ['error'],
        'on_hover': ['hover'],
        'terminal_foreground': ['terminal_background'],
    }
    for name, backgrounds in pairs.items():
        colors[name] = readable(colors[name], [colors[bg] for bg in backgrounds])
    # The cubes use terminal accents for SVG text. Axe reports SVG contrast as
    # needing review, so cover these foreground/background pairs explicitly.
    for accent in ('red', 'green', 'yellow', 'blue', 'magenta', 'cyan'):
        name = f'terminal_normal_{accent}'
        colors[name] = readable(colors[name], [colors['surface']])
    colors['outline'] = readable(
        colors['outline'], [colors['surface'], colors['surface_variant']], minimum=3.01,
    )
    adjusted = re.sub(
        r'--([\w_]+):\s*(#[\da-fA-F]{6});',
        lambda m: f'--{m[1]}: #{"".join(f"{v:02x}" for v in colors[m[1]])};',
        block,
    )
    # Assembly rows retain their translucent fills. Adjust their foregrounds
    # against the composited fill, rather than removing the highlighting.
    for name, accent, opacity in (
        ('load', 'secondary', 0.14), ('consumer', 'primary', 0.14),
        ('wait', 'tertiary', 0.14), ('op', 'secondary', 0.07),
    ):
        background = tuple(round(a * opacity + b * (1 - opacity))
                           for a, b in zip(colors[accent], colors['surface']))
        foreground = readable(colors[accent], [background], minimum=4.55)
        value = '#' + ''.join(f'{v:02x}' for v in foreground)
        adjusted = adjusted[:-1] + f'  --assembly_{name}_fg: {value};\n}}'
    return adjusted


if __name__ == '__main__':
    source, destination = map(pathlib.Path, sys.argv[1:])
    destination.mkdir(parents=True, exist_ok=True)
    for file in sorted(source.glob('*.css')):
        css = re.sub(r'\{[^{}]*\}', adjust_block, file.read_text())
        (destination / file.name).write_text(css)
