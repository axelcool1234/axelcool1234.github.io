// The four DAG edits, as a diagram you can interrogate rather than watch.
//
// The talk animates these arriving one at a time, which works when someone is
// narrating. Reading, it is more useful to see all four at once and be able to
// ask what each one is for -- so the edges are clickable and the explanation is
// text, in the same spirit as the lambda-cube note.
//
// Nodes drift gently (bob + per-node jitter, pulled home by a spring, exactly as
// cube-engine.ts does) and the edges are redrawn against their live positions
// each frame, so nothing is baked into fixed coordinates.
//
// Geometry mirrors the manim scene: WMMAs in a column on the right in program
// order, the two ds_loads on the left between their consumers.

export {};   // makes this a module: otherwise its interfaces are global

const SVG_NS = "http://www.w3.org/2000/svg";

// cube-engine.ts's arrowLength / arrowSpread.
const HEAD_LEN = 12;
const HEAD_SPREAD = Math.PI / 7;

// Standoff between an arrow end and the box it meets, and the boxes' corner
// radius -- NODE_R must match the rx on the rects drawn below.
const GAP = 2;
const NODE_R = 6;

interface DagNode {
  id: string;
  label: string;
  kind: "wmma" | "ds";
  homeX: number; homeY: number;
  x: number; y: number;
  vx: number; vy: number;
  phase: number;
  w: number; h: number;
}

interface DagEdge {
  from: string;
  to: string;
  edit: number;          // index into EDITS, or -1 for an edge already in the DAG
}

const EDITS = [
  {
    key: "order",
    arrow: "WMMA → WMMA",
    what: "added: program order",
    body: `Chains each WMMA to the next in program order.`,
  },
  {
    key: "space",
    arrow: "ds_load → ds_load",
    what: "added: LDS bus spacing",
    body: `Chains the loads in order of their earliest consumer, with a latency equal to the LDS bus reciprocal throughput. Without it the loads may be correctly placed but still issued back to back, which saturates the LDS bus and makes the kernel memory bound instead of compute bound.`,
  },
  {
    key: "lat",
    arrow: "ds_load → earliest WMMA",
    what: "corrected: CoExec LDS latency",
    body: `This edge already exists (it is the dependency between a load and the first WMMA that reads it). The latency of this edge is changed to the LDS load latency determined by the CoExecScheduler.`,
  },
  {
    key: "budget",
    arrow: "earlier WMMA → ds_load",
    what: "added: budget window",
    body: `Each load fragment gets an incoming edge from the earliest WMMA it is allowed to follow, which is as early as the DAG mutation's calculated VGPR budget permits. Together with the edge to its first consumer, this forces the load into a window.`,
  },
];

const NODES: DagNode[] = [
  { id: "W0", label: "WMMA W0", kind: "wmma", homeX: 380, homeY: 50 },
  { id: "W1", label: "WMMA W1", kind: "wmma", homeX: 380, homeY: 111 },
  { id: "W2", label: "WMMA W2", kind: "wmma", homeX: 380, homeY: 171 },
  { id: "W3", label: "WMMA W3", kind: "wmma", homeX: 380, homeY: 232 },
  { id: "L1", label: "ds_load L1", kind: "ds", homeX: 130, homeY: 129 },
  { id: "L2", label: "ds_load L2", kind: "ds", homeX: 130, homeY: 191 },
].map((n, i) => ({
  ...n, x: n.homeX, y: n.homeY, vx: 0, vy: 0,
  phase: i * 0.8,   // cube's jitterPhaseStep
  w: n.kind === "wmma" ? 104 : 108, h: 28,
})) as DagNode[];

const EDGES: DagEdge[] = [
  { from: "W0", to: "W1", edit: 0 },
  { from: "W1", to: "W2", edit: 0 },
  { from: "W2", to: "W3", edit: 0 },
  { from: "L1", to: "L2", edit: 1 },
  { from: "L1", to: "W2", edit: 2 },
  { from: "L2", to: "W3", edit: 2 },
  { from: "W0", to: "L1", edit: 3 },
  { from: "W1", to: "L2", edit: 3 },
];

const root = document.getElementById("de");
if (root) {
  const svg = root.querySelector<SVGSVGElement>(".de-svg")!;
  const info = root.querySelector<HTMLElement>(".de-info")!;
  const legend = Array.from(root.querySelectorAll<HTMLButtonElement>(".de-legend button"));
  const byId = new Map(NODES.map((n) => [n.id, n]));
  let selected = -1;

  // Explicit type: with a non-literal tag name tsc cannot pick the SVG overload
  // of createElementNS and falls back to `unknown`.
  const el = (name: string, attrs: Record<string, string | number>): SVGElement => {
    const e = document.createElementNS(SVG_NS, name) as SVGElement;
    for (const [k, v] of Object.entries(attrs)) e.setAttribute(k, String(v));
    return e;
  };

  // Where an edge should meet a box: find which side the centre-to-centre line
  // leaves through, then sit GAP units outside that side.
  //
  // Two things this has to respect that a plain rectangle intersection does
  // not. The boxes are drawn after the edges, so a point landing exactly on
  // the border vanishes under the box and the arrow reads as running behind
  // it -- hence GAP, measured along the side's outward normal so every edge
  // stands off by the same amount whatever its angle. And the boxes are
  // rounded (NODE_R), so the last few units of each side are not where the
  // outline actually is: a diagonal leaving a wide, short box exits near a
  // corner, and without the clamp its tail floats several units away from the
  // curve with nothing joining them.
  function anchor(a: DagNode, b: DagNode) {
    const dx = b.x - a.x, dy = b.y - a.y;
    const hw = a.w / 2, hh = a.h / 2;
    const clamp = (v: number, lo: number, hi: number) => Math.min(hi, Math.max(lo, v));
    // Which side to use is |dx| against |dy|, not the true rectangle
    // intersection (|dx|/hw against |dy|/hh). These boxes are wide and short,
    // so for a mostly-horizontal edge the true intersection is the TOP of the
    // target a few units from its corner -- and an arrowhead there has one
    // barb running along the edge and vanishing under the box. Picking the
    // side the other node is actually on, then sliding the point along that
    // side, is also what a reader expects: an edge arriving from the right
    // should arrive on the right.
    if (Math.abs(dx) >= Math.abs(dy)) {   // meets the left or right side
      return {
        x: a.x + Math.sign(dx) * (hw + GAP),
        y: clamp(a.y + dy * (hw / Math.abs(dx)), a.y - hh + NODE_R, a.y + hh - NODE_R),
      };
    }
    return {                              // ...the top or bottom
      x: clamp(a.x + dx * (hh / Math.abs(dy)), a.x - hw + NODE_R, a.x + hw - NODE_R),
      y: a.y + Math.sign(dy) * (hh + GAP),
    };
  }

  function draw() {
    svg.replaceChildren();

    for (const [i, e] of EDGES.entries()) {
      const a = byId.get(e.from)!, b = byId.get(e.to)!;
      const p = anchor(a, b), q = anchor(b, a);
      const on = selected === -1 || selected === e.edit;
      const g = el("g", {
        class: `de-edge de-e${e.edit}${on ? "" : " is-dim"}${selected === e.edit ? " is-on" : ""}`,
      });
      g.appendChild(el("line", { x1: p.x, y1: p.y, x2: q.x, y2: q.y }));
      // The head is two short lines drawn back from the tip, which is how
      // cube-engine.ts's drawArrow builds one -- not a filled polygon. A
      // polygon converging to a point cannot cover the 2.5px line arriving at
      // that same point, so the line's edges poked out past the sides of the
      // head; three strokes of one width meeting at a round cap cannot. It
      // also means the head thickens with the line when an edge is selected,
      // instead of staying a fixed size.
      const ang = Math.atan2(q.y - p.y, q.x - p.x);
      for (const s of [-HEAD_SPREAD, HEAD_SPREAD]) {
        g.appendChild(el("line", {
          x1: q.x, y1: q.y,
          x2: q.x - Math.cos(ang + s) * HEAD_LEN,
          y2: q.y - Math.sin(ang + s) * HEAD_LEN,
        }));
      }
      // invisible fat line so the edge is easy to hit
      const hit = el("line", {
        x1: p.x, y1: p.y, x2: q.x, y2: q.y,
        // Both the width and the transparency are set in the stylesheet, not
        // here: a CSS rule beats a presentation attribute, and .de-e<n> line
        // sets a stroke colour that would otherwise paint this fat line.
        class: "de-hit",
      });
      hit.addEventListener("pointerdown", (ev) => {
        ev.stopPropagation();
        ev.preventDefault();
        select(selected === e.edit ? -1 : e.edit);
      });
      g.appendChild(hit);
      g.setAttribute("data-edge", String(i));
      svg.appendChild(g);
    }

    for (const n of NODES) {
      const g = el("g", { class: `de-node de-${n.kind}` });
      g.appendChild(el("rect", {
        x: n.x - n.w / 2, y: n.y - n.h / 2, width: n.w, height: n.h, rx: NODE_R,
      }));
      const t = el("text", { x: n.x, y: n.y + 4, "text-anchor": "middle" });
      t.textContent = n.label;
      g.appendChild(t);
      svg.appendChild(g);
    }
  }

  function select(i: number) {
    selected = i;
    legend.forEach((b, k) => b.setAttribute("aria-pressed", String(k === i)));
    info.innerHTML = i === -1
      ? `<p class="de-hint">Click an edge, or a row above, to see what that edit is for.</p>`
      : `<h4><code>${EDITS[i].arrow}</code> &mdash; ${EDITS[i].what}</h4><p>${EDITS[i].body}</p>`;
    draw();
  }

  legend.forEach((b, i) =>
    b.addEventListener("click", () => select(selected === i ? -1 : i)));
  svg.addEventListener("pointerdown", (ev) => {
    if ((ev.target as Element).closest(".de-hit")) return;
    select(-1);
  });

  // Drift: one shared bob plus a per-node jitter, each node pulled back to its
  // home by a spring. Small enough that the diagram stays readable.
  // Same feel as cube-engine.ts: its speeds are what make the drift read as
  // floating rather than as a still picture. Mine were ~3.5x slower, which over
  // any short glance looked like nothing was moving at all.
  // Smaller excursions than the cube's, at the cube's speeds. Amplitude is the
  // knob for "how much movement"; slowing it down instead is what made this
  // read as a still picture earlier.
  const M = { xAmp: 1.6, yAmp: 2.6, xSpeed: 0.0015, ySpeed: 0.002,
              jAmp: 0.8, jSpeed: 0.0025, spring: 0.01, damping: 0.9 };

  function frame(t: number) {
    const bobX = Math.sin(t * M.xSpeed) * M.xAmp;
    const bobY = Math.cos(t * M.ySpeed) * M.yAmp;
    for (const n of NODES) {
      const tx = n.homeX + bobX + Math.sin(t * M.jSpeed + n.phase) * M.jAmp;
      const ty = n.homeY + bobY + Math.cos(t * M.jSpeed + n.phase) * M.jAmp;
      n.vx = (n.vx + (tx - n.x) * M.spring) * M.damping;
      n.vy = (n.vy + (ty - n.y) * M.spring) * M.damping;
      n.x += n.vx;
      n.y += n.vy;
    }
    draw();
    requestAnimationFrame(frame);
  }

  select(-1);
  // Unconditionally, as the lambda cube does. Gating this on
  // prefers-reduced-motion meant the diagram floated on a phone and sat frozen
  // on any machine with the OS setting on, which is not a difference anyone
  // would attribute to their accessibility preferences.
  requestAnimationFrame(frame);
}
