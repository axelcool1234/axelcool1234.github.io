// "Calculating Each Load Fragment's Window" -- the DOM re-telling of the slide
// of the same name.
//
// The slide exists to answer the first question a maintainer asks: where does
// the number in "this load may not issue before W[59]" come from? A mutation
// with a tuned constant in it is one you can reject on principle. There is no
// constant. The ceiling is the peak of the as-late-as-possible schedule -- the
// minimum-pressure schedule the DAG admits -- and every number below is read
// out of a -debug-only=amdgpu-wmma-sched run, not chosen.
//
// Top panel: one bar per ds_load fragment, red from where it is issued to its
// first consumer (held live but unread) and blue across its consumers. Bottom:
// the live-VGPR histogram those bars add up to, with the budget line across it.
//
// Stepping pulls each fragment as early as that budget allows. The thing to
// watch is the peak: the debunch fills the valleys and never raises the roof,
// which is exactly what makes the ceiling safe to use as a ceiling.
//
// Unlike the talk, the bars are clickable -- which is the only way to answer
// "where did W[59] come from?" for a specific fragment rather than in general.

import { play, wait, smooth, beginSkip, endSkip } from "./anim.js";
import { Geom, svgEl, xScaleFor, rowsIn, drawXAxis, drawYLabel, drawYTicks,
         drawRowTicks, niceTicks, stepPath } from "./chart.js";

interface Frag {
  vgprs: number;
  alap: number;         // as-late-as-possible issue point
  earliest: number;     // as early as the budget allows
  cmin: number;         // first consumer
  maxpos: number;       // last consumer
  clamped: boolean;     // did the budget stop it short?
  blocked_at: number | null;
  blocked_hist: number | null;
}

interface Data {
  kernel: string;
  nwmma: number;
  budget: number;
  hist_before: number[];
  hist_after: number[];
  frags: Frag[];
}

// Two panels sharing one x scale, as the figure does -- the whole point is that
// a bar moving left raises the curve under it.
const G: Geom = {
  vbW: 680, vbH: 362,
  x0: 54, x1: 672,
  barsTop: 10, barsBot: 220,
  histTop: 246, histBot: 320,
};
const TICKS = [0, 32, 64, 96, 127];

const root = document.getElementById("bw");
if (root) {
  const q = <T extends Element>(s: string) => root.querySelector<T>(s)!;
  const svg = q<SVGSVGElement>(".bw-svg");
  const sub = q<HTMLElement>(".bw-sub");
  const info = q<HTMLElement>(".bw-info");
  const progress = q<HTMLElement>(".bw-progress");
  const playBtn = q<HTMLButtonElement>('[data-act="play"]');
  const prevBtn = q<HTMLButtonElement>('[data-act="prev"]');
  const nextBtn = q<HTMLButtonElement>('[data-act="next"]');

  let D: Data | null = null;
  let NF = 0, NW = 128;
  // The two kernels have different fragment counts (23 and 36), so the rows are
  // sized to fill one fixed panel rather than being a constant height -- the
  // figure must not change shape when you switch.
  let ROW = 9.1, BAR_H = 6.4;
  let lefts: number[] = [];      // each fragment's current issue point
  let step = 0;                  // 0 = ALAP, 1 = budget shown, 1+k = k fragments moved
  let selected = -1;
  let running = false, playing = false, stopping = false, token = 0, pending = 0;

  const el = svgEl;

  let x = xScaleFor(G, NW);
  let rowY = (r: number) => G.barsTop + r;
  // Same headroom as the figure: 30% above the budget, so the line sits high in
  // the panel and the curve has somewhere to go if it ever did rise.
  const hy = (v: number) => G.histBot - (v / (D!.budget * 1.3)) * (G.histBot - G.histTop);

  // Built once and mutated, rather than redrawn: a fragment slide animates both
  // panels at 60fps and rebuilding the DOM each frame would also drop the
  // pointer listeners mid-drag.
  let heldR: SVGElement[] = [], useR: SVGElement[] = [], rowHit: SVGElement[] = [];
  let histFill: SVGElement, histLine: SVGElement, budgetG: SVGElement;

  // The live-VGPR histogram for the current bar positions. hist_before is the
  // ALAP histogram, and a fragment pulled from `alap` back to `left` is simply
  // live for that much longer -- so it adds its VGPRs over [left, alap).
  function histogram(): number[] {
    const h = D!.hist_before.slice();
    D!.frags.forEach((f, i) => {
      for (let p = Math.round(lefts[i]); p < f.alap; p++) h[p] += f.vgprs;
    });
    return h;
  }

  const hist = (h: number[], close: boolean) =>
    stepPath(h, { x, y: hy, baseY: close ? G.histBot : undefined, x0: G.x0 });

  function build() {
    svg.replaceChildren();

    drawXAxis(svg, G, { x, ticks: TICKS, title: "WMMAs issued" });
    // The VGPR scale was unlabelled: the budget line named its own value but
    // nothing else on the axis had a number, so the curve could only be read
    // as a shape. Round values, so it can be read as "about 200".
    drawYTicks(svg, G, { values: niceTicks(D!.budget * 1.3), y: hy });

    heldR = []; useR = []; rowHit = [];
    D!.frags.forEach((f, i) => {
      const held = el("rect", { class: "bw-held", y: rowY(i), height: BAR_H, x: x(f.alap), width: 0 });
      const use = el("rect", {
        class: `bw-use${f.clamped ? " is-clamped" : ""}`,
        y: rowY(i), height: BAR_H, x: x(f.cmin), width: Math.max(0, x(f.maxpos) - x(f.cmin)),
      });
      const hit = el("rect", {
        class: "bw-rowhit", x: G.x0, y: rowY(i) - (ROW - BAR_H) / 2, width: G.x1 - G.x0, height: ROW,
      });
      hit.addEventListener("pointerdown", (ev) => {
        ev.stopPropagation();
        ev.preventDefault();
        select(selected === i ? -1 : i);
      });
      svg.append(held, use, hit);
      heldR.push(held); useR.push(use); rowHit.push(hit);
    });

    drawRowTicks(svg, G, { n: NF, y: rowY, barH: BAR_H, row: ROW });
    drawYLabel(svg, { x: 12, cy: rowY(NF / 2), lines: ["ds_load fragment"] });

    histFill = el("path", { class: "bw-histfill", d: "" });
    histLine = el("path", { class: "bw-histline", d: "" });
    svg.append(histFill, histLine);

    budgetG = el("g", { class: "bw-budget", opacity: 0 });
    budgetG.appendChild(el("line", { x1: G.x0, y1: hy(D!.budget), x2: G.x1, y2: hy(D!.budget) }));
    const bt = el("text", { x: G.x1, y: hy(D!.budget) - 5, "text-anchor": "end" });
    bt.textContent = `budget = ${D!.budget} VGPRs`;
    budgetG.appendChild(bt);
    svg.appendChild(budgetG);

    drawYLabel(svg, {
      x: 12, cy: (G.histTop + G.histBot) / 2,
      lines: ["live VGPRs", "(calculated by mutation)"],
    });
  }

  function render() {
    D!.frags.forEach((f, i) => {
      const l = x(lefts[i]);
      heldR[i].setAttribute("x", String(l));
      heldR[i].setAttribute("width", String(Math.max(0, x(f.cmin) - l)));
      const on = selected === -1 || selected === i;
      heldR[i].classList.toggle("is-dim", !on);
      useR[i].classList.toggle("is-dim", !on);
    });
    const h = histogram();
    histFill.setAttribute("d", hist(h, true));
    histLine.setAttribute("d", hist(h, false));
  }

  function paintControls() {
    playBtn.textContent = playing ? "Stop" : "Play";
    playBtn.disabled = running && !playing;
    nextBtn.disabled = playing || step > NF;
    prevBtn.disabled = playing || step === 0;
    progress.textContent = step === 0 ? "" : `${step} / ${NF + 1}`;
  }

  // Kept in flow at all times, only made visible -- an appearing line here would
  // push the whole chart down a row.
  function setStatus() {
    sub.style.visibility = step > NF ? "visible" : "hidden";
  }

  async function advance() {
    const mine = token;
    if (step > NF) return;

    if (step === 0) {
      // The chart does not change: the budget is already the peak of what is on
      // screen, which is the claim. Only the line arrives to say so.
      await play((a) => { budgetG.setAttribute("opacity", String(a)); }, 340, smooth);
      if (token !== mine) return;
      step = 1;
      setStatus();
      paintControls();
      return;
    }

    const i = step - 1;
    const f = D!.frags[i];
    const from = lefts[i], to = f.earliest;
    await play((a) => { lefts[i] = from + (to - from) * a; render(); }, 140, smooth);
    if (token !== mine) return;
    lefts[i] = to;
    render();
    step++;
    setStatus();
    paintControls();
  }

  function select(i: number) {
    selected = i;
    rowHit.forEach((r, k) => r.classList.toggle("is-on", k === i));
    if (i === -1) {
      info.innerHTML = `<p class="bw-hint">Click any fragment to see information about its window.</p>`;
    } else {
      const f = D!.frags[i];
      // Three points, in the order the pass establishes them: the window ALAP
      // gives it, what that window costs, and where the budget let it move to.
      const pulled = f.clamped
        ? `<strong>Eased back to W[${f.earliest}]</strong> and no earlier: one WMMA earlier, at
           W[${f.blocked_at}], and the live VGPR count would exceed the budget of ${D!.budget} VGPRs.`
        : `<strong>No edge added</strong>, window eased to the very top of the loop.`;
      info.innerHTML =
        `<h4>Fragment ${i}</h4>
         <ul>
           <li><strong>As late as possible</strong>: issued at W[${f.alap}], first read at
               W[${f.cmin}].</li>
           <li><strong>Uses</strong> ${f.vgprs} VGPRs, live across ${f.maxpos - f.alap + 1} WMMAs from
               issue to its last consumer, W[${f.maxpos}].</li>
           <li>${pulled}</li>
         </ul>`;
    }
    render();
  }

  function reset() {
    token++;
    step = 0;
    running = playing = stopping = false;
    pending = 0;
    lefts = D!.frags.map((f) => f.alap);
    budgetG.setAttribute("opacity", "0");
    select(-1);
    setStatus();
    paintControls();
  }

  // Replay from the start with animation collapsed; stepping backwards has no
  // undo, same as the other two widgets.
  async function seek(target: number) {
    reset();
    const mine = token;
    beginSkip();
    for (let i = 0; i < target && token === mine; i++) await advance();
    endSkip();
    paintControls();
  }

  nextBtn.addEventListener("click", async () => {
    if (playing || step > NF) return;
    if (running) { pending++; beginSkip(); return; }
    running = true; paintControls();
    for (;;) {
      await advance();
      if (pending <= 0 || step > NF) break;
      pending--;
      beginSkip();
    }
    endSkip();
    pending = 0;
    running = false; paintControls();
  });

  prevBtn.addEventListener("click", () => {
    if (playing || step === 0) return;
    pending = 0;
    running = false;
    void seek(step - 1);
  });

  playBtn.addEventListener("click", async () => {
    if (playing) { stopping = true; return; }
    if (running) return;
    if (step > NF) reset();
    playing = true; stopping = false; paintControls();
    const mine = token;
    while (step <= NF && token === mine && !stopping) {
      running = true;
      await advance();
      running = false;
      if (stopping || token !== mine) break;
      await wait(step === 1 ? 200 : 20);
    }
    playing = false; stopping = false; running = false;
    paintControls();
  });

  q<HTMLElement>('[data-act="reset"]').addEventListener("click", () => reset());
  svg.addEventListener("pointerdown", (ev) => {
    if ((ev.target as Element).closest(".bw-rowhit")) return;
    select(-1);
  });

  // The talk gives each kernel its own pair of slides. One widget can hold both:
  // same derivation, different DAG, and the contrast is the point -- f16 has an
  // 88-VGPR budget against the mxfp GEMM's 228, and clamps 25 of its 36
  // fragments where mxfp clamps 7 of 23.
  const cache = new Map<string, Data>();

  // The catch wraps ONLY the load. It used to wrap the render too, so a mistake
  // in build() surfaced as "could not load ..." while the file was being served
  // with a 200 -- a lie that costs an hour to see through. Anything below the
  // try is now a real, visible page error.
  async function loadKernel(key: string) {
    let d = cache.get(key);
    if (!d) {
      const file = `./budget-${key}.json`;
      try {
        const r = await fetch(file);
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        d = (await r.json()) as Data;
      } catch {
        info.innerHTML = `<p class="bw-hint">could not load ${file}</p>`;
        return;
      }
      cache.set(key, d);
    }
    kernelBtns.forEach((btn) =>
      btn.setAttribute("aria-pressed", String(btn.dataset.kernel === key)));
    D = d;
    NF = d.frags.length;
    NW = d.nwmma;
    x = xScaleFor(G, NW);
    const rg = rowsIn(G, NF);
    ROW = rg.row; BAR_H = rg.barH; rowY = rg.y;
    // Optional: the caption naming the kernel is not always in the markup.
    const kernel = root!.querySelector<HTMLElement>(".bw-kernel");
    if (kernel) kernel.textContent = d.kernel;
    sub.textContent =
      `${d.frags.filter((f) => f.clamped).length} of ${NF} fragments needed an edge`;
    build();
    reset();
  }

  const kernelBtns = Array.from(root.querySelectorAll<HTMLButtonElement>(".bw-kernels button"));
  kernelBtns.forEach((btn) => btn.addEventListener("click", () => {
    if (btn.getAttribute("aria-pressed") === "true") return;
    void loadKernel(btn.dataset.kernel!);
  }));

  void loadKernel(kernelBtns[0]?.dataset.kernel ?? "mxfp");
}
