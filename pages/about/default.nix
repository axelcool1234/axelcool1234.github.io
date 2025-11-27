{ pkgs, templates, pageLib, wasmCargoHash ? null }:

let
  slug = "about";
  title = "About";
  date = "2025-11-27";
in pageLib.mkPage {
  inherit templates slug title date;
  adoc = ./page.adoc;
  generators = [ ];
  wasm = null;
  showInIndex = false;
}
