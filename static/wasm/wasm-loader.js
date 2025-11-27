// static/wasm/wasm-loader.js
// Minimal loader: fetch, instantiate, call run(); show concise messages
// Use a relative path so it works under GitHub Pages project sites (subpaths)
const wasmUrl = 'wasm/module.wasm';

let wasmInstance = null;

function setOutput(msg) {
  const el = document.getElementById('wasm-output');
  if (el) el.textContent = String(msg);
}

async function loadWasm() {
  const resp = await fetch(wasmUrl, { cache: 'no-store' });
  if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
  const buf = await resp.arrayBuffer();
  const bytes = new Uint8Array(buf);
  try {
    const { instance } = await WebAssembly.instantiate(bytes, {});
    wasmInstance = instance;
    return wasmInstance;
  } catch (e) {
    setOutput(`Failed to load WASM: ${e.message || e}`);
    throw e;
  }
}

async function runWasm() {
  try {
    if (!wasmInstance) {
      await loadWasm();
    }
    if (wasmInstance && wasmInstance.exports && typeof wasmInstance.exports.run === 'function') {
      const result = wasmInstance.exports.run();
      setOutput(result);
    } else {
      const keys = wasmInstance && wasmInstance.exports ? Object.keys(wasmInstance.exports) : [];
      setOutput('No export "run" found. Exports: ' + keys.join(', '));
    }
  } catch (e) {
    console.error(e);
    setOutput(`Error: ${e.message || e}`);
  }
}

function bind() {
  const btn = document.getElementById('wasm-run');
  if (!btn) return false;
  btn.addEventListener('click', () => { setOutput('Loading…'); runWasm(); });
  return true;
}

if (!bind()) {
  window.addEventListener('DOMContentLoaded', bind);
}

// Do not override any existing text in the output element.
