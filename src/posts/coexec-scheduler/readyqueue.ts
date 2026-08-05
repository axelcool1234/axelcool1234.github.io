// Interactive version of the ready-queue animation from the talk.
//
// Mirrors AMDGPUCoExecSchedStrategy::pickNodeFromQueue: one pass over the whole
// queue, each instruction in turn becoming the candidate against the reigning
// winner, loser discarded, nothing issued until the pass ends.
//
// Deliberately not a video. Everything here is DOM coloured by the theme's CSS
// variables, so it follows the theme picker like the rest of the site, and the
// heuristics can be clicked for an explanation -- neither of which a recorded
// animation can do.
//
// Every visible change goes through anim.ts rather than a class toggle, because
// the manim original animates all of them: the queue closing up, the highlight
// travelling down the cascade, the winner swelling, the loser shrinking away.

import { fadeIn, fadeOut, flip, indicate, dissolve, play, wait, reduced, smooth,
         beginSkip, endSkip } from "./anim.js";

// (candidate index, rung that decides, does the candidate win?)
const ROUNDS: [number, number, boolean][] = [
  [1, 2, true],   // tryEffectiveStall            -> candidate wins
  [2, 6, false],  // tryCriticalResource / Dep    -> winner stays
  [3, 2, true],   // tryEffectiveStall            -> candidate wins
  [4, 6, false],  // tryCriticalResource / Dep    -> winner stays
  [5, 4, true],   // tryCoexecSlot                -> candidate wins (the WMMA)
];

const root = document.getElementById("rq");
if (root) {
  const q = <T extends Element>(sel: string) => root.querySelector<T>(sel)!;
  const queue = q<HTMLElement>(".rq-blocks");
  const caption = q<HTMLElement>(".rq-caption");
  const progress = q<HTMLElement>(".rq-progress");
  const winnerSlot = q<HTMLElement>('[data-slot="winner"]');
  const candSlot = q<HTMLElement>('[data-slot="candidate"]');
  const bin = q<HTMLElement>('[data-slot="bin"]');
  const ladder = q<HTMLElement>(".rq-ladder");
  const rungs = Array.from(root.querySelectorAll<HTMLElement>(".rq-ladder li"));
  // the button label, not li.textContent -- the li also contains the explanation
  const rungName = rungs.map((li) => li.querySelector("button")!.textContent!.trim());
  const home = Array.from(root.querySelectorAll<HTMLElement>(".rq-block"))
    .map((b) => b.cloneNode(true) as HTMLElement);

  // The travelling highlight. One element that slides and stretches between
  // rungs, as in the scene -- colouring each rung in turn instead would lose
  // the sense of a single cursor walking down and stopping.
  const cursor = document.createElement("div");
  cursor.className = "rq-cursor";
  cursor.hidden = true;
  ladder.appendChild(cursor);

  // Every block currently on stage, so FLIP can animate the ones that reflow.
  const allBlocks = () => Array.from(root.querySelectorAll<HTMLElement>(".rq-block"));

  function move(el: HTMLElement, to: HTMLElement, runTime = 420) {
    return flip(allBlocks(), () => to.appendChild(el), runTime);
  }

  async function say(text: string, kind = "") {
    if (caption.textContent) await fadeOut(caption, 140);
    caption.textContent = text;
    caption.className = "rq-caption" + (kind ? ` is-${kind}` : "");
    if (text) await fadeIn(caption, 200);
    else caption.style.opacity = "1";
  }

  function placeCursor(i: number, alpha = 1, from?: DOMRect) {
    const r = rungs[i];
    const top = r.offsetTop;
    const h = r.offsetHeight;
    if (!from || alpha >= 1) {
      cursor.style.top = `${top}px`;
      cursor.style.height = `${h}px`;
      return;
    }
    cursor.style.top = `${from.top + (top - from.top) * alpha}px`;
    cursor.style.height = `${from.height + (h - from.height) * alpha}px`;
  }

  // Walk the cascade down to `stop`. The walk IS the point: the rungs below
  // `stop` are never reached, which is what makes the cascade an argument.
  async function scan(stop: number, mine: number) {
    cursor.classList.remove("is-decided");
    placeCursor(0);
    await fadeIn(cursor, 150);
    for (let i = 1; i <= stop; i++) {
      if (token !== mine) return;
      const from = { top: rungs[i - 1].offsetTop, height: rungs[i - 1].offsetHeight } as DOMRect;
      await play((a) => placeCursor(i, a, from), 150, smooth);
    }
    if (token !== mine) return;
    cursor.classList.add("is-decided");
    rungs[stop].classList.add("is-decided");
    await indicate(cursor, 1.04, 260);
  }

  async function clearCursor() {
    rungs.forEach((r) => r.classList.remove("is-decided"));
    if (!cursor.hidden) await fadeOut(cursor, 140);
    cursor.hidden = true;
    cursor.classList.remove("is-decided");
  }

  // --- state --------------------------------------------------------------
  let step = 0;            // 0 = FirstValid, 1..N = ROUNDS, N+1 = issued
  let winner: HTMLElement | null = null;
  let running = false;
  let token = 0;           // bumped on reset, so a running play() bails out

  const playBtn = root.querySelector<HTMLButtonElement>('[data-act="play"]')!;
  const prevBtn = root.querySelector<HTMLButtonElement>('[data-act="prev"]')!;
  const nextBtn = root.querySelector<HTMLButtonElement>('[data-act="next"]')!;
  let pending = 0;        // next-presses received while a step was still playing

  let playing = false;    // the play loop is running
  let stopping = false;   // Stop was pressed; finish this round, then halt

  // Clicks during an in-flight round used to be dropped with no feedback, which
  // read as an unresponsive widget. Play doubles as Stop while it runs, so it
  // stays enabled -- only a single in-flight Step locks it out.
  function paintControls() {
    playBtn.textContent = playing ? "Stop" : "Play";
    playBtn.disabled = running && !playing;
    // The arrows stay live while a step animates: pressing next again cuts the
    // current animation short rather than being ignored, so it can be spammed.
    nextBtn.disabled = playing || finished();
    prevBtn.disabled = playing || step === 0;
  }

  function setProgress() {
    const total = ROUNDS.length + 1;
    progress.textContent = step === 0 ? "" : `${Math.min(step, total)} / ${total}`;
  }

  async function advance(): Promise<void> {
    const mine = token;

    if (step === 0) {
      const first = queue.querySelector<HTMLElement>(".rq-block");
      if (!first) return;
      await move(first, winnerSlot);
      if (token !== mine) return;
      winner = first;
      await say("FirstValid: no comparison", "ok");
      step = 1;
      setProgress();
      return;
    }

    if (step <= ROUNDS.length) {
      const [, rung, candWins] = ROUNDS[step - 1];
      const cand = queue.querySelector<HTMLElement>(".rq-block");
      if (!cand || !winner) return;

      await move(cand, candSlot);
      if (token !== mine) return;

      await scan(rung, mine);
      if (token !== mine) return;
      await say(`${rungName[rung]} decides`, "hot");

      const win = candWins ? cand : winner;
      const lose = candWins ? winner : cand;
      await indicate(win);
      if (token !== mine) return;

      await move(lose, bin, 380);
      if (token !== mine) return;
      await dissolve(lose);
      if (token !== mine) return;
      // Removing it reflows the bin, so let the others settle into place.
      await flip(allBlocks().filter((b) => b !== lose), () => lose.remove(), 220);

      if (candWins) await move(win, winnerSlot);
      if (token !== mine) return;
      winner = win;

      await clearCursor();
      if (token !== mine) return;
      step++;
      setProgress();
      return;
    }

    // queue drained: only now is anything actually issued
    await say("the winner is scheduled", "ok");
    if (winner) {
      winner.classList.add("is-issued");
      await indicate(winner, 1.12, 460);
    }
    if (token !== mine) return;
    step++;
    setProgress();
  }

  function finished() {
    return step > ROUNDS.length + 1;
  }

  function reset() {
    token++;
    running = false;
    step = 0;
    winner = null;
    [winnerSlot, candSlot, bin].forEach((s) =>
      s.querySelectorAll(".rq-block").forEach((b) => b.remove()));
    queue.replaceChildren(...home.map((b) => b.cloneNode(true) as HTMLElement));
    rungs.forEach((r) => r.classList.remove("is-decided"));
    cursor.hidden = true;
    cursor.classList.remove("is-decided");
    caption.textContent = "";
    caption.className = "rq-caption";
    caption.style.opacity = "";
    setProgress();
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
    if (playing || finished()) return;
    if (running) {           // cut the in-flight step short and queue another
      pending++;
      beginSkip();
      return;
    }
    running = true;
    paintControls();
    // Drain queued presses with animation suppressed, so holding down the arrow
    // fast-forwards instead of playing every step at full speed in turn.
    for (;;) {
      await advance();
      if (pending <= 0 || finished()) break;
      pending--;
      beginSkip();
    }
    endSkip();
    pending = 0;
    running = false;
    paintControls();
  });

  prevBtn.addEventListener("click", () => {
    if (playing || step === 0) return;
    pending = 0;
    running = false;
    void seek(step - 1);
  });

  playBtn.addEventListener("click", async () => {
    // Second press: ask the loop to halt. It finishes the round it is in rather
    // than cutting a block off mid-flight, so the widget always comes to rest on
    // a step boundary.
    if (playing) {
      stopping = true;
      return;
    }
    if (running) return;
    if (finished()) reset();

    playing = true;
    stopping = false;
    paintControls();
    const mine = token;
    while (!finished() && token === mine && !stopping) {
      running = true;
      await advance();
      running = false;
      if (stopping || token !== mine) break;
      await wait(260);
    }
    playing = false;
    stopping = false;
    running = false;
    paintControls();
  });

  root.querySelector('[data-act="reset"]')!.addEventListener("click", () => {
    reset();
    playing = false;
    stopping = false;
    running = false;
    paintControls();
  });


  // --- heuristic explanations --------------------------------------------
  // The prose lives in the HTML, so it is readable and indexable with JS off;
  // this only collapses it into one panel and toggles which is shown.
  rungs.forEach((li) => {
    const btn = li.querySelector("button")!;
    const doc = li.querySelector<HTMLElement>(".rq-doc")!;
    btn.setAttribute("aria-expanded", "false");
    li.classList.add("is-collapsible");
    btn.addEventListener("click", () => {
      const open = li.classList.contains("is-open");
      rungs.forEach((o) => {
        o.classList.remove("is-open");
        o.querySelector("button")!.setAttribute("aria-expanded", "false");
      });
      if (!open) {
        li.classList.add("is-open");
        btn.setAttribute("aria-expanded", "true");
        doc.scrollIntoView({ block: "nearest", behavior: reduced() ? "auto" : "smooth" });
      }
    });
  });

  setProgress();
  paintControls();
}
