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

  let heldR: SVGElement[] = [], useR: SVGElement[] = [], ghostR: SVGElement[] = [];
  let rowHit: SVGElement[] = [];
  let picked = -1;
  // "ranges" is the live-range/pressure pair; "stalls" is the LDS wait figure
  // over the same WMMA axis. Same data file, same assembly viewer underneath.
  let view: "ranges" | "stalls" = "ranges";
  let curveOff: SVGElement, curveOn: SVGElement, fillOff: SVGElement, fillOn: SVGElement;

  const lerp = (a: number, b: number, t: number) => a + (b - a) * t;

  function build() {
    svg.replaceChildren();
    drawXAxis(svg, G, { x, ticks: TICKS, title: "WMMAs issued" });
    if (view === "stalls") { buildStalls(); return; }
    drawYTicks(svg, G, { values: niceTicks(yMax), y: py });

    // The two pressure curves are both always present: the inactive one stays
    // as a faint ghost so the comparison never leaves the screen, which is the
    // whole reason the figure has a toggle rather than two separate pictures.
    fillOff = svgEl("path", { class: "lr-fill lr-off", d: pressPath(D!.off, true) });
    fillOn = svgEl("path", { class: "lr-fill lr-on", d: pressPath(D!.on, true) });
    curveOff = svgEl("path", { class: "lr-curve lr-off", d: pressPath(D!.off, false) });
    curveOn = svgEl("path", { class: "lr-curve lr-on", d: pressPath(D!.on, false) });
    svg.append(fillOff, fillOn, curveOff, curveOn);

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
          class: `lr-stallhit lr-${key}`, x: x(w.wmma) - Math.max(bw, 5) / 2,
          y: G.barsTop, width: Math.max(bw, 5), height: G.histBot - G.barsTop,
        });
        hit.addEventListener("pointerdown", (ev) => {
          ev.stopPropagation();
          ev.preventDefault();
          pickWait(w.line, w.stalled, w.wmma);
        });
        svg.append(r, hit);
      }
    }
    drawYLabel(svg, {
      x: 12, cy: (G.barsTop + G.histBot) / 2,
      lines: ["DS ops waited on", "(per s_wait_dscnt)"],
    });
  }

  const pressPath = (s: Side, close: boolean) =>
    seriesPath(s.pressure.x, s.pressure.y, { x, y: py, baseY: close ? G.histBot : undefined });

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
    // Nothing is ghosted at mutation-off: there is no earlier state to show, and
    // a second peak hanging under the curve there just read as noise. The off
    // curve IS the ghost -- it fades back as the on curve comes up over it.
    ghostR.forEach((g) => g.setAttribute("opacity", String(0.3 * alpha)));
    curveOff.setAttribute("opacity", String(lerp(1, 0.3, alpha)));
    curveOff.setAttribute("stroke-width", String(lerp(1.6, 1.1, alpha)));
    fillOff.setAttribute("opacity", String(lerp(0.2, 0.07, alpha)));
    curveOn.setAttribute("opacity", String(alpha));
    curveOn.setAttribute("stroke-width", "1.6");
    fillOn.setAttribute("opacity", String(0.2 * alpha));
  }

  // The listing shows whichever run the toggle is on, so a fragment stays
  // selected across the switch and you see the same load in both schedules.
  function pick(i: number) {
    picked = i;
    rowHit.forEach((r, k) => r.classList.toggle("is-on", k === i));
    const side = mutation ? D!.on : D!.off;
    asm.select(i === -1 ? null : {
      lines: side.bars[i].lines, consumers: side.bars[i].consumers,
    });
  }

  function pickWait(line: number, stalled: number, wmma: number) {
    picked = -1;
    rowHit.forEach((r) => r.classList.remove("is-on"));
    view_select({ lines: [line], consumers: [],
                  label: `s_wait_dscnt after W[${wmma}] — stalls on ${stalled} DS op${stalled === 1 ? "" : "s"}` });
  }

  const view_select = (t: { lines: number[]; consumers: number[]; label?: string } | null) =>
    asm.select(t);

  async function setMutation(on: boolean, animate: boolean) {
    mutation = on;
    dagBtns.forEach((b) => b.setAttribute("aria-pressed", String((b.dataset.dag === "on") === on)));
    void asm.show(on ? D!.asm.on : D!.asm.off).then(() => pick(picked));
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
  });

  Array.from(root.querySelectorAll<HTMLButtonElement>(".lr-view button")).forEach((b) =>
    b.addEventListener("click", () => {
      const want = b.dataset.view as "ranges" | "stalls";
      if (want === view) return;
      view = want;
      root.querySelectorAll<HTMLButtonElement>(".lr-view button")
        .forEach((o) => o.setAttribute("aria-pressed", String(o.dataset.view === want)));
      root.classList.toggle("is-stalls", view === "stalls");
      build();
      render();
      asm.select(null);
    }));

  void loadKernel("mxfp");
}
