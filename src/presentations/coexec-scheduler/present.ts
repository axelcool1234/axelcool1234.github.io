// Slide navigation for the CoExec deck.
//
// manim-slides would normally emit a reveal.js deck, but it does not build under
// nixpkgs, and the figures here are plain videos anyway. This is the whole of
// what a viewer needs for them: move between slides, autoplay on arrival, and
// get out of the way in fullscreen.

const deck = document.getElementById("deck");
if (deck) {
  const slides = Array.from(deck.querySelectorAll<HTMLElement>(".slide"));
  const overview = deck.querySelector<HTMLElement>(".deck-overview");
  const nOut = deck.querySelector<HTMLElement>(".deck-n");
  const titleOut = deck.querySelector<HTMLElement>(".deck-title");
  const totalOut = deck.querySelector<HTMLElement>(".deck-total");
  let current = 0;

  const videoOf = (i: number) => slides[i].querySelector("video") as HTMLVideoElement;

  function show(i: number, play: boolean) {
    const next = Math.max(0, Math.min(slides.length - 1, i));
    if (next !== current) videoOf(current).pause();
    current = next;

    slides.forEach((s, k) => s.classList.toggle("is-current", k === current));
    if (nOut) nOut.textContent = String(current + 1);
    if (titleOut) titleOut.textContent = slides[current].dataset.title || "";

    const v = videoOf(current);
    if (play) {
      v.currentTime = 0;
      // Autoplay can still be refused (a user gesture may not have happened yet);
      // the poster stays up and the controls work, so there is nothing to handle.
      void v.play().catch(() => {});
    }
    // Give the next slide a head start without paying for all ten up front,
    // which is the reason every <video> ships with preload="none".
    if (current + 1 < slides.length) videoOf(current + 1).preload = "metadata";
  }

  function toggleOverview(force?: boolean) {
    if (!overview) return;
    const open = force === undefined ? overview.hidden : force;
    overview.hidden = !open;
    deck.classList.toggle("is-overview", open);
    if (open) videoOf(current).pause();
  }

  // Build the overview lazily from each slide's poster, so it costs nothing
  // until it is asked for and cannot drift from the slide list.
  if (overview) {
    slides.forEach((s, i) => {
      const v = s.querySelector("video") as HTMLVideoElement;
      const b = document.createElement("button");
      b.type = "button";
      b.className = "deck-thumb";
      b.innerHTML =
        `<img src="${v.poster}" alt="" loading="lazy">` +
        `<span>${i + 1}. ${s.dataset.title || ""}</span>`;
      b.addEventListener("click", () => {
        toggleOverview(false);
        show(i, true);
      });
      overview.appendChild(b);
    });
  }

  deck.querySelectorAll<HTMLElement>("[data-act]").forEach((el) => {
    el.addEventListener("click", () => {
      const act = el.dataset.act;
      if (act === "prev") show(current - 1, true);
      else if (act === "next") show(current + 1, true);
      else if (act === "overview") toggleOverview();
      else if (act === "fullscreen") {
        if (document.fullscreenElement) void document.exitFullscreen();
        else void deck.requestFullscreen().catch(() => {});
      }
    });
  });

  document.addEventListener("keydown", (e) => {
    // Leave typing alone -- the theme picker has a search box.
    const t = e.target as HTMLElement;
    if (t && (t.tagName === "INPUT" || t.tagName === "TEXTAREA")) return;
    switch (e.key) {
      case "ArrowRight": case "PageDown": case " ":
        show(current + 1, true); e.preventDefault(); break;
      case "ArrowLeft": case "PageUp":
        show(current - 1, true); e.preventDefault(); break;
      case "Home": show(0, true); e.preventDefault(); break;
      case "End": show(slides.length - 1, true); e.preventDefault(); break;
      case "o": case "O": toggleOverview(); break;
      case "f": case "F":
        if (document.fullscreenElement) void document.exitFullscreen();
        else void deck.requestFullscreen().catch(() => {});
        break;
      case "Escape": toggleOverview(false); break;
    }
  });

  // Horizontal swipe, ignoring vertical scrolling.
  let x0 = 0, y0 = 0;
  deck.addEventListener("touchstart", (e) => {
    x0 = e.changedTouches[0].clientX;
    y0 = e.changedTouches[0].clientY;
  }, { passive: true });
  deck.addEventListener("touchend", (e) => {
    const dx = e.changedTouches[0].clientX - x0;
    const dy = e.changedTouches[0].clientY - y0;
    if (Math.abs(dx) > 60 && Math.abs(dx) > Math.abs(dy) * 1.5) {
      show(current + (dx < 0 ? 1 : -1), true);
    }
  }, { passive: true });

  if (totalOut) totalOut.textContent = String(slides.length);
  show(0, false);   // no autoplay on load; the poster is the invitation
}
