{ pkgs, templates, pageLib, wasmCargoHash ? null }:

let
  slug = "my-experiment";
  title = "My Experiment";
  date = "2025-11-26";
  wasm = if wasmCargoHash == null then null else pageLib.wasmModule { src = ./wasm-src; cargoHash = wasmCargoHash; };
in pageLib.mkPage {
  inherit templates slug title date;
  adoc = ./page.adoc;
  generators = [
    { out = "data.json"; python = ./generate-data.py; }
    { out = "plot.svg"; python = ./generate-plot.py; }
  ];
  wasm = wasm;
}
