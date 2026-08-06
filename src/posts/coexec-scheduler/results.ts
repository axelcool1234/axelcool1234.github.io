// The results: four measured metrics, two kernels, before and after.
//
// The talk gives each metric its own panel and morphs the bars from the
// no-mutation state to the mutated one. Here the four panels become four
// buttons over one chart, which keeps the y axis honest -- the values span
// 718,570 down to 2.45, and four panels sharing a page invite a comparison
// between metrics that does not mean anything.
//
// Both states are drawn side by side rather than animated: unlike the live
// ranges, there is no shape to morph, just two heights, and showing them
// together is what makes the ratio readable at a glance.
//
// Dispatch cycles and XDL efficiency come off the hardware (AM report.html);
// the spill count is kernel metadata; hide comes from the artifact's own
// analyze_asm.py. Nothing here is computed by the website.

import { svgEl } from "./chart.js";

interface Panel {
  title: string;
  off: number[];
  on: number[];
  scale: "lin" | "log";
  fmt: string;
}
interface Data { kernels: string[]; panels: Panel[] }

const VB_W = 680, VB_H = 300;
const X0 = 62, X1 = 664, TOP = 18, BOT = 232;

const root = document.getElementById("rs");
if (root) {
  const q = <T extends Element>(s: string) => root.querySelector<T>(s)!;
  const svg = q<SVGSVGElement>(".rs-svg");
  const tabs = q<HTMLElement>(".rs-tabs");

  let D: Data | null = null;
  let sel = 0;

  // "{:,.0f}" / "{:.1f}%" / "{:.0f}" -- the handful of Python formats the data
  // actually uses, rather than a general implementation of the mini-language.
  function fmt(spec: string, v: number): string {
    const dp = /\.(\d)f/.exec(spec);
    const s = v.toFixed(dp ? Number(dp[1]) : 0);
    const grouped = spec.includes(",")
      ? s.replace(/\B(?=(\d{3})+(?!\d))/g, ",") : s;
    return grouped + (spec.includes("%") ? "%" : "");
  }

  function draw() {
    const p = D!.panels[sel];
    svg.replaceChildren();
    const vals = [...p.off, ...p.on];
    const hi = Math.max(...vals, 1);

    // Log only where the data asks for it, which is the one metric whose two
    // kernels are an order of magnitude apart. Marked on the axis, because a
    // log bar chart that does not say so is a trap.
    const logs = p.scale === "log";
    const lo = logs
      ? Math.pow(10, Math.floor(Math.log10(Math.max(1, Math.min(...vals.filter((v) => v > 0))))) - 1)
      : 0;
    const top = logs ? Math.pow(10, Math.ceil(Math.log10(hi))) : hi * 1.18;
    const y = (v: number) => {
      if (!logs) return BOT - (v / top) * (BOT - TOP);
      if (v <= lo) return BOT;
      return BOT - ((Math.log10(v) - Math.log10(lo)) / (Math.log10(top) - Math.log10(lo))) * (BOT - TOP);
    };

    const ticks: number[] = [];
    if (logs) {
      for (let d = lo; d <= top + 1e-9; d *= 10) ticks.push(d);
    } else {
      const step = Math.pow(10, Math.floor(Math.log10(top / 3)));
      const s = [1, 2, 2.5, 5, 10].map((m) => m * step).find((k) => k >= top / 3) ?? step;
      for (let v = 0; v <= top; v += s) ticks.push(Math.round(v * 100) / 100);
    }
    for (const t of ticks) {
      svg.appendChild(svgEl("line", { class: "ch-grid", x1: X0, y1: y(t), x2: X1, y2: y(t) }));
      const lab = svgEl("text", { class: "ch-tick", x: X0 - 6, y: y(t) + 3, "text-anchor": "end" });
      lab.textContent = fmt(p.fmt.includes("%") ? "{:.0f}%" : "{:,.0f}", t);
      svg.appendChild(lab);
    }

    // Two kernels, each a before/after pair.
    const groupW = (X1 - X0) / D!.kernels.length;
    D!.kernels.forEach((k, i) => {
      const cx = X0 + groupW * (i + 0.5);
      const bw = Math.min(96, groupW * 0.3);
      ([["off", p.off[i]], ["on", p.on[i]]] as [string, number][]).forEach(([state, v], j) => {
        const bx = cx + (j === 0 ? -bw - 6 : 6);
        svg.appendChild(svgEl("rect", {
          class: `rs-bar rs-${state}`, x: bx, y: y(v),
          width: bw, height: Math.max(0, BOT - y(v)),
        }));
        const lab = svgEl("text", {
          class: "rs-value", x: bx + bw / 2, y: y(v) - 5, "text-anchor": "middle",
        });
        lab.textContent = fmt(p.fmt, v);
        svg.appendChild(lab);
      });
      const name = svgEl("text", { class: "rs-kernel", x: cx, y: BOT + 16, "text-anchor": "middle" });
      name.textContent = k;
      svg.appendChild(name);
    });

    svg.appendChild(svgEl("line", { class: "rs-axis", x1: X0, y1: BOT, x2: X1, y2: BOT }));
    const ylab = svgEl("text", {
      class: "ch-axis", x: 13, y: (TOP + BOT) / 2,
      "text-anchor": "middle", transform: `rotate(-90 13 ${(TOP + BOT) / 2})`,
    });
    ylab.textContent = p.title + (logs ? " (log scale)" : "");
    svg.appendChild(ylab);

  }

  function select(i: number) {
    sel = i;
    Array.from(tabs.querySelectorAll("button")).forEach((b, k) =>
      b.setAttribute("aria-pressed", String(k === i)));
    draw();
  }

  async function boot() {
    let d: Data;
    try {
      // The catch covers the load only -- see budget.ts.
      const r = await fetch("./results.json");
      if (!r.ok) throw new Error(`HTTP ${r.status}`);
      d = (await r.json()) as Data;
    } catch {
      // The caption used to absorb this; with it gone the tabs are the only
      // element guaranteed to exist before the data arrives.
      tabs.textContent = "could not load results.json";
      return;
    }
    D = d;
    tabs.replaceChildren(...d.panels.map((p, i) => {
      const b = document.createElement("button");
      b.type = "button";
      // The long ones do not fit a tab; the y axis carries the full title.
      b.textContent = p.title.replace(" (all CU)", "").replace(": mean WMMAs before first use", "");
      b.setAttribute("aria-pressed", String(i === 0));
      b.addEventListener("click", () => select(i));
      return b;
    }));
    select(0);
  }

  void boot();
}
