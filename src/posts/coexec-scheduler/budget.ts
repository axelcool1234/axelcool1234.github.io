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

const SVG_NS = "http://www.w3.org/2000/svg";

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

// Geometry, in viewBox units. Two panels sharing one x scale, as the figure
// does -- the whole point is that a bar moving left raises the curve under it.
const VB_W = 680, VB_H = 362;
const X0 = 54, X1 = 672;
const BARS_TOP = 10, ROW = 9.1, BAR_H = 6.4;
const HIST_TOP = 246, HIST_BOT = 320;
const TICKS = [0, 32, 64, 96, 127];

const root = document.getElementById("bw");
if (root) {
  const q = <T extends Element>(s: string) => root.querySelector<T>(s)!;
  const svg = q<SVGSVGElement>(".bw-svg");
  const status = q<HTMLElement>(".bw-status");
  const sub = q<HTMLElement>(".bw-sub");
  const info = q<HTMLElement>(".bw-info");
  const progress = q<HTMLElement>(".bw-progress");
  const playBtn = q<HTMLButtonElement>('[data-act="play"]');
  const prevBtn = q<HTMLButtonElement>('[data-act="prev"]');
  const nextBtn = q<HTMLButtonElement>('[data-act="next"]');

  let D: Data | null = null;
  let NF = 0, NW = 128;
  let lefts: number[] = [];      // each fragment's current issue point
  let step = 0;                  // 0 = ALAP, 1 = budget shown, 1+k = k fragments moved
  let selected = -1;
  let running = false, playing = false, stopping = false, token = 0, pending = 0;

  const el = (name: string, attrs: Record<string, string | number>): SVGElement => {
    const e = document.createElementNS(SVG_NS, name) as SVGElement;
    for (const [k, v] of Object.entries(attrs)) e.setAttribute(k, String(v));
    return e;
  };

  const x = (w: number) => X0 + (w / (NW - 1)) * (X1 - X0);
  // Row 0 at the BOTTOM, as the figure has it -- matplotlib's barh(r) counts up
  // from the x axis. The fragments are in issue order, so the earliest end up
  // nearest the histogram panel they feed.
  const rowY = (r: number) => BARS_TOP + (NF - 1 - r) * ROW;
  // Same headroom as the figure: 30% above the budget, so the line sits high in
  // the panel and the curve has somewhere to go if it ever did rise.
  const hy = (v: number) => HIST_BOT - (v / (D!.budget * 1.3)) * (HIST_BOT - HIST_TOP);

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

  function stepPath(h: number[], close: boolean): string {
    let d = "";
    for (let p = 0; p < NW; p++) {
      const y = hy(h[p]);
      d += `${p === 0 ? "M" : "L"}${x(p).toFixed(1)},${y.toFixed(1)}`;
      d += `L${x(Math.min(p + 1, NW - 1)).toFixed(1)},${y.toFixed(1)}`;
    }
    if (close) d += `L${x(NW - 1).toFixed(1)},${HIST_BOT}L${X0},${HIST_BOT}Z`;
    return d;
  }

  function build() {
    svg.replaceChildren();

    for (const t of TICKS) {
      svg.appendChild(el("line", {
        class: "bw-grid", x1: x(t), y1: BARS_TOP - 2, x2: x(t), y2: HIST_BOT,
      }));
      // The end labels are anchored inward: centred, W[0] hangs off the left of
      // the viewBox and W[127] gets clipped by the right edge.
      const lab = el("text", {
        class: "bw-tick", x: x(t), y: HIST_BOT + 14,
        "text-anchor": t === TICKS[0] ? "start" : t === TICKS[TICKS.length - 1] ? "end" : "middle",
      });
      lab.textContent = `W[${t}]`;
      svg.appendChild(lab);
    }
    const xlab = el("text", { class: "bw-axis", x: (X0 + X1) / 2, y: HIST_BOT + 32, "text-anchor": "middle" });
    xlab.textContent = "WMMAs issued";
    svg.appendChild(xlab);

    heldR = []; useR = []; rowHit = [];
    D!.frags.forEach((f, i) => {
      const held = el("rect", { class: "bw-held", y: rowY(i), height: BAR_H, x: x(f.alap), width: 0 });
      const use = el("rect", {
        class: `bw-use${f.clamped ? " is-clamped" : ""}`,
        y: rowY(i), height: BAR_H, x: x(f.cmin), width: Math.max(0, x(f.maxpos) - x(f.cmin)),
      });
      const hit = el("rect", {
        class: "bw-rowhit", x: X0, y: rowY(i) - (ROW - BAR_H) / 2, width: X1 - X0, height: ROW,
      });
      hit.addEventListener("pointerdown", (ev) => {
        ev.stopPropagation();
        ev.preventDefault();
        select(selected === i ? -1 : i);
      });
      svg.append(held, use, hit);
      heldR.push(held); useR.push(use); rowHit.push(hit);
    });

    // Row numbers, so a fragment named in the text below can be found in the
    // chart above -- the figure has them and they matter more here, where the
    // rows are clickable.
    for (let r = 0; r < NF; r += 5) {
      const rl = el("text", {
        class: "bw-tick", x: X0 - 6, y: rowY(r) + BAR_H - 0.5, "text-anchor": "end",
      });
      rl.textContent = String(r);
      svg.appendChild(rl);
    }

    const ylab = el("text", {
      class: "bw-axis", x: 12, y: rowY(NF / 2),
      "text-anchor": "middle", transform: `rotate(-90 12 ${rowY(NF / 2)})`,
    });
    ylab.textContent = "ds_load fragment";
    svg.appendChild(ylab);

    histFill = el("path", { class: "bw-histfill", d: "" });
    histLine = el("path", { class: "bw-histline", d: "" });
    svg.append(histFill, histLine);

    budgetG = el("g", { class: "bw-budget", opacity: 0 });
    budgetG.appendChild(el("line", { x1: X0, y1: hy(D!.budget), x2: X1, y2: hy(D!.budget) }));
    const bt = el("text", { x: X1, y: hy(D!.budget) - 5, "text-anchor": "end" });
    bt.textContent = `budget = ${D!.budget} VGPRs`;
    budgetG.appendChild(bt);
    svg.appendChild(budgetG);

    // Two lines, as the figure has it. Inside a rotated <text> a tspan's dy runs
    // along local +y, which the -90 maps to global +x -- so the second line lands
    // beside the first rather than under it, both still centred on the panel.
    const hcy = (HIST_TOP + HIST_BOT) / 2;
    const hlab = el("text", {
      class: "bw-axis", x: 12, y: hcy,
      "text-anchor": "middle", transform: `rotate(-90 12 ${hcy})`,
    });
    for (const [text, cls, dy] of [
      ["live VGPRs", "", "0"],
      ["(calculated by mutation)", "bw-axis-sub", "1.15em"],
    ] as [string, string, string][]) {
      const tsp = el("tspan", { x: 12, dy, ...(cls ? { class: cls } : {}) });
      tsp.textContent = text;
      hlab.appendChild(tsp);
    }
    svg.appendChild(hlab);
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
    histFill.setAttribute("d", stepPath(h, true));
    histLine.setAttribute("d", stepPath(h, false));
  }

  function paintControls() {
    playBtn.textContent = playing ? "Stop" : "Play";
    playBtn.disabled = running && !playing;
    nextBtn.disabled = playing || step > NF;
    prevBtn.disabled = playing || step === 0;
    progress.textContent = step === 0 ? "" : `${step} / ${NF + 1}`;
  }

  function setStatus() {
    status.textContent = step <= 1
      ? "as late as possible: every fragment issued just before its first use"
      : `extending each fragment's window as early as the budget allows (${step - 1} / ${NF})`;
    // Kept in flow at all times, only made visible -- an appearing line here
    // would push the whole chart down a row.
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
      info.innerHTML = `<p class="bw-hint">Click any fragment to see where its window came from.</p>`;
    } else {
      const f = D!.frags[i];
      // Three points, in the order the pass establishes them: the window ALAP
      // gives it, what that window costs, and where the budget let it move to.
      const pulled = f.clamped
        ? `<strong>Eased back to W[${f.earliest}]</strong> and no earlier: one WMMA earlier, at
           W[${f.blocked_at}], and the live VGPR count would exceed the budget of ${D!.budget} VGPRs.`
        : `<strong>No edge added</strong>, window eased to the very top of the loop.`;
      info.innerHTML =
        `<h4>fragment ${i}${f.clamped ? "" : " - never clamped"}</h4>
         <ul>
           <li><strong>As late as possible</strong>: issued at W[${f.alap}], first read at
               W[${f.cmin}].</li>
           <li><strong>Uses</strong> ${f.vgprs} VGPRs, consumed by ${f.maxpos - f.cmin + 1} WMMAs. Live until
               the last consumer, W[${f.maxpos}].</li>
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

  fetch("./budget-data.json")
    .then((r) => r.json())
    .then((d: Data) => {
      D = d;
      NF = d.frags.length;
      NW = d.nwmma;
      svg.setAttribute("viewBox", `0 0 ${VB_W} ${VB_H}`);
      q<HTMLElement>(".bw-kernel").textContent = d.kernel;
      q<HTMLElement>(".bw-sub").textContent =
        `${d.frags.filter((f) => f.clamped).length} of ${NF} fragments needed an edge`;
      build();
      reset();
    })
    .catch(() => {
      status.textContent = "could not load budget-data.json";
    });
}
