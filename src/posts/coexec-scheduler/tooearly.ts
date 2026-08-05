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

import { fadeIn, fadeOut, flip, indicate, play, wait, smooth } from "./anim.js";

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
  const caption = q<HTMLElement>(".te-caption");
  const coda = q<HTMLElement>(".te-coda");
  const progress = q<HTMLElement>(".te-progress");
  const playBtn = q<HTMLButtonElement>('[data-act="play"]');
  const stepBtn = q<HTMLButtonElement>('[data-act="step"]');

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
    stepBtn.disabled = playing || running || step >= FR.length;
    progress.textContent = step === 0 ? "" : `${step} / ${FR.length}`;
  }

  function buildQueue() {
    queue.replaceChildren(...FR.map((f) => {
      const li = document.createElement("li");
      li.className = "te-block";
      li.textContent = `ds_load → W[${f.cmin}]`;
      return li;
    }));
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

    if (step === 0 && !none.hidden) await fadeOut(none, 200).then(() => { none.hidden = true; });
    if (token !== mine) return;

    await moveNow(f.issue_off, step === 0 ? 520 : 380);
    if (token !== mine) return;

    // into the comparator, which is the only thing that happens to it: there is
    // nothing to compare it against
    await flip([...queue.querySelectorAll<HTMLElement>(".te-block"), block],
               () => comp.appendChild(block), 380);
    if (token !== mine) return;
    verdict.textContent = "tryEffectiveStall: stall 0";
    await fadeIn(verdict, 180);
    if (token !== mine) return;

    // and out onto the timeline as a held-but-unread span
    const bar = document.createElement("div");
    bar.className = "te-bar";
    bar.style.top = `${step * 14}px`;
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
    verdict.textContent = "";
    verdict.style.opacity = "1";

    step++;
    paintControls();

    if (step === FR.length) {
      const offs = FR.map((x) => x.issue_off);
      const cmins = FR.map((x) => x.cmin);
      caption.textContent =
        `issued at W[${Math.min(...offs)}–${Math.max(...offs)}]` +
        `  ·  first read at W[${Math.min(...cmins)}–${Math.max(...cmins)}]`;
      await fadeIn(caption, 260);
      if (token !== mine) return;
      await fadeIn(coda, 320);
    }
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
    nowLine.style.left = "0%";
    nowLine.dataset.label = "now: W[0]";
    counter.textContent = "0";
    verdict.textContent = "";
    verdict.style.opacity = "1";
    caption.textContent = "";
    caption.style.opacity = "1";
    coda.hidden = true;
    none.hidden = false;
    none.style.opacity = "1";
    paintControls();
  }

  stepBtn.addEventListener("click", async () => {
    if (running || playing || step >= FR.length) return;
    running = true; paintControls();
    await advance();
    running = false; paintControls();
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

  fetch("./sched-data.json")
    .then((r) => r.json())
    .then((d) => {
      FR = d.clamped as Frag[];
      WMAX = d.wmax;
      // issue order without the mutation, which is not the order they are read
      FR.sort((a, b) => a.issue_off - b.issue_off);
      rows.style.height = `${FR.length * 14}px`;
      reset();
    })
    .catch(() => {
      caption.textContent = "could not load sched-data.json";
    });
}
