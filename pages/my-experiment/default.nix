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
    { out = "automaton.svg"; latex = {file = ./automaton.tex; post = "svg"; }; }
    { out = "complex-plane.svg"; typst = ./complex-plane.typ; packages = 
      [
        {
          name = "cetz";
          version = "0.4.2";
          hash = "sha256-qBIEHqtiMSG/WoXHPC/rQ9VkestSvVNlUwTmAMX1wAs="; 
        }
        {
          name = "oxifmt";
          version = "1.0.0";
          hash = "sha256-edTDK5F2xFYWypGpR0dWxwM7IiBd8hKGQ0KArkbpHvI=";
        }
      ];
    }
  ];
  wasm = wasm;
}
