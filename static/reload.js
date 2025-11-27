// Simple polling-based hot reload with minimal JS.
// The build writes build.rev containing a UNIX timestamp. We poll and reload on change.
(function(){
  const endpoint = new URL('./build.rev', window.location.href).toString();
  let last = null;
  async function check(){
    try {
      const r = await fetch(endpoint, { cache: 'no-store' });
      if (!r.ok) return;
      const txt = (await r.text()).trim();
      if (last === null) {
        last = txt;
      } else if (txt !== last) {
        window.location.reload();
      }
    } catch(e) { /* ignore */ }
  }
  setInterval(check, 1000);
  check();
})();

