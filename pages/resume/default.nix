{
  pkgs,
  templates,
  pageLib,
  wasmCargoHash ? null,
}:

let
  slug = "resume";
  title = "Resume";
  date = "2025-11-27";
in
pageLib.mkPage {
  inherit
    templates
    slug
    title
    date
    ;
  adoc = ./page.adoc;
  generators = [
    {
      out = "resume.pdf";
      typst = ./resume.typ;
    }
  ];
  wasm = null;
  showInIndex = false;
}
