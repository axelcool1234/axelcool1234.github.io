# Handwritten HTML + Pretext demo

This demo keeps the page itself plain HTML/CSS and uses Pretext only for one text-heavy interactive note.

## Run it

```bash
nix develop
npm install
npm run dev
```

Then open the local URL printed by Vite.

## Files

- `index.html`: handwritten page markup
- `style.css`: handwritten styling
- `main.js`: the only JavaScript module on the page
- `flake.nix`: dev shell with Node

## What to look at

The key part is in `main.js`:

- `prepare(text, font)` is called once
- `layout(prepared, width, lineHeight)` is called whenever width changes
- the returned height and line count drive the animated note box

This is a good pattern for a personal blog:

- normal prose stays normal HTML
- special widgets get special logic
- your generator only needs to emit placeholders and scripts
