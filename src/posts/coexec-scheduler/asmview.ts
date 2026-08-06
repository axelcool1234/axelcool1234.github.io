// The assembly listing, with a fragment's own instructions picked out of it.
//
// The point of the whole exercise is that "this load is issued 55 WMMAs before
// anything reads it" is a claim about a real listing, and the listing is right
// there. Click a fragment in the chart and this jumps to its first subload,
// colours its subloads and the WMMAs that actually consume it, and lets you
// walk between them.
//
// Everything it needs was worked out offline by extract-asm-map.py and lives in
// lifelines-<kernel>.json: the hot-loop bounds, the line of every WMMA, and per
// fragment the lines of its subloads and the indices of its true consumers.
// Nothing here parses assembly -- it only renders it and looks up line numbers.
//
// It opens on the hot loop, which is ~740 lines of the 2200-3400 in the file.
// That is both the part that matters and small enough that no virtualisation is
// needed; the rest is one click away.

const CACHE = new Map<string, string[]>();

export interface AsmWait {
  stalled: number;
  wmma: number;
  line: number;
  ops: number[];      // the DS ops this wait actually waits on, oldest first
}
export interface AsmSide {
  file: string;
  loop: [number, number];
  wmma: number[];
  waits: AsmWait[];
}

export interface AsmTarget {
  lines: number[];        // the instructions this selection is about
  consumers: number[];    // WMMA indices that read it, for a load fragment
  label?: string;         // overrides the status line, for a wait stall
  kind?: "load" | "wait"; // which colour the picked lines take
  ops?: number[];         // DS ops a wait waits on, walked after it
}

export class AsmView {
  private lines: string[] = [];
  private side: AsmSide | null = null;
  private target: AsmTarget | null = null;
  private whole = false;
  private cursor = -1;        // index into the flattened jump list
  private jumps: number[] = [];
  // Lines that map back to something on the chart. Everything else in the
  // listing is inert, and says so by not offering a pointer.
  private clickable = new Set<number>();

  constructor(private o: {
    root: HTMLElement;
    code: HTMLElement;         // <pre> the listing is rendered into
    status: HTMLElement;
    prev: HTMLButtonElement;
    next: HTMLButtonElement;
    toggle: HTMLButtonElement; // loop only <-> whole file
    onLine?: (line: number) => void;   // a clickable instruction was picked
  }) {
    // Delegated, because the listing is re-rendered on every selection and
    // per-line listeners would have to be reattached each time.
    o.code.addEventListener("pointerdown", (ev) => {
      const el = (ev.target as Element).closest<HTMLElement>(".av-l.is-clickable");
      if (!el || !o.onLine) return;
      ev.preventDefault();
      o.onLine(Number(el.dataset.line));
    });
    o.prev.addEventListener("click", () => this.step(-1));
    o.next.addEventListener("click", () => this.step(1));
    o.toggle.addEventListener("click", () => {
      this.whole = !this.whole;
      this.render();
      this.scrollTo(this.jumps[Math.max(0, this.cursor)] ?? this.side?.loop[0] ?? 1);
    });
  }

  async show(side: AsmSide): Promise<void> {
    this.side = side;
    let src = CACHE.get(side.file);
    if (!src) {
      try {
        const r = await fetch(`./asm/${side.file}`);
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        src = (await r.text()).split("\n");
      } catch {
        this.o.code.textContent = `could not load asm/${side.file}`;
        return;
      }
      CACHE.set(side.file, src);
    }
    this.lines = src;
    this.render();
  }

  setClickable(lines: Iterable<number>): void {
    this.clickable = new Set(lines);
    this.render();
  }

  select(t: AsmTarget | null): void {
    this.target = t;
    // Subloads first, then the consumers, which is the order you would read
    // them in: where the value is produced, then where it is finally used.
    this.jumps = t
      ? [...t.lines,
         ...(t.ops ?? []),
         ...t.consumers.map((k) => this.side!.wmma[k]).filter((n) => n !== undefined)]
      : [];
    this.cursor = this.jumps.length ? 0 : -1;
    this.render();
    if (this.cursor >= 0) this.scrollTo(this.jumps[0]);
  }

  private step(d: number): void {
    if (!this.jumps.length) return;
    this.cursor = (this.cursor + d + this.jumps.length) % this.jumps.length;
    this.render();
    this.scrollTo(this.jumps[this.cursor]);
  }

  private scrollTo(line: number): void {
    let el = this.o.code.querySelector<HTMLElement>(`[data-line="${line}"]`);
    if (!el && !this.whole) {
      // A wait can wait on ops issued before the loop was entered. Rather than
      // a dead arrow, widen to the whole file so the target exists.
      this.whole = true;
      this.render();
      el = this.o.code.querySelector<HTMLElement>(`[data-line="${line}"]`);
    }
    if (!el) return;
    // scrollIntoView would scroll the page as well as the pane; this only moves
    // the pane, which is what you want when the chart above must stay put.
    // Measured from the rects rather than offsetTop: offsetTop is relative to
    // the nearest positioned ancestor, which is not the pane, so it landed
    // hundreds of lines off.
    const pane = this.o.code;
    const r = el.getBoundingClientRect(), pr = pane.getBoundingClientRect();
    pane.scrollTop += (r.top - pr.top) - pane.clientHeight / 2 + r.height / 2;
  }

  private render(): void {
    const s = this.side;
    if (!s || !this.lines.length) return;
    const [a, b] = s.loop;
    const from = this.whole ? 1 : a;
    const to = this.whole ? this.lines.length : b;

    const sub = new Set(this.target?.lines ?? []);
    const ops = new Set(this.target?.ops ?? []);
    const cons = new Set((this.target?.consumers ?? [])
      .map((k) => s.wmma[k]).filter((n) => n !== undefined));
    const wmma = new Set(s.wmma);
    const here = this.cursor >= 0 ? this.jumps[this.cursor] : -1;

    const out: string[] = [];
    for (let n = from; n <= to; n++) {
      const text = this.lines[n - 1] ?? "";
      const cls = ["av-l"];
      if (sub.has(n)) cls.push(this.target?.kind === "wait" ? "is-waitsel" : "is-sub");
      else if (ops.has(n)) cls.push("is-op");
      else if (cons.has(n)) cls.push("is-cons");
      else if (/^\s+ds_load/.test(text)) cls.push("is-ds");
      else if (/^\s+v_wmma/.test(text)) cls.push("is-wmma");
      else if (/^\s+s_wait_dscnt/.test(text)) cls.push("is-wait");
      // Spill code. Red, and the only red in the listing: 207 of these in the
      // mxfp loop without the mutation, 4 with it, which is the results
      // widget's spill count made visible.
      else if (/^\s+scratch_(store|load)/.test(text)) cls.push("is-scratch");
      if (n === here) cls.push("is-here");
      if (this.clickable.has(n)) cls.push("is-clickable");
      if (n < a || n > b) cls.push("is-outside");
      out.push(`<span class="${cls.join(" ")}" data-line="${n}">`
        + `<i>${n}</i>${esc(text) || " "}</span>`);
    }
    // Joined with nothing, not newlines: the rows are display:block inside a
    // white-space:pre pane, so a literal newline between them renders as a
    // second, empty line and the whole listing comes out double spaced.
    this.o.code.innerHTML = out.join("");

    const t = this.target;
    this.o.prev.disabled = this.o.next.disabled = !this.jumps.length;
    this.o.toggle.textContent = this.whole ? "hot loop only" : "whole file";
    this.o.status.textContent = t
      ? t.label
        ? `${t.label}${this.cursor >= 0 ? ` - at line ${this.jumps[this.cursor]}`
             + (this.cursor === 0 ? "" : ` (op ${this.cursor} of ${(t.ops ?? []).length})`) : ""}`
        : `${t.lines.length} load${t.lines.length === 1 ? "" : "s"}, `
        + `${t.consumers.length} consumer${t.consumers.length === 1 ? "" : "s"}`
        + (this.cursor >= 0 ? ` - at line ${this.jumps[this.cursor]}` : "")
      : `${s.file}, hot loop at lines ${a}-${b}`;
  }
}

const esc = (s: string) =>
  s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
