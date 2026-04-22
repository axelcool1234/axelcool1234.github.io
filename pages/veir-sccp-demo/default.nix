{ pkgs, templates, pageLib, wasmCargoHash ? null }:

let
  slug = "veir-sccp-demo";
  title = "Sparse Conditional Constant Propagation in Veir";
  date = "2026-04-21";

  page = pageLib.mkPage {
    inherit templates slug title date;
    adoc = ./page.adoc;
    category = "project";
  };

  demo = pkgs.buildNpmPackage {
    pname = "${slug}-app";
    version = "0.1.0";
    src = ./app;
    npmDepsHash = "sha256-VPFB8LMzA7zlsezxVzFeaxTRpZVk/JO9VCiVBoy5FHk=";
    npmBuildFlags = [ "--" "--base=./" ];

    installPhase = ''
      runHook preInstall
      mkdir -p "$out/${slug}"
      cp -r dist/* "$out/${slug}/"
      runHook postInstall
    '';
  };
in
{
  out = pkgs.symlinkJoin {
    name = "page-${slug}";
    paths = [ page.out demo ];
  };
  meta = page.meta;
}
