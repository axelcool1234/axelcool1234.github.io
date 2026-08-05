// The drawing primitives shared by the two two-panel figures: the budget-window
// chart and the live-range chart below it.
//
// Both are the same shape, because the talk draws them the same way -- one bar
// per ds_load fragment over a WMMA axis on top, and the VGPR curve those bars
// produce underneath, sharing that axis. What differs is where the numbers come
// from: the budget chart uses the pressure the mutation *calculates* while it
// decides, the live-range chart uses the pressure the scheduler *measured*
// afterwards. Keeping the frame in one place is what lets them be compared.

export const SVG_NS = "http://www.w3.org/2000/svg";

export function svgEl(name: string, attrs: Record<string, string | number>): SVGElement {
  // Explicit type: with a non-literal tag name tsc cannot pick the SVG overload
  // of createElementNS and falls back to `unknown`.
  const e = document.createElementNS(SVG_NS, name) as SVGElement;
  for (const [k, v] of Object.entries(attrs)) e.setAttribute(k, String(v));
  return e;
}

// One viewBox, two stacked panels. Everything is in viewBox units; the svg is
// width:100% so the whole thing scales with the column.
export interface Geom {
  vbW: number; vbH: number;
  x0: number; x1: number;         // plot area, left edge to right edge
  barsTop: number; barsBot: number;
  histTop: number; histBot: number;
}

export const xScaleFor = (g: Geom, nw: number) =>
  (w: number) => g.x0 + (w / (nw - 1)) * (g.x1 - g.x0);

// Rows divide a fixed panel rather than being a constant height: the kernels
// have different fragment counts (23 and 36 here, 7 and 25 next door) and the
// figure must not change shape when you switch between them.
export function rowsIn(g: Geom, n: number) {
  const row = (g.barsBot - g.barsTop) / n;
  return { row, barH: row * 0.72, y: (i: number) => g.barsTop + (n - 1 - i) * row };
}

// Row 0 at the BOTTOM, as matplotlib's barh(i) has it: the fragments are in
// issue order, so the earliest end up nearest the panel they feed.

export function drawXAxis(svg: SVGElement, g: Geom, o: {
  x: (w: number) => number;
  ticks: number[];
  title: string;
}): void {
  for (const t of o.ticks) {
    svg.appendChild(svgEl("line", {
      class: "ch-grid", x1: o.x(t), y1: g.barsTop - 2, x2: o.x(t), y2: g.histBot,
    }));
    // The end labels anchor inward: centred, the first hangs off the left of
    // the viewBox and the last is clipped by the right edge.
    const lab = svgEl("text", {
      class: "ch-tick", x: o.x(t), y: g.histBot + 14,
      "text-anchor": t === o.ticks[0] ? "start"
        : t === o.ticks[o.ticks.length - 1] ? "end" : "middle",
    });
    lab.textContent = `W[${t}]`;
    svg.appendChild(lab);
  }
  const title = svgEl("text", {
    class: "ch-axis", x: (g.x0 + g.x1) / 2, y: g.histBot + 32, "text-anchor": "middle",
  });
  title.textContent = o.title;
  svg.appendChild(title);
}

// A rotated axis label, optionally over two lines. Inside a rotated <text> a
// tspan's dy runs along local +y, which the -90 maps to global +x -- so the
// second line lands beside the first rather than under it, both still centred.
export function drawYLabel(svg: SVGElement, o: {
  x: number; cy: number; lines: string[];
}): void {
  const t = svgEl("text", {
    class: "ch-axis", x: o.x, y: o.cy,
    "text-anchor": "middle", transform: `rotate(-90 ${o.x} ${o.cy})`,
  });
  o.lines.forEach((line, i) => {
    const tsp = svgEl("tspan", { x: o.x, dy: i === 0 ? "0" : "1.15em" });
    if (i > 0) tsp.setAttribute("class", "ch-axis-sub");
    tsp.textContent = line;
    t.appendChild(tsp);
  });
  svg.appendChild(t);
}

// Round numbers at or below `max`, so the axis reads 0/100/200 rather than
// 0/98.7/197.3. Used for the VGPR scale, where the reader wants to be able to
// say "about 200" off the chart.
export function niceTicks(max: number, want = 3): number[] {
  const raw = max / want;
  const mag = Math.pow(10, Math.floor(Math.log10(raw)));
  const step = [1, 2, 2.5, 5, 10].map((m) => m * mag).find((s) => s >= raw) ?? mag * 10;
  const out: number[] = [];
  for (let v = 0; v <= max + 1e-9; v += step) out.push(Math.round(v));
  return out;
}

export function drawYTicks(svg: SVGElement, g: Geom, o: {
  values: number[];
  y: (v: number) => number;
}): void {
  for (const v of o.values) {
    const yy = o.y(v);
    if (yy < g.histTop - 1 || yy > g.histBot + 1) continue;
    svg.appendChild(svgEl("line", {
      class: "ch-grid", x1: g.x0, y1: yy, x2: g.x1, y2: yy,
    }));
    const lab = svgEl("text", { class: "ch-tick", x: g.x0 - 6, y: yy + 3, "text-anchor": "end" });
    lab.textContent = String(v);
    svg.appendChild(lab);
  }
}

// Row numbers down the left of the bar panel, so a fragment named in the text
// can be found in the chart. Stepped so they never collide however many rows.
export function drawRowTicks(svg: SVGElement, g: Geom, o: {
  n: number; y: (i: number) => number; barH: number; row: number;
}): void {
  const every = Math.max(5, Math.ceil(11 / o.row) * 5);
  for (let r = 0; r < o.n; r += every) {
    const lab = svgEl("text", {
      class: "ch-tick", x: g.x0 - 6, y: o.y(r) + o.barH - 0.5, "text-anchor": "end",
    });
    lab.textContent = String(r);
    svg.appendChild(lab);
  }
}

// A step-post series: value h[i] holds from i to i+1, which is what a
// per-WMMA histogram means.
export function stepPath(h: number[], o: {
  x: (i: number) => number; y: (v: number) => number; baseY?: number; x0?: number;
}): string {
  let d = "";
  const n = h.length;
  for (let p = 0; p < n; p++) {
    const yy = o.y(h[p]);
    d += `${p === 0 ? "M" : "L"}${o.x(p).toFixed(1)},${yy.toFixed(1)}`;
    d += `L${o.x(Math.min(p + 1, n - 1)).toFixed(1)},${yy.toFixed(1)}`;
  }
  if (o.baseY !== undefined) d += `L${o.x(n - 1).toFixed(1)},${o.baseY}L${o.x0},${o.baseY}Z`;
  return d;
}

// An irregular (x, y) series -- the scheduler's own pressure readout is sampled
// once per pick, not once per WMMA, so it does not fit stepPath's grid.
export function seriesPath(xs: number[], ys: number[], o: {
  x: (w: number) => number; y: (v: number) => number; baseY?: number;
}): string {
  if (!xs.length) return "";
  let d = "";
  for (let i = 0; i < xs.length; i++) {
    d += `${i === 0 ? "M" : "L"}${o.x(xs[i]).toFixed(1)},${o.y(ys[i]).toFixed(1)}`;
  }
  if (o.baseY !== undefined) {
    d += `L${o.x(xs[xs.length - 1]).toFixed(1)},${o.baseY}L${o.x(xs[0]).toFixed(1)},${o.baseY}Z`;
  }
  return d;
}
