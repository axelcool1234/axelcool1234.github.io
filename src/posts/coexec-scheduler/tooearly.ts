// "CoExecScheduler (No Mutation) on a Real Kernel" -- the DOM re-telling of the
// scene of the same name from the talk.
//
// Same shape as the ready-queue widget above it: the queue drains through
// tryCandidateCoexec, but here the clock is real and so are the numbers. Every
// value comes from sched-<kernel>.json, extracted from a
// -debug-only=machine-scheduler run on that kernel, so the bars on the timeline
// are where the scheduler actually put those loads.
//
// The point the figure has to land: each fragment issues far ahead of anything
// that reads it, so it sits in a register doing nothing for dozens of WMMAs.
// Not because the scheduler chose badly between two candidates -- it is the
// only thing in the queue.
//
// The frame (data, controls, pacing) lives in schedrun.ts, shared with the
// with-mutation widget further down; what is here is only what this run does.

import { fadeIn, fadeOut, flip, indicate, play, smooth } from "./anim.js";
import { Frag, RunData, RunLoop, ROW_PITCH, DENSE_ABOVE, kernelSwitcher,
         speedFor } from "./schedrun.js";

const root = document.getElementById("te");
if (root) {
  const q = <T extends Element>(s: string) => root.querySelector<T>(s)!;
  const queue = q<HTMLElement>(".te-blocks");
  const qcol = q<HTMLElement>(".te-queue");
  const rows = q<HTMLElement>(".te-rows");
  const comp = q<HTMLElement>(".te-comp");
  const verdict = q<HTMLElement>(".te-verdict");
  const none = q<HTMLElement>(".te-none");
  const nowLine = q<HTMLElement>(".te-now");
  const counter = q<HTMLElement>(".te-count-value");
  const caption = q<HTMLElement>("figcaption");

  let FR: Frag[] = [];
  let WMAX = 127;
  let now = 0;
  let speed = 1;
  const T = (ms: number) => Math.round(ms * speed);

  const pct = (w: number) => `${(w / WMAX) * 100}%`;

  // Registers actually held: a fragment is live from issue until its first
  // consumer reads it, so one whose consumer is already behind `now` is gone.
  const heldAt = (upto: number, at: number) =>
    FR.slice(0, upto).reduce((s, f) => s + (f.cmin > at ? f.vgprs : 0), 0);

  // How tall the whole stage should be, pinned once with the queue full so the
  // figure keeps its height as the queue drains.
  //
  // The block list is flex: 1 1 0, which fills the column but contributes
  // nothing to its natural height -- so left to itself the stage collapses to
  // whatever the timeline needs and a seven-block queue no longer fits. The
  // height is therefore computed: at least as tall as the timeline, and at
  // least as tall as the queue wants, but never more than QUEUE_CAP, which is
  // what stops f16's 25 blocks from growing the figure instead of scrolling.
  const QUEUE_CAP = 26 * 16;
  const stage = q<HTMLElement>(".te-stage");
  const right = q<HTMLElement>(".te-right");
  function lockQueue() {
    stage.style.minHeight = "";
    if (getComputedStyle(queue).flexDirection.startsWith("row")) return;
    const chrome = qcol.offsetHeight - queue.offsetHeight;   // heading + note
    const wanted = chrome + Math.min(queue.scrollHeight, QUEUE_CAP);
    stage.style.minHeight = `${Math.max(right.offsetHeight, wanted)}px`;
  }

  function buildQueue() {
    queue.style.minHeight = "";
    queue.replaceChildren(...FR.map((f) => {
      const li = document.createElement("li");
      li.className = "te-block";
      li.textContent = `ds_load → W[${f.cmin}]`;
      return li;
    }));
    // Reading offsetHeight forces layout, so this is the height with every
    // block present; without it the column shrinks block by block and drags
    // the timeline up the page as the queue drains.
    lockQueue();
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

  async function advance(mine: number) {
    const step = loop.step;
    if (step >= FR.length) return;
    const f = FR[step];
    const block = queue.querySelector<HTMLElement>(".te-block");
    if (!block) return;

    if (step === 0 && none.style.visibility !== "hidden") {
      // keep its box: removing it from flow shrinks the column and shifts
      // everything below by ~66px
      await fadeOut(none, T(200));
      none.style.visibility = "hidden";
    }
    if (loop.token !== mine) return;

    await moveNow(f.issue_off, T(step === 0 ? 520 : 380));
    if (loop.token !== mine) return;

    // into the comparator, which is the only thing that happens to it: there is
    // nothing to compare it against
    await flip([...queue.querySelectorAll<HTMLElement>(".te-block"), block],
               () => comp.appendChild(block), T(380));
    if (loop.token !== mine) return;
    // The text is in the markup and never removed -- only made visible. Setting
    // it here and clearing it afterwards let the box collapse between steps, and
    // min-height under-reserved it by a pixel, so the timeline below hopped down
    // and back on every single step. Same reason .te-none keeps its box.
    verdict.style.visibility = "visible";
    await fadeIn(verdict, T(180));
    if (loop.token !== mine) return;

    // and out onto the timeline as a held-but-unread span
    const bar = document.createElement("div");
    bar.className = "te-bar";
    // bottom-up: the first fragment issued sits at the bottom, so the stack
    // grows toward the reader rather than pushing everything down
    bar.style.top = `${(FR.length - 1 - step) * ROW_PITCH}px`;
    bar.style.left = pct(f.issue_off);
    bar.style.width = "0%";
    bar.title = `${f.vgprs} VGPRs held from W[${f.issue_off}] until W[${f.cmin}]`;
    rows.appendChild(bar);
    await Promise.all([
      fadeOut(block, T(200)).then(() => block.remove()),
      play((a) => { bar.style.width = pct((f.cmin - f.issue_off) * a); }, T(420), smooth),
    ]);
    if (loop.token !== mine) return;

    counter.textContent = String(heldAt(step + 1, f.issue_off));
    await indicate(counter, 1.25, T(300));
    if (loop.token !== mine) return;
    await fadeOut(verdict, T(140));
    verdict.style.visibility = "hidden";

    loop.step++;
    loop.paint();
  }

  function rebuild() {
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
  }

  const loop = new RunLoop({
    root,
    progressSel: ".te-progress",
    count: () => FR.length,
    advance,
    rebuild,
    gap: () => T(220),
  });

  kernelSwitcher(root, ".te-kernels button", (d: RunData) => {
    FR = d.clamped;
    WMAX = d.wmax;
    // issue order without the mutation, which is not the order they are read
    FR.sort((a, b) => a.issue_off - b.issue_off);
    speed = speedFor(FR.length);
    // The f16 kernel has 25 fragments where the mxfp one has 7, and at the
    // default block size that queue alone is taller than everything beside it.
    // Dense shrinks the blocks rather than scrolling or wrapping them, so it
    // still reads as one ordered queue draining from the top.
    root.classList.toggle("is-dense", FR.length > DENSE_ABOVE);
    rows.style.height = `${FR.length * ROW_PITCH}px`;
    // The caption used to state the mxfp numbers as literals, which the f16
    // kernel makes false -- 25 fragments at W[15-37], read at W[60-124], not
    // seven at W[33-43]. Read them off the data instead.
    const rng = (xs: number[]) => {
      const lo = Math.min(...xs), hi = Math.max(...xs);
      return lo === hi ? `W[${lo}]` : `W[${lo}-${hi}]`;
    };
    caption.innerHTML =
      `Without the mutation all ${FR.length} fragments are scheduled at ` +
      `<strong>${rng(FR.map((f) => f.issue_off))}</strong> but are not read until ` +
      `<strong>${rng(FR.map((f) => f.cmin))}</strong>.`;
    loop.reset();
  }, (file) => {
    queue.replaceChildren();
    queue.textContent = `could not load ${file}`;
  });
}
