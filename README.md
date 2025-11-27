# Nix + AsciiDoc Site

Static site built with Nix. Each page is a tiny Nix module that can:
- Generate assets via scripts
- Render AsciiDoc to HTML
- Optionally compile a Rust crate to WASM

Includes a dev server with hot reload, feed cards with categories, and a simple theming setup.

**Quick Start**
- Build once: `nix build .#site` (outputs symlink `./result`)
- Dev server (hot reload): `nix run` -> http://localhost:8080 (outputs symlink `_site`)
- Clean local outputs: `nix run .#clean` (removes `_site` and `result`)
- Optional dev shell: `nix develop` (provides packages - asciidoctor, cargo, python, etc.)

**Navigation and Feeds**
- Top bar: `Home`, `Projects`, `Publications`, `About`, `Resume`
- Feed pages are lists of cards built from a list of page metadata:
  - `Home`: all pages with `showInIndex = true` (default), plus a mini‑about block
  - `Projects`: pages with `category = "project"`
  - `Publications`: pages with `category = "publication"`
- Each page can provide an optional `pages/<slug>/excerpt.adoc` used as card preview text (clamped to ~5 lines with CSS). If missing, the card shows title + date + “Read more →”.

**Repo Layout**
- `pages/<slug>/`
  - `page.adoc`: AsciiDoc content for the page
  - `default.nix`: page build using `lib/page.nix`
  - `excerpt.adoc` (optional): short preview text for feeds
  - scripts (optional): page‑specific generators
  - `wasm-src/` (optional): Rust crate compiled to WASM for the page
- `lib/page.nix`: helpers for generators, WASM, and `mkPage`
- `lib/feed.nix`: shared functions to render feed card lists and whole feed pages
- `site/default.nix`: assembles pages, static assets, and builds `index.html`, `projects.html`, `publications.html`, and optional `resume.pdf`
- `templates/docinfo.html`: injected into every page (base styles, header/nav, highlight.js, palette, small JS helpers)
- `static/`: shared runtime files copied verbatim (e.g., `reload.js`, wasm loader)
- `_site/`: local dev output (served by `nix run`)
- `result/`: production output symlink from `nix build`

**Add a Page**
1) Create `pages/my-page/` with:
- `page.adoc`
- `default.nix` that calls `mkPage` from `lib/page.nix`
- Optional `excerpt.adoc`, generator scripts, and/or `wasm-src/`

Example `pages/my-experiment/default.nix`:
```
{ pkgs, templates, pageLib, wasmCargoHash ? null }:

let
  slug = "my-experiment";
  title = "My Experiment";
  date = "2025-11-26";
  wasm = if wasmCargoHash == null then null else pageLib.wasmModule {
    src = ./wasm-src;
    cargoHash = wasmCargoHash;
  };
in pageLib.mkPage {
  inherit templates slug title date;
  adoc = ./page.adoc;
  generators = [
    { out = "data.json"; python = ./generate-data.py; }
    { out = "plot.svg";  python = ./generate-plot.py; }
  ];
  wasm = wasm;
  showInIndex = true;        # false to hide from feeds (used by About/Resume)
  category = "blog";         # or "project" / "publication"
}
```

**Generators** (from `lib/page.nix`)
- `pythonGen`: run a Python script that writes `--out <file>`
- `typstGen`: compile a typst file into a PDF
- `cmdGen`: run any shell command, stdout -> file
- `wasmModule`: build a Rust crate to `module.wasm`
- `mkPage`: minimal wrapper to tie it all together

**WASM (Per Page)**
- Put a Rust crate under `pages/<slug>/wasm-src/` with `[lib] crate-type = ["cdylib"]` and an exported function (e.g. `run()`)
- Pure builds require a cargo vendor hash:
  - In `flake.nix`, add an entry to `wasmHashes = { "my-experiment" = pkgs.lib.fakeSha256; }`
  - Run `nix build .#site` once, copy the printed `got: sha256-...` into `flake.nix`, rebuild
- Output lands at `wasm/module.wasm` next to the page and is loaded by `static/wasm/wasm-loader.js`

**Theming & Assets**
- Highlight.js and Catppuccin palette/theme are vendored via Nix in `site/default.nix` with pinned hashes in `flake.nix`
- Styles live in `templates/docinfo.html`

**Dev Server** (`nix run`)
- Builds `.#site`, copies to `_site/`, writes `_site/build.rev`
- Serves `_site/` on port 8080 with `miniserve`
- Watches `pages/`, `site/`, `templates/`, `static/`, `flake.nix|lock` with `entr` and rebuilds on change
- Browser hot‑reload via `static/reload.js` polling `build.rev`

**GitHub Pages**
- Workflow at `.github/workflows/pages.yml` builds `.#site` and deploys
- Relative URLs for assets -> safe for project sites and subpaths
- `.nojekyll` included in output