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

interface Bar {
  issued: number;    // WMMA index its first subload was issued at
  cmin: number;      // first consumer
  cmax: number;      // last consumer
  vgprs: number;
  clamped: boolean;  // does the mutation constrain this one?
}

interface Side { bars: Bar[]; pressure: { x: number[]; y: number[] } }
interface Data { kernel: string; budget: number; off: Side; on: Side }

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
  const caption = q<HTMLElement>("figcaption");
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

  let heldR: SVGElement[] = [], useR: SVGElement[] = [];
  let curveOff: SVGElement, curveOn: SVGElement, fillOff: SVGElement, fillOn: SVGElement;

  const lerp = (a: number, b: number, t: number) => a + (b - a) * t;

  function build() {
    svg.replaceChildren();
    drawXAxis(svg, G, { x, ticks: TICKS, title: "WMMAs issued" });
    drawYTicks(svg, G, { values: niceTicks(yMax), y: py });

    // The two pressure curves are both always present: the inactive one stays
    // as a faint ghost so the comparison never leaves the screen, which is the
    // whole reason the figure has a toggle rather than two separate pictures.
    fillOff = svgEl("path", { class: "lr-fill lr-off", d: pressPath(D!.off, true) });
    fillOn = svgEl("path", { class: "lr-fill lr-on", d: pressPath(D!.on, true) });
    curveOff = svgEl("path", { class: "lr-curve lr-off", d: pressPath(D!.off, false) });
    curveOn = svgEl("path", { class: "lr-curve lr-on", d: pressPath(D!.on, false) });
    svg.append(fillOff, fillOn, curveOff, curveOn);

    heldR = []; useR = [];
    D!.off.bars.forEach((_, i) => {
      const held = svgEl("rect", { class: "lr-held", y: rowY(i), height: BAR_H, x: 0, width: 0 });
      const use = svgEl("rect", {
        class: `lr-use${D!.on.bars[i].clamped ? " is-clamped" : ""}`,
        y: rowY(i), height: BAR_H, x: 0, width: 0,
      });
      svg.append(held, use);
      heldR.push(held); useR.push(use);
    });

    drawRowTicks(svg, G, { n: NF, y: rowY, barH: BAR_H, row: ROW });
    drawYLabel(svg, { x: 12, cy: rowY(NF / 2), lines: ["ds_load fragment"] });
    drawYLabel(svg, {
      x: 12, cy: (G.histTop + G.histBot) / 2,
      lines: ["live VGPRs", "(measured by the scheduler)"],
    });
  }

  const pressPath = (s: Side, close: boolean) =>
    seriesPath(s.pressure.x, s.pressure.y, { x, y: py, baseY: close ? G.histBot : undefined });

  function render() {
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
    for (const [e, on] of [[curveOff, false], [fillOff, false],
                           [curveOn, true], [fillOn, true]] as [SVGElement, boolean][]) {
      e.classList.toggle("is-active", on === (alpha > 0.5));
    }
    (curveOn as SVGElement).style.opacity = "";
  }

  function setCaption() {
    const peak = (s: Side) => Math.max(...s.pressure.y);
    const held = (s: Side) => s.bars.reduce((t, b) => t + (b.cmin - b.issued), 0);
    const d = peak(D!.off) - peak(D!.on);
    caption.innerHTML =
      `Peak measured pressure <strong>${peak(D!.off)} → ${peak(D!.on)} VGPRs</strong> ` +
      `(${d >= 0 ? "−" : "+"}${Math.abs(d)}), and the total time these fragments spend held but ` +
      `unread falls from <strong>${held(D!.off)}</strong> to <strong>${held(D!.on)}</strong> ` +
      `WMMA slots. Both runs are real; the toggle swaps between them.`;
  }

  async function setMutation(on: boolean, animate: boolean) {
    mutation = on;
    dagBtns.forEach((b) => b.setAttribute("aria-pressed", String((b.dataset.dag === "on") === on)));
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
      caption.textContent = `could not load ${file}`;
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
    build();
    setCaption();
    void setMutation(mutation, false);
  }

  root.querySelectorAll<HTMLButtonElement>(".lr-kernels button").forEach((b) =>
    b.addEventListener("click", () => {
      if (b.getAttribute("aria-pressed") === "true") return;
      void loadKernel(b.dataset.kernel!);
    }));

  void loadKernel("mxfp");
}
