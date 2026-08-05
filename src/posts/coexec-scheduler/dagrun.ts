// "CoExecScheduler (With Mutation) on a Real Kernel" -- the DOM re-telling of
// the scene of the same name, and deliberately the same frame as the run
// without the mutation further up the page. slides_dagedges.py says the same
// thing about its manim counterpart: same timeline, same queue, same
// comparator, same counter, so read one after the other it is one scheduler
// changing behaviour rather than two diagrams.
//
// What the edge buys is eligibility. Each fragment now carries an incoming edge
// from an earlier WMMA, so it is not merely un-preferred before its floor -- it
// is not in Available at all. That is the difference that matters, because
// while Available is empty the scheduler runs
//
//     for (unsigned i = 0; Available.empty(); ++i) { bumpCycle(...); ... }
//
// and the clock advances instead of a load being issued. tryCandidateCoexec was
// never able to reach that path: a function that compares two candidates cannot
// empty the queue.
//
// The closing beat is the comparison: gray ghosts of where the same loads went
// without the mutation, on the same rows.

import { fadeIn, fadeOut, flip, indicate, play, smooth, laggedStart } from "./anim.js";
import { Frag, RunData, RunLoop, ROW_PITCH, DENSE_ABOVE, kernelSwitcher,
         speedFor } from "./schedrun.js";

const root = document.getElementById("dr");
if (root) {
  const q = <T extends Element>(s: string) => root.querySelector<T>(s)!;
  const queue = q<HTMLElement>(".te-blocks");
  const rows = q<HTMLElement>(".te-rows");
  const comp = q<HTMLElement>(".te-comp");
  const verdict = q<HTMLElement>(".te-verdict");
  const none = q<HTMLElement>(".te-none");
  const nowLine = q<HTMLElement>(".te-now");
  const counter = q<HTMLElement>(".te-count-value");
  const loopBox = q<HTMLElement>(".te-coda");
  const ghostKey = q<HTMLElement>(".dr-ghostkey");
  const caption = q<HTMLElement>("figcaption");

  let FR: Frag[] = [];
  let WMAX = 127;
  let now = 0;
  let speed = 1;
  // first[i] / last[i]: does fragment i open or close a group of fragments that
  // all become eligible at the same W[]? Two can share a floor, and then the
  // queue does not go empty between them, so the bumpCycle loop stays inactive
  // across both.
  let first: boolean[] = [];
  let last: boolean[] = [];

  const T = (ms: number) => Math.round(ms * speed);
  const pct = (w: number) => `${(w / WMAX) * 100}%`;

  const heldAt = (upto: number, at: number) =>
    FR.slice(0, upto).reduce((s, f) => s + (f.cmin > at ? f.vgprs : 0), 0);

  function buildQueue() {
    queue.style.minHeight = "";
    queue.replaceChildren(...FR.map((f) => {
      const li = document.createElement("li");
      li.className = "te-block is-gated";
      const lab = document.createElement("span");
      lab.textContent = `ds_load → W[${f.cmin}]`;
      const gate = document.createElement("span");
      gate.className = "dr-gate";
      // The floor is exactly what the new edge encodes: this load may not be
      // scheduled before that WMMA.
      gate.textContent = `≥ W[${f.floor}]`;
      li.append(lab, gate);
      return li;
    }));
    queue.style.minHeight = `${queue.offsetHeight}px`;
  }

  function moveNow(to: number, runTime: number) {
    const from = now;
    now = to;
    return play((a) => {
      const w = from + (to - from) * a;
      nowLine.style.left = pct(w);
      nowLine.dataset.label = `now: W[${Math.round(w)}]`;
    }, runTime, smooth);
  }

  // The loop only runs while Available is EMPTY, so it is live exactly when
  // nothing in the queue is eligible yet.
  const setLoop = (active: boolean) => loopBox.classList.toggle("is-active", active);

  async function advance(mine: number) {
    const step = loop.step;

    if (step === FR.length) {          // the closing beat: what it was before
      await revealGhosts(mine);
      if (loop.token !== mine) return;
      loop.step++;
      loop.paint();
      return;
    }
    if (step > FR.length) return;

    const f = FR[step];
    const block = queue.querySelector<HTMLElement>(".te-block");
    if (!block) return;

    if (first[step]) {
      if (step === 0 && none.style.visibility !== "hidden") {
        await fadeOut(none, T(200));
        none.style.visibility = "hidden";
      }
      if (loop.token !== mine) return;
      // the clock runs forward because the queue is empty -- this is the whole
      // mechanism, and it is the one thing the no-mutation run never gets to do
      await moveNow(f.issue_on, T(step === 0 ? 560 : 420));
      if (loop.token !== mine) return;
      // everything gated on this W[] becomes eligible together, and the loop
      // stops applying the moment the first of them does
      const grp = Array.from(queue.querySelectorAll<HTMLElement>(".te-block"))
        .slice(0, groupLen(step));
      setLoop(false);
      await laggedStart(grp.map((b) => () => ungate(b)), T(70));
      if (loop.token !== mine) return;
    }

    await flip([...queue.querySelectorAll<HTMLElement>(".te-block"), block],
               () => comp.appendChild(block), T(380));
    if (loop.token !== mine) return;
    verdict.style.visibility = "visible";
    await fadeIn(verdict, T(180));
    if (loop.token !== mine) return;

    const bar = document.createElement("div");
    bar.className = "te-bar";
    bar.style.top = `${(FR.length - 1 - step) * ROW_PITCH}px`;
    bar.style.left = pct(f.issue_on);
    bar.style.width = "0%";
    bar.title = `${f.vgprs} VGPRs held from W[${f.issue_on}] until W[${f.cmin}]`;
    rows.appendChild(bar);
    await Promise.all([
      fadeOut(block, T(200)).then(() => block.remove()),
      play((a) => { bar.style.width = pct((f.cmin - f.issue_on) * a); }, T(420), smooth),
    ]);
    if (loop.token !== mine) return;

    counter.textContent = String(heldAt(step + 1, f.issue_on));
    await indicate(counter, 1.25, T(300));
    if (loop.token !== mine) return;
    await fadeOut(verdict, T(140));
    verdict.style.visibility = "hidden";

    if (last[step]) setLoop(true);     // queue drained again: the loop is back

    loop.step++;
    loop.paint();
  }

  const groupLen = (from: number) => {
    let n = 1;
    while (from + n < FR.length && FR[from + n].issue_on === FR[from].issue_on) n++;
    return n;
  };

  function ungate(b: HTMLElement) {
    const gate = b.querySelector<HTMLElement>(".dr-gate");
    b.classList.remove("is-gated");
    return gate ? fadeOut(gate, T(200)).then(() => { gate.hidden = true; }) : Promise.resolve();
  }

  // Where the same loads went without the mutation, on the same rows. Behind
  // the real bars, so an overlap reads as "this part was already held".
  async function revealGhosts(mine: number) {
    const made = FR.map((f, i) => {
      const g = document.createElement("div");
      g.className = "dr-ghost";
      g.style.top = `${(FR.length - 1 - i) * ROW_PITCH}px`;
      g.style.left = pct(f.issue_off);
      g.style.width = pct(f.cmin - f.issue_off);
      g.style.opacity = "0";
      g.title = `without the mutation: issued at W[${f.issue_off}], read at W[${f.cmin}]`;
      rows.appendChild(g);
      return g;
    });
    await laggedStart(made.map((g) => () => fadeIn(g, T(260))), T(40));
    if (loop.token !== mine) return;
    ghostKey.style.visibility = "visible";
    await fadeIn(ghostKey, T(240));
  }

  function rebuild() {
    buildQueue();
    rows.replaceChildren();
    comp.querySelectorAll(".te-block").forEach((b) => b.remove());
    now = FR.length ? FR[0].issue_off : 0;   // the clock starts where the other run starts
    nowLine.style.left = pct(now);
    nowLine.dataset.label = `now: W[${now}]`;
    counter.textContent = "0";
    verdict.style.visibility = "hidden";
    verdict.style.opacity = "1";
    none.style.visibility = "";
    none.style.opacity = "1";
    ghostKey.style.visibility = "hidden";
    ghostKey.style.opacity = "1";
    setLoop(true);                            // nothing is eligible yet
  }

  const loop = new RunLoop({
    root,
    progressSel: ".te-progress",
    count: () => FR.length + 1,               // +1 for the ghost comparison
    advance,
    rebuild,
    gap: () => T(220),
  });

  kernelSwitcher(root, ".dr-kernels button", (d: RunData) => {
    FR = d.clamped.slice();
    WMAX = d.wmax;
    // issue order WITH the mutation this time, which is also floor order
    FR.sort((a, b) => a.issue_on - b.issue_on || a.cmin - b.cmin);
    first = FR.map((f, i) => i === 0 || FR[i - 1].issue_on !== f.issue_on);
    last = FR.map((f, i) => i === FR.length - 1 || FR[i + 1].issue_on !== f.issue_on);
    speed = speedFor(FR.length);
    root.classList.toggle("is-dense", FR.length > DENSE_ABOVE);
    rows.style.height = `${FR.length * ROW_PITCH}px`;
    const rng = (xs: number[]) => {
      const lo = Math.min(...xs), hi = Math.max(...xs);
      return lo === hi ? `W[${lo}]` : `W[${lo}-${hi}]`;
    };
    caption.innerHTML =
      `The same ${FR.length} loads in the same order, now issued at ` +
      `<strong>${rng(FR.map((f) => f.issue_on))}</strong> instead of ` +
      `<strong>${rng(FR.map((f) => f.issue_off))}</strong>. Shorter live ranges, and the waiting ` +
      `is hidden behind WMMA latency instead of sitting ahead of it.`;
    loop.reset();
  }, (file) => {
    queue.replaceChildren();
    queue.textContent = `could not load ${file}`;
  });
}
