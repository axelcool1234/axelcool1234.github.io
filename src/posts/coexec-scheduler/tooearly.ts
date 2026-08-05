// "CoExecScheduler (No Mutation) on a Real Kernel" -- the DOM re-telling of the
// scene of the same name from the talk.
//
// Same shape as the ready-queue widget above it: the queue drains through
// tryCandidateCoexec, but here the clock is real and so are the numbers. Every
// value comes from sched-data.json, extracted from a
// -debug-only=machine-scheduler run on mxfp_gemm_canonical, so the bars on the
// timeline are where the scheduler actually put those loads.
//
// The point the figure has to land: each fragment issues around W[33-43] and is
// not read until W[88-101], so it sits in a register for ~55 WMMAs doing
// nothing. Not because the scheduler chose badly between two candidates -- it is
// the only thing in the queue.

import { fadeIn, fadeOut, flip, indicate, play, wait, smooth,
         beginSkip, endSkip } from "./anim.js";

interface Frag {
  vgprs: number;
  cmin: number;
  cmax: number;
  floor: number;
  issue_off: number;
  issue_on: number;
}

const root = document.getElementById("te");
if (root) {
  const q = <T extends Element>(s: string) => root.querySelector<T>(s)!;
  const queue = q<HTMLElement>(".te-blocks");
  const rows = q<HTMLElement>(".te-rows");
  const comp = q<HTMLElement>(".te-comp");
  const verdict = q<HTMLElement>(".te-verdict");
  const none = q<HTMLElement>(".te-none");
  const nowLine = q<HTMLElement>(".te-now");
  const counter = q<HTMLElement>(".te-count-value");
  const progress = q<HTMLElement>(".te-progress");
  const playBtn = q<HTMLButtonElement>('[data-act="play"]');
  const prevBtn = q<HTMLButtonElement>('[data-act="prev"]');
  const nextBtn = q<HTMLButtonElement>('[data-act="next"]');
  let pending = 0;        // next-presses received while a step was still playing

  let FR: Frag[] = [];
  let WMAX = 127;
  let step = 0;
  let now = 0;
  let running = false;
  let playing = false;
  let stopping = false;
  let token = 0;

  const pct = (w: number) => `${(w / WMAX) * 100}%`;

  // Registers actually held: a fragment is live from issue until its first
  // consumer reads it, so one whose consumer is already behind `now` is gone.
  const heldAt = (upto: number, at: number) =>
    FR.slice(0, upto).reduce((s, f) => s + (f.cmin > at ? f.vgprs : 0), 0);

  function paintControls() {
    playBtn.textContent = playing ? "Stop" : "Play";
    playBtn.disabled = running && !playing;
    // Live while a step animates: pressing next again cuts it short instead of
    // being dropped, so the arrow can be spammed to reach a given step.
    nextBtn.disabled = playing || step >= FR.length;
    prevBtn.disabled = playing || step === 0;
    progress.textContent = step === 0 ? "" : `${step} / ${FR.length}`;
  }

  function buildQueue() {
    queue.style.minHeight = "";
    queue.replaceChildren(...FR.map((f) => {
      const li = document.createElement("li");
      li.className = "te-block";
      li.textContent = `ds_load → W[${f.cmin}]`;
      return li;
    }));
    // Reading offsetHeight forces layout, so this is the height with all seven
    // present; without it the column shrinks block by block and drags the
    // timeline up the page as the queue drains.
    queue.style.minHeight = `${queue.offsetHeight}px`;
  }

  function moveNow(to: number, runTime = 420) {
    const from = now;
    now = to;
    return play((a) => {
      const w = from + (to - from) * a;
      nowLine.style.left = pct(w);
      nowLine.dataset.label = `now: W[${Math.round(w)}]`;
    }, runTime, smooth);
  }

  async function advance() {
    const mine = token;
    if (step >= FR.length) return;
    const f = FR[step];
    const block = queue.querySelector<HTMLElement>(".te-block");
    if (!block) return;

    if (step === 0 && none.style.visibility !== "hidden") {
      // keep its box: removing it from flow shrinks the column and shifts
      // everything below by ~66px
      await fadeOut(none, 200);
      none.style.visibility = "hidden";
    }
    if (token !== mine) return;

    await moveNow(f.issue_off, step === 0 ? 520 : 380);
    if (token !== mine) return;

    // into the comparator, which is the only thing that happens to it: there is
    // nothing to compare it against
    await flip([...queue.querySelectorAll<HTMLElement>(".te-block"), block],
               () => comp.appendChild(block), 380);
    if (token !== mine) return;
    // The text is in the markup and never removed -- only made visible. Setting
    // it here and clearing it afterwards let the box collapse between steps, and
    // min-height under-reserved it by a pixel, so the timeline below hopped down
    // and back on every single step. Same reason .te-none keeps its box.
    verdict.style.visibility = "visible";
    await fadeIn(verdict, 180);
    if (token !== mine) return;

    // and out onto the timeline as a held-but-unread span
    const bar = document.createElement("div");
    bar.className = "te-bar";
    // bottom-up: the first fragment issued sits at the bottom, so the stack
    // grows toward the reader rather than pushing everything down
    bar.style.top = `${(FR.length - 1 - step) * 14}px`;
    bar.style.left = pct(f.issue_off);
    bar.style.width = "0%";
    bar.title = `${f.vgprs} VGPRs held from W[${f.issue_off}] until W[${f.cmin}]`;
    rows.appendChild(bar);
    await Promise.all([
      fadeOut(block, 200).then(() => block.remove()),
      play((a) => { bar.style.width = pct((f.cmin - f.issue_off) * a); }, 420, smooth),
    ]);
    if (token !== mine) return;

    counter.textContent = String(heldAt(step + 1, f.issue_off));
    await indicate(counter, 1.25, 300);
    if (token !== mine) return;
    await fadeOut(verdict, 140);
    verdict.style.visibility = "hidden";

    step++;
    paintControls();
  }

  function reset() {
    token++;
    step = 0;
    now = 0;
    running = false;
    playing = false;
    stopping = false;
    buildQueue();
    rows.replaceChildren();
    comp.querySelectorAll(".te-block").forEach((b) => b.remove());
    now = FR.length ? FR[0].issue_off : 0;
    nowLine.style.left = pct(now);
    nowLine.dataset.label = `now: W[${now}]`;
    counter.textContent = "0";
    verdict.style.visibility = "hidden";
    verdict.style.opacity = "1";
    none.style.visibility = "";
    none.style.opacity = "1";
    paintControls();
  }

  // Replay from the start with every animation collapsed, to land on `target`.
  // Stepping backwards has no undo: rebuilding is the only way to be sure the
  // state matches what stepping forwards would have produced.
  async function seek(target: number) {
    reset();               // bumps the token itself, cancelling anything in flight
    const mine = token;    // ...so capture it AFTER, or the replay aborts at once
    beginSkip();
    for (let i = 0; i < target && token === mine; i++) await advance();
    endSkip();
    paintControls();
  }

  nextBtn.addEventListener("click", async () => {
    if (playing || step >= FR.length) return;
    if (running) {           // cut the in-flight step short and queue another
      pending++;
      beginSkip();
      return;
    }
    running = true; paintControls();
    // Drain queued presses with animation suppressed, so holding down the arrow
    // fast-forwards instead of playing every step at full speed in turn.
    for (;;) {
      await advance();
      if (pending <= 0 || step >= FR.length) break;
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
    if (step >= FR.length) reset();
    playing = true; stopping = false; paintControls();
    const mine = token;
    while (step < FR.length && token === mine && !stopping) {
      running = true;
      await advance();
      running = false;
      if (stopping || token !== mine) break;
      await wait(220);
    }
    playing = false; stopping = false; running = false;
    paintControls();
  });

  q<HTMLElement>('[data-act="reset"]').addEventListener("click", () => reset());

  // See budget.ts: the catch must cover the load only, or a render bug reports
  // itself as a missing file.
  fetch("./sched-data.json")
    .then((r) => {
      if (!r.ok) throw new Error(`HTTP ${r.status}`);
      return r.json();
    })
    .catch((e) => {
      q<HTMLElement>(".te-sub").textContent = "could not load sched-data.json";
      throw e;
    })
    .then((d) => {
      FR = d.clamped as Frag[];
      WMAX = d.wmax;
      // issue order without the mutation, which is not the order they are read
      FR.sort((a, b) => a.issue_off - b.issue_off);
      rows.style.height = `${FR.length * 14}px`;
      reset();
    });
}
