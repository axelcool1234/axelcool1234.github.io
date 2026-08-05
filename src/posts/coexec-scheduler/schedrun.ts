// Shared machinery for the two "CoExecScheduler on a Real Kernel" widgets.
//
// They are deliberately the same picture -- same queue, same comparator, same
// counter, same timeline -- so that read one after the other they show one
// scheduler changing behaviour rather than two unrelated diagrams. The talk
// does this too: slides_dagedges.py's header says "Deliberately the SAME frame
// as anim_tooearly.py". What differs is only where the loads end up.
//
// So the frame lives here: the data files, the step/play/prev machinery, the
// pace scaling and the queue-length-dependent layout. Each widget supplies its
// own advance() and its own reading of the same numbers -- issue_off for the
// run without the mutation, issue_on for the run with it.

import { wait, beginSkip, endSkip } from "./anim.js";

export interface Frag {
  vgprs: number;
  cmin: number;         // first consumer
  cmax: number;         // last consumer
  floor: number;        // earliest WMMA the VGPR budget allows -- the DAG edge
  issue_off: number;    // where CoExec actually issued it, mutation off
  issue_on: number;     // ...and with the mutation
}

export interface RunData {
  kernel: string;
  wmax: number;
  clamped: Frag[];
}

// Vertical pitch of one timeline bar, in px. Shared so the two timelines line
// up row for row when you scroll between them.
export const ROW_PITCH = 14;

// Durations in both widgets are quoted at the pace that suits the mxfp GEMM's
// seven fragments, then scaled so a longer queue takes about the same
// wall-clock time overall rather than n times as long -- f16 has 25, and at the
// seven-fragment pace a full run ran close to a minute. Floored so the steps
// stay individually legible however long the queue gets.
const BASE_FRAGS = 7;
const MIN_SPEED = 0.3;
export const speedFor = (n: number) => Math.max(MIN_SPEED, Math.min(1, BASE_FRAGS / n));

// Above this many fragments the queue column is taller than everything beside
// it, and the blocks shrink rather than the column scrolling or wrapping.
export const DENSE_ABOVE = 12;

// Wire the kernel buttons and hand the parsed data back. Files are fetched once
// and cached, so switching back and forth is instant.
export function kernelSwitcher(
  root: HTMLElement,
  selector: string,
  onLoad: (d: RunData) => void,
  onError: (file: string) => void,
): void {
  const cache = new Map<string, RunData>();
  const btns = Array.from(root.querySelectorAll<HTMLButtonElement>(selector));

  async function load(key: string) {
    let d = cache.get(key);
    if (!d) {
      const file = `./sched-${key}.json`;
      try {
        // The catch covers the LOAD only. Wrapping the render too made a
        // rendering bug report itself as a missing file, which is a lie that
        // costs an hour to see through.
        const r = await fetch(file);
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        d = (await r.json()) as RunData;
      } catch {
        onError(file);
        return;
      }
      cache.set(key, d);
    }
    btns.forEach((b) => b.setAttribute("aria-pressed", String(b.dataset.kernel === key)));
    onLoad(d);
  }

  btns.forEach((b) => b.addEventListener("click", () => {
    if (b.getAttribute("aria-pressed") === "true") return;
    void load(b.dataset.kernel!);
  }));

  void load(btns[0]?.dataset.kernel ?? "mxfp");
}

// The prev / play / next / reset loop.
//
// `token` is the cancellation signal: every reset bumps it, and a step that
// finds it changed mid-flight abandons whatever it was doing rather than
// painting over a widget that has since been rebuilt.
export class RunLoop {
  step = 0;
  token = 0;
  private running = false;
  private playing = false;
  private stopping = false;
  private pending = 0;   // next-presses arriving while a step was still playing

  private readonly playBtn: HTMLButtonElement;
  private readonly prevBtn: HTMLButtonElement;
  private readonly nextBtn: HTMLButtonElement;
  private readonly progress: HTMLElement;

  constructor(private o: {
    root: HTMLElement;
    progressSel: string;
    count: () => number;          // total steps, which is per-kernel
    advance: (mine: number) => Promise<void>;
    rebuild: () => void;          // put the widget back in its step-0 state
    gap: () => number;            // ms between steps while playing
  }) {
    const q = <T extends Element>(s: string) => o.root.querySelector<T>(s)!;
    this.playBtn = q<HTMLButtonElement>('[data-act="play"]');
    this.prevBtn = q<HTMLButtonElement>('[data-act="prev"]');
    this.nextBtn = q<HTMLButtonElement>('[data-act="next"]');
    this.progress = q<HTMLElement>(o.progressSel);

    this.nextBtn.addEventListener("click", () => void this.onNext());
    this.prevBtn.addEventListener("click", () => this.onPrev());
    this.playBtn.addEventListener("click", () => void this.onPlay());
    q<HTMLElement>('[data-act="reset"]').addEventListener("click", () => this.reset());
  }

  paint(): void {
    const n = this.o.count();
    this.playBtn.textContent = this.playing ? "Stop" : "Play";
    this.playBtn.disabled = this.running && !this.playing;
    // Live while a step animates: pressing next again cuts it short instead of
    // being dropped, so the arrow can be spammed to reach a given step.
    this.nextBtn.disabled = this.playing || this.step >= n;
    this.prevBtn.disabled = this.playing || this.step === 0;
    this.progress.textContent = this.step === 0 ? "" : `${this.step} / ${n}`;
  }

  reset(): void {
    this.token++;
    this.step = 0;
    this.running = this.playing = this.stopping = false;
    this.pending = 0;
    this.o.rebuild();
    this.paint();
  }

  // Replay from the start with every animation collapsed, to land on `target`.
  // Stepping backwards has no undo: rebuilding is the only way to be sure the
  // state matches what stepping forwards would have produced.
  private async seek(target: number): Promise<void> {
    this.reset();             // bumps the token itself, cancelling anything in flight
    const mine = this.token;  // ...so capture it AFTER, or the replay aborts at once
    beginSkip();
    for (let i = 0; i < target && this.token === mine; i++) await this.o.advance(mine);
    endSkip();
    this.paint();
  }

  private async onNext(): Promise<void> {
    if (this.playing || this.step >= this.o.count()) return;
    if (this.running) {        // cut the in-flight step short and queue another
      this.pending++;
      beginSkip();
      return;
    }
    this.running = true; this.paint();
    // Drain queued presses with animation suppressed, so holding down the arrow
    // fast-forwards instead of playing every step at full speed in turn.
    for (;;) {
      await this.o.advance(this.token);
      if (this.pending <= 0 || this.step >= this.o.count()) break;
      this.pending--;
      beginSkip();
    }
    endSkip();
    this.pending = 0;
    this.running = false; this.paint();
  }

  private onPrev(): void {
    if (this.playing || this.step === 0) return;
    this.pending = 0;
    this.running = false;
    void this.seek(this.step - 1);
  }

  private async onPlay(): Promise<void> {
    if (this.playing) { this.stopping = true; return; }
    if (this.running) return;
    if (this.step >= this.o.count()) this.reset();
    this.playing = true; this.stopping = false; this.paint();
    const mine = this.token;
    while (this.step < this.o.count() && this.token === mine && !this.stopping) {
      this.running = true;
      await this.o.advance(mine);
      this.running = false;
      if (this.stopping || this.token !== mine) break;
      await wait(this.o.gap());
    }
    this.playing = this.stopping = this.running = false;
    this.paint();
  }
}
