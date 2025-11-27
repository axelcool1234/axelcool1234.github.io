#!/usr/bin/env python3
import argparse, math, os

parser = argparse.ArgumentParser()
parser.add_argument('--out', required=True)
args = parser.parse_args()

os.makedirs(os.path.dirname(args.out), exist_ok=True)

width, height = 600, 200
mid_y = height // 2
amp = int(height * 0.4)
points = []
for x in range(width):
    t = (x / width) * 2 * math.pi * 2
    y = mid_y - int(math.sin(t) * amp)
    points.append(f"{x},{y}")

svg = f"""
<svg xmlns='http://www.w3.org/2000/svg' width='{width}' height='{height}'>
  <rect width='100%' height='100%' fill='#0b1e2d'/>
  <polyline fill='none' stroke='#6cf' stroke-width='2' points='{" ".join(points)}' />
  <text x='12' y='24' fill='#cde' font-family='monospace' font-size='16'>Generated sine plot</text>
</svg>
"""
with open(args.out, 'w') as f:
    f.write(svg)
print(f"wrote {args.out}")

