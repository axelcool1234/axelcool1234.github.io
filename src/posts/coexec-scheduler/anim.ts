// A very small animation core, shaped like manim's.
//
// The widget in this post is the DOM re-telling of a manim scene, and it looked
// wrong for a specific reason: only the moving block was animated. Everything
// else -- the queue closing up behind it, the cascade highlight, the flash --
// was a class toggle followed by a sleep, so it snapped and then waited. Which
// is exactly the opposite of how manim reads, where every change is a `play`
// with a run time and a rate function.
//
// So this borrows manim's model rather than any library: `play(tick, runTime,
// rate)` drives a normalised alpha from 0 to 1, and the rate functions are
// manim's own curves. Deliberately no dependency -- manim-web is MIT and does
// all of this properly, but pulling in a whole engine to slide six rectangles
// around would be absurd.

// --- rate functions (manim's, by name) ------------------------------------

export const linear = (t: number): number => t;

// manim's default: smootherstep, 6t^5 - 15t^4 + 10t^3. Eases both ends, so
// motion settles instead of stopping dead.
export const smooth = (t: number): number => t * t * t * (10 + t * (-15 + 6 * t));

export const rushInto = (t: number): number => 2 * smooth(t / 2);
export const rushFrom = (t: number): number => 2 * smooth(t / 2 + 0.5) - 1;

// out and back on one curve -- manim uses this for Indicate/Flash.
export const thereAndBack = (t: number): number =>
  t < 0.5 ? smooth(2 * t) : smooth(2 * (1 - t));

export const reduced = (): boolean =>
  matchMedia("(prefers-reduced-motion: reduce)").matches;

// --- the runner ------------------------------------------------------------

export type Tick = (alpha: number) => void;

// Run `tick` from alpha 0 to 1 over runTime ms. Resolves when finished, so a
// scene reads as a straight sequence of awaits, like manim's self.play.
export function play(tick: Tick, runTime = 500, rate = smooth): Promise<void> {
  if (reduced() || runTime <= 0) {
    tick(1);
    return Promise.resolve();
  }
  return new Promise((resolve) => {
    const start = performance.now();
    const step = (now: number) => {
      const t = Math.min(1, (now - start) / runTime);
      tick(rate(t));
      if (t < 1) requestAnimationFrame(step);
      else resolve();
    };
    requestAnimationFrame(step);
  });
}

export const wait = (ms: number): Promise<void> =>
  new Promise((r) => setTimeout(r, reduced() ? 0 : ms));

// --- FLIP ------------------------------------------------------------------

// Measure every element that might move, apply the DOM change, then animate all
// of them from where they were.
//
// Animating only the element you moved is the bug this exists to avoid: when a
// block leaves the queue the ones below it reflow upward, and if that reflow is
// not animated the queue visibly snaps while the block glides.
export function flip(
  els: HTMLElement[],
  mutate: () => void,
  runTime = 420,
  rate = smooth,
): Promise<void> {
  const before = new Map(els.map((e) => [e, e.getBoundingClientRect()]));
  mutate();
  const moved = els
    .map((e) => {
      const f = before.get(e)!;
      const l = e.getBoundingClientRect();
      return { e, dx: f.left - l.left, dy: f.top - l.top };
    })
    .filter((m) => Math.abs(m.dx) > 0.5 || Math.abs(m.dy) > 0.5);

  if (!moved.length) return Promise.resolve();

  // Invert SYNCHRONOUSLY, before returning to the browser. play() runs its first
  // tick in requestAnimationFrame, which is one frame too late: the element has
  // already been reparented, so that frame paints it at its destination and it
  // visibly teleports there before snapping back to slide in.
  for (const m of moved) m.e.style.transform = `translate(${m.dx}px, ${m.dy}px)`;

  return play((a) => {
    const k = 1 - a;
    for (const m of moved) m.e.style.transform = `translate(${m.dx * k}px, ${m.dy * k}px)`;
  }, runTime, rate).then(() => {
    for (const m of moved) m.e.style.transform = "";
  });
}

// --- primitives ------------------------------------------------------------

export function fadeIn(el: HTMLElement, runTime = 260): Promise<void> {
  el.style.opacity = "0";
  el.hidden = false;
  return play((a) => { el.style.opacity = String(a); }, runTime, rushFrom);
}

export function fadeOut(el: HTMLElement, runTime = 200): Promise<void> {
  return play((a) => { el.style.opacity = String(1 - a); }, runTime, rushInto);
}

// manim's Indicate: swell and settle back. Used where the scene flashes the
// winner -- a scale pulse reads on a rectangle better than expanding rays do.
export function indicate(el: HTMLElement, scale = 1.18, runTime = 420): Promise<void> {
  return play((a) => {
    el.style.transform = `scale(${1 + (scale - 1) * a})`;
  }, runTime, thereAndBack).then(() => { el.style.transform = ""; });
}

// Shrink toward a target while fading -- the discard trip into the bin.
export function dissolve(el: HTMLElement, runTime = 320): Promise<void> {
  return play((a) => {
    el.style.transform = `scale(${1 - 0.25 * a})`;
    el.style.opacity = String(1 - a);
  }, runTime, rushInto);
}

// Stagger a set of animations, manim's LaggedStart.
export function laggedStart(
  make: ((i: number) => Promise<void>)[],
  lag = 90,
): Promise<void[]> {
  return Promise.all(
    make.map((fn, i) => wait(reduced() ? 0 : i * lag).then(() => fn(i))),
  );
}
