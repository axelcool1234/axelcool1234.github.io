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
// Motion uses FLIP (measure, move in the DOM, invert, play) rather than absolute
// coordinates, so the layout stays honest: blocks really do move between the
// queue, the slots and the bin, and it reflows correctly at any width.

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
  const exhausted = q<HTMLElement>(".rq-exhausted");
  const caption = q<HTMLElement>(".rq-caption");
  const progress = q<HTMLElement>(".rq-progress");
  const winnerSlot = q<HTMLElement>('[data-slot="winner"]');
  const candSlot = q<HTMLElement>('[data-slot="candidate"]');
  const bin = q<HTMLElement>('[data-slot="bin"]');
  const rungs = Array.from(root.querySelectorAll<HTMLElement>(".rq-ladder li"));
  const blocks = Array.from(root.querySelectorAll<HTMLElement>(".rq-block"));
  // the button label, not li.textContent -- the li also contains the explanation
  const rungName = rungs.map((li) => li.querySelector("button")!.textContent!.trim());
  const home = blocks.map((b) => b.cloneNode(true) as HTMLElement);

  const reduced = matchMedia("(prefers-reduced-motion: reduce)").matches;
  const sleep = (ms: number) =>
    new Promise((r) => setTimeout(r, reduced ? 0 : ms));

  // --- FLIP ---------------------------------------------------------------
  // Move `el` into `to` and animate from wherever it used to be. Without this
  // the blocks would teleport, and the movement is the explanation.
  function move(el: HTMLElement, to: HTMLElement): Promise<void> {
    const first = el.getBoundingClientRect();
    to.appendChild(el);
    const last = el.getBoundingClientRect();
    const dx = first.left - last.left;
    const dy = first.top - last.top;
    if (reduced || (!dx && !dy)) return Promise.resolve();
    el.style.transition = "none";
    el.style.transform = `translate(${dx}px, ${dy}px)`;
    // force a reflow so the browser does not coalesce the two styles
    void el.offsetWidth;
    el.style.transition = "transform 380ms cubic-bezier(.4,0,.2,1)";
    el.style.transform = "";
    return new Promise((r) => setTimeout(r, 380));
  }

  // --- state --------------------------------------------------------------
  let step = 0;            // 0 = FirstValid, 1..N = ROUNDS, N+1 = issued
  let winner: HTMLElement | null = null;
  let running = false;
  let token = 0;           // bumped on reset, so a running play() bails out

  const buttons = ["play", "step"].map(
    (a) => root.querySelector<HTMLButtonElement>(`[data-act="${a}"]`)!);

  // Clicks during an in-flight round used to be dropped with no feedback, which
  // read as an unresponsive widget.
  function setBusy(on: boolean) {
    running = on;
    buttons.forEach((b) => { b.disabled = on || (!on && finished()); });
  }

  function setCaption(text: string, kind = "") {
    caption.textContent = text;
    caption.className = "rq-caption" + (kind ? ` is-${kind}` : "");
  }

  function setProgress() {
    const total = ROUNDS.length + 1;
    progress.textContent = step === 0 ? "" : `${Math.min(step, total)} / ${total}`;
  }

  function clearRungs() {
    rungs.forEach((r) => r.classList.remove("is-scanning", "is-decided"));
  }

  // Walk the cascade down to `stop`, pausing on each rung, then light it red.
  // The walk IS the point: the rungs below `stop` are never reached.
  async function scan(stop: number, mine: number) {
    for (let i = 0; i <= stop; i++) {
      if (token !== mine) return;
      clearRungs();
      rungs[i].classList.add("is-scanning");
      await sleep(75);
    }
    if (token !== mine) return;
    rungs[stop].classList.remove("is-scanning");
    rungs[stop].classList.add("is-decided");
  }

  async function advance(): Promise<void> {
    const mine = token;

    if (step === 0) {
      const first = queue.querySelector<HTMLElement>(".rq-block");
      if (!first) return;
      await move(first, winnerSlot);
      if (token !== mine) return;
      winner = first;
      setCaption("FirstValid: no comparison", "ok");
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
      setCaption(`${rungName[rung]} decides`, "hot");

      const win = candWins ? cand : winner;
      const lose = candWins ? winner : cand;
      win.classList.add("is-flash");
      await sleep(320);
      if (token !== mine) return;
      win.classList.remove("is-flash");

      await move(lose, bin);
      if (token !== mine) return;
      lose.classList.add("is-gone");
      await sleep(220);
      if (token !== mine) return;
      lose.remove();

      if (candWins) await move(win, winnerSlot);
      if (token !== mine) return;
      winner = win;

      clearRungs();
      step++;
      setProgress();
      if (!queue.querySelector(".rq-block")) exhausted.hidden = false;
      return;
    }

    // queue drained: only now is anything actually issued
    setCaption("the winner is scheduled", "ok");
    if (winner) winner.classList.add("is-issued");
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
    exhausted.hidden = true;
    clearRungs();
    setCaption("");
    setProgress();
  }

  root.querySelector('[data-act="step"]')!.addEventListener("click", async () => {
    if (running || finished()) return;
    setBusy(true);
    await advance();
    setBusy(false);
  });

  root.querySelector('[data-act="play"]')!.addEventListener("click", async () => {
    if (running) return;
    if (finished()) reset();
    setBusy(true);
    const mine = token;
    while (!finished() && token === mine) {
      await advance();
      await sleep(320);
    }
    setBusy(false);
  });

  root.querySelector('[data-act="reset"]')!.addEventListener("click", () => {
    reset();
    setBusy(false);
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
        doc.scrollIntoView({ block: "nearest", behavior: reduced ? "auto" : "smooth" });
      }
    });
  });

  setProgress();
}
