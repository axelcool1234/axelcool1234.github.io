// "ds_load fragment live ranges vs WMMAs scheduled in order" -- the DOM
// re-telling of the lifelines figure, the one the ISA listing cannot show.
//
// Same two-panel frame as the budget chart above (chart.ts draws both), but the
// numbers come from the other end of the pipeline. The budget chart shows the
// pressure the mutation *calculates* over the ds_load fragments while it is
// deciding where they may go. This one shows what the scheduler *measured*
// afterwards: total VGPR pressure over the whole region, sampled once per pick.
// That is why the two y scales are nothing like each other -- 228 against 949
// for the mxfp GEMM -- and why this is the chart that answers "did it work?".
//
// The mutation toggle morphs between the two real runs. The bars are aligned
// index for index (same fragments, same order, verified against the SU keys in
// the source data), so a bar sliding right is that exact load being issued
// later; and the curve it drags with it is the pressure that bought.

import { play, smooth } from "./anim.js";
import { Geom, svgEl, xScaleFor, rowsIn, drawXAxis, drawYLabel, drawYTicks,
         drawRowTicks, niceTicks, seriesPath } from "./chart.js";
import { AsmView, AsmSide } from "./asmview.js";

interface Bar {
  issued: number;    // WMMA index its first subload was issued at
  cmin: number;      // first consumer
  cmax: number;      // last consumer
  vgprs: number;
  clamped: boolean;  // does the mutation constrain this one?
  lines: number[];      // its subloads, as assembly line numbers
  consumers: number[];  // the WMMAs that actually read it, as indices
}

interface Side { bars: Bar[]; pressure: { x: number[]; y: number[] } }
interface Data {
  kernel: string; budget: number; off: Side; on: Side;
  asm: { off: AsmSide; on: AsmSide };
}

const G: Geom = {
  vbW: 680, vbH: 362,
  x0: 54, x1: 672,
  barsTop: 10, barsBot: 220,
  histTop: 246, histBot: 320,
};
const TICKS = [0, 32, 64, 96, 127];
const NW = 129;             // the pressure series runs to W[128]

const root = document.getElementById("lr");
if (root) {
  const q = <T extends Element>(s: string) => root.querySelector<T>(s)!;
  const svg = q<SVGSVGElement>(".lr-svg");
  const legend = q<HTMLElement>(".lr-legend");
  const dagBtns = Array.from(root.querySelectorAll<HTMLButtonElement>(".lr-dag button"));

  let D: Data | null = null;
  let mutation = false;       // which side is showing
  let alpha = 0;              // 0 = off, 1 = on; animated on toggle
  let NF = 0;
  let ROW = 9, BAR_H = 6;
  let x = xScaleFor(G, NW);
  let rowY = (i: number) => G.barsTop + i;
  let yMax = 1;
  const py = (v: number) => G.histBot - (v / yMax) * (G.histBot - G.histTop);

  // The two pressure series are sampled once per scheduler pick, at different
  // x positions, so there is no pointwise correspondence to interpolate. Both
  // are resampled onto one per-WMMA grid at load, which gives arrays of equal
  // length that lerp cleanly -- the same thing manim needs before it can morph
  // two graphs. Taking the max within each WMMA preserves the peaks exactly,
  // which is the number the figure exists to report.
  let gridOff: number[] = [], gridOn: number[] = [];
  let heldR: SVGElement[] = [], useR: SVGElement[] = [], ghostR: SVGElement[] = [];
  let rowHit: SVGElement[] = [];
  let picked = -1;
  // "ranges" is the live-range/pressure pair; "stalls" is the LDS wait figure
  // over the same WMMA axis. Same data file, same assembly viewer underneath.
  let view: "ranges" | "stalls" = "ranges";
  let pickedWait = -1;              // index into the active side's waits
  // line -> what it is on the chart, rebuilt whenever the side changes
  let subOf = new Map<number, number>();
  let consOf = new Map<number, number[]>();
  let waitOf = new Map<number, number>();
  let cycle = 0;                    // which of a WMMA's fragments to show next
  let curveGhost: SVGElement, curveLive: SVGElement;
  let fillGhost: SVGElement, fillLive: SVGElement;

  const lerp = (a: number, b: number, t: number) => a + (b - a) * t;

  function build() {
    svg.replaceChildren();
    drawXAxis(svg, G, { x, ticks: TICKS, title: "WMMAs issued" });
    if (view === "stalls") { buildStalls(); return; }
    drawYTicks(svg, G, { values: niceTicks(yMax), y: py });

    // One curve that morphs, plus a static ghost of the mutation-off state --
    // the same arrangement as the bars, where the bar moves and the ghost marks
    // where it used to reach.
    fillGhost = svgEl("path", { class: "lr-fill lr-ghostc", d: gridPath(gridOff, true) });
    curveGhost = svgEl("path", { class: "lr-curve lr-ghostc", d: gridPath(gridOff, false) });
    fillLive = svgEl("path", { class: "lr-fill lr-live", d: "" });
    curveLive = svgEl("path", { class: "lr-curve lr-live", d: "" });
    svg.append(fillGhost, fillLive, curveGhost, curveLive);

    heldR = []; useR = []; ghostR = []; rowHit = [];
    D!.off.bars.forEach((o, i) => {
      // What the bar gives up. The consumers never move between the two runs
      // (checked: cmin and cmax are identical for every fragment in both
      // kernels), so the only thing that changes is where the load is issued,
      // and the ghost is exactly the span it stops holding.
      const ghost = svgEl("rect", {
        class: "lr-ghost", y: rowY(i), height: BAR_H,
        x: x(o.issued), width: Math.max(0, x(o.cmin) - x(o.issued)), opacity: 0,
      });
      svg.append(ghost);
      ghostR.push(ghost);
      const held = svgEl("rect", { class: "lr-held", y: rowY(i), height: BAR_H, x: 0, width: 0 });
      const use = svgEl("rect", {
        class: `lr-use${D!.on.bars[i].clamped ? " is-clamped" : ""}`,
        y: rowY(i), height: BAR_H, x: 0, width: 0,
      });
      const hit = svgEl("rect", {
        class: "lr-rowhit", x: G.x0, y: rowY(i) - (ROW - BAR_H) / 2,
        width: G.x1 - G.x0, height: ROW,
      });
      hit.addEventListener("pointerdown", (ev) => {
        ev.stopPropagation();
        ev.preventDefault();
        pick(picked === i ? -1 : i);
      });
      svg.append(held, use, hit);
      heldR.push(held); useR.push(use); rowHit.push(hit);
    });

    drawRowTicks(svg, G, { n: NF, y: rowY, barH: BAR_H, row: ROW });
    drawYLabel(svg, { x: 12, cy: rowY(NF / 2), lines: ["ds_load fragment"] });
    drawYLabel(svg, {
      x: 12, cy: (G.histTop + G.histBot) / 2,
      lines: ["live VGPRs", "(measured by the scheduler)"],
    });
  }

  // The wait figure: one bar per s_wait_dscnt at the WMMA it sits after, as tall
  // as the number of DS ops it actually stalls on. Every DS op must be waited
  // for exactly once, so the totals are equal by construction -- what the
  // mutation changes is whether that total arrives as a few huge stalls or many
  // small ones, which is the only thing this chart is trying to show.
  function buildStalls() {
    const all = [...D!.asm.off.waits, ...D!.asm.on.waits];
    const top = Math.max(1, ...all.map((w) => w.stalled)) * 1.12;
    const sy = (v: number) => G.histBot - (v / top) * (G.histBot - G.barsTop);
    drawYTicks(svg, { ...G, histTop: G.barsTop }, { values: niceTicks(top), y: sy });

    const bw = Math.max(2.2, (G.x1 - G.x0) / 128 * 0.8);
    for (const [side, key] of [[D!.asm.off, "off"], [D!.asm.on, "on"]] as [AsmSide, string][]) {
      for (const w of side.waits) {
        const r = svgEl("rect", {
          class: `lr-stall lr-${key}`, x: x(w.wmma) - bw / 2, y: sy(w.stalled),
          width: bw, height: Math.max(0, G.histBot - sy(w.stalled)),
        });
        // A wait that stalls on nothing is a zero-height bar: invisible, and
        // impossible to click. Rather than fake a minimum height -- which would
        // read as a small stall when it is none -- every wait gets a
        // transparent full-height target, so all of them are reachable and the
        // bars stay honest.
        const hit = svgEl("rect", {
          class: `lr-stallhit lr-${key}${w.line === pickedWait ? " is-on" : ""}`,
          x: x(w.wmma) - Math.max(bw, 5) / 2,
          y: G.barsTop, width: Math.max(bw, 5), height: G.histBot - G.barsTop,
        });
        (hit as SVGElement & { dataset: DOMStringMap }).dataset.line = String(w.line);
        hit.addEventListener("pointerdown", (ev) => {
          ev.stopPropagation();
          ev.preventDefault();
          pickWait(w.line, w.stalled, w.wmma, w.ops);
        });
        svg.append(r, hit);
      }
    }
    drawYLabel(svg, {
      x: 12, cy: (G.barsTop + G.histBot) / 2,
      lines: ["DS ops waited on"],
    });
  }

  // Highest pressure seen at each WMMA count, carried forward across WMMAs that
  // no pick landed on.
  function resample(s: Side): number[] {
    const g = new Array<number>(NW).fill(0);
    for (let i = 0; i < s.pressure.x.length; i++) {
      const k = Math.min(NW - 1, Math.max(0, Math.round(s.pressure.x[i])));
      g[k] = Math.max(g[k], s.pressure.y[i]);
    }
    for (let k = 1; k < NW; k++) if (g[k] === 0) g[k] = g[k - 1];
    return g;
  }

  const gridPath = (g: number[], close: boolean) =>
    seriesPath(g.map((_, i) => i), g, { x, y: py, baseY: close ? G.histBot : undefined });

  function render() {
    if (view === "stalls") {
      // Same convention as the curves: at mutation-off nothing is ghosted,
      // because there is no earlier state to compare against yet.
      svg.querySelectorAll<SVGElement>(".lr-stall.lr-off")
        .forEach((e) => e.setAttribute("opacity", String(lerp(1, 0.28, alpha))));
      svg.querySelectorAll<SVGElement>(".lr-stall.lr-on")
        .forEach((e) => e.setAttribute("opacity", String(alpha)));
      // Only the visible side is clickable, so a hidden bar cannot be picked.
      svg.querySelectorAll<SVGElement>(".lr-stallhit.lr-off")
        .forEach((e) => e.style.pointerEvents = alpha > 0.5 ? "none" : "auto");
      svg.querySelectorAll<SVGElement>(".lr-stallhit.lr-on")
        .forEach((e) => e.style.pointerEvents = alpha > 0.5 ? "auto" : "none");
      return;
    }
    D!.off.bars.forEach((o, i) => {
      const n = D!.on.bars[i];
      // Only the issue point moves: the consumers are fixed by the data flow,
      // so a load cannot be read earlier, only held for less time.
      const issued = lerp(o.issued, n.issued, alpha);
      const cmin = lerp(o.cmin, n.cmin, alpha);
      const cmax = lerp(o.cmax, n.cmax, alpha);
      heldR[i].setAttribute("x", String(x(issued)));
      heldR[i].setAttribute("width", String(Math.max(0, x(cmin) - x(issued))));
      useR[i].setAttribute("x", String(x(cmin)));
      useR[i].setAttribute("width", String(Math.max(0, x(cmax) - x(cmin))));
    });
    // Nothing is ghosted at mutation-off: there is no earlier state to show.
    ghostR.forEach((g) => g.setAttribute("opacity", String(0.3 * alpha)));
    const live = gridOff.map((v, i) => lerp(v, gridOn[i], alpha));
    curveLive.setAttribute("d", gridPath(live, false));
    fillLive.setAttribute("d", gridPath(live, true));
    curveGhost.setAttribute("opacity", String(0.3 * alpha));
    fillGhost.setAttribute("opacity", String(0.07 * alpha));
  }

  // The listing shows whichever run the toggle is on, so a fragment stays
  // selected across the switch and you see the same load in both schedules.
  // scroll=false for selections made by clicking the listing: moving the pane
  // under the pointer is disorienting, and it made a WMMA impossible to click
  // twice to cycle through the fragments it reads.
  function pick(i: number, scroll = true) {
    picked = i;
    rowHit.forEach((r, k) => r.classList.toggle("is-on", k === i));
    const side = mutation ? D!.on : D!.off;
    asm.select(i === -1 ? null : {
      lines: side.bars[i].lines, consumers: side.bars[i].consumers,
    }, scroll);
  }

  function pickWait(line: number, stalled: number, wmma: number, ops: number[] = [],
                    scroll = true) {
    picked = -1;
    pickedWait = line;
    rowHit.forEach((r) => r.classList.remove("is-on"));
    svg.querySelectorAll<SVGElement>(".lr-stallhit")
      .forEach((e) => e.classList.toggle("is-on", e.dataset.line === String(line)));
    view_select({
      lines: [line], consumers: [], ops, kind: "wait",
      label: `s_wait_dscnt after W[${wmma}], stalls on ${stalled} DS op${stalled === 1 ? "" : "s"}`,
    }, scroll);
  }

  function setView(want: "ranges" | "stalls") {
    if (want === view) return;
    view = want;
    root!.querySelectorAll<HTMLButtonElement>(".lr-view button")
      .forEach((o) => o.setAttribute("aria-pressed", String(o.dataset.view === want)));
    root!.classList.toggle("is-stalls", view === "stalls");
    build();
    render();
  }

  // The listing points back at the chart. A subload or a wait maps to exactly
  // one thing; a WMMA reads two or three fragments, so clicking it again cycles
  // through them rather than silently picking one.
  function fromLine(line: number) {
    const f = subOf.get(line);
    if (f !== undefined) { setView("ranges"); cycle = 0; pick(f, false); return; }
    const fs = consOf.get(line);
    if (fs && fs.length) {
      setView("ranges");
      const same = fs.includes(picked);
      cycle = same ? (fs.indexOf(picked) + 1) % fs.length : 0;
      pick(fs[cycle], false);
      return;
    }
    const w = waitOf.get(line);
    if (w !== undefined) {
      setView("stalls");
      const side = mutation ? D!.asm.on : D!.asm.off;
      const ww = side.waits[w];
      pickWait(ww.line, ww.stalled, ww.wmma, ww.ops, false);
    }
  }

  function indexSide() {
    const side = mutation ? D!.on : D!.off;
    const asmSide = mutation ? D!.asm.on : D!.asm.off;
    subOf = new Map(); consOf = new Map(); waitOf = new Map();
    side.bars.forEach((b, i) => {
      b.lines.forEach((l) => subOf.set(l, i));
      b.consumers.forEach((k) => {
        const l = asmSide.wmma[k];
        if (l === undefined) return;
        const cur = consOf.get(l) ?? [];
        cur.push(i);
        consOf.set(l, cur);
      });
    });
    asmSide.waits.forEach((w, i) => waitOf.set(w.line, i));
    asm.setClickable([...subOf.keys(), ...consOf.keys(), ...waitOf.keys()]);
  }

  const view_select = (t: {
    lines: number[]; consumers: number[]; label?: string;
    kind?: "load" | "wait"; ops?: number[];
  } | null, scroll = true) => asm.select(t, scroll);

  async function setMutation(on: boolean, animate: boolean) {
    mutation = on;
    dagBtns.forEach((b) => b.setAttribute("aria-pressed", String((b.dataset.dag === "on") === on)));
    void asm.show(on ? D!.asm.on : D!.asm.off).then(() => { indexSide(); pick(picked); });
    const from = alpha, to = on ? 1 : 0;
    if (!animate || from === to) { alpha = to; render(); return; }
    await play((a) => { alpha = lerp(from, to, a); render(); }, 620, smooth);
    alpha = to;
    render();
  }

  dagBtns.forEach((b) => b.addEventListener("click", () => {
    const want = b.dataset.dag === "on";
    if (want === mutation) return;
    void setMutation(want, true);
  }));

  async function loadKernel(key: string) {
    const file = `./lifelines-${key}.json`;
    let d: Data;
    try {
      // The catch covers the load ONLY -- see budget.ts for why that matters.
      const r = await fetch(file);
      if (!r.ok) throw new Error(`HTTP ${r.status}`);
      d = (await r.json()) as Data;
    } catch {
      legend.textContent = `could not load ${file}`;
      return;
    }
    root!.querySelectorAll<HTMLButtonElement>(".lr-kernels button")
      .forEach((b) => b.setAttribute("aria-pressed", String(b.dataset.kernel === key)));
    D = d;
    NF = d.off.bars.length;
    x = xScaleFor(G, NW);
    const rg = rowsIn(G, NF);
    ROW = rg.row; BAR_H = rg.barH; rowY = rg.y;
    yMax = Math.max(...d.off.pressure.y, ...d.on.pressure.y) * 1.08;
    gridOff = resample(d.off);
    gridOn = resample(d.on);
    build();
    picked = -1;
    void setMutation(mutation, false);
  }

  root.querySelectorAll<HTMLButtonElement>(".lr-kernels button").forEach((b) =>
    b.addEventListener("click", () => {
      if (b.getAttribute("aria-pressed") === "true") return;
      void loadKernel(b.dataset.kernel!);
    }));

  const asm = new AsmView({
    root,
    code: q<HTMLElement>(".av-code"),
    status: q<HTMLElement>(".av-status"),
    prev: q<HTMLButtonElement>('[data-av="prev"]'),
    next: q<HTMLButtonElement>('[data-av="next"]'),
    toggle: q<HTMLButtonElement>('[data-av="scope"]'),
    onLine: (line) => fromLine(line),
  });

  Array.from(root.querySelectorAll<HTMLButtonElement>(".lr-view button")).forEach((b) =>
    b.addEventListener("click", () => {
      setView(b.dataset.view as "ranges" | "stalls");
      asm.select(null);
    }));

  void loadKernel("mxfp");
}
