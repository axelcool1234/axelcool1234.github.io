{ pkgs }:

let
  pythonGen =
    {
      script,
      outName,
      args ? [ ],
    }:
    let
      argsStr = pkgs.lib.concatStringsSep " " args;
      cmd = ''${pkgs.python3}/bin/python3 ${script} ${argsStr} --out "$out/${outName}"'';
    in
    cmdGen {
      inherit outName;
      runtimeInputs = [ pkgs.python3 ];
      inherit cmd;
      redirect = false;
    };

  typstGen =
    {
      file,
      outName,
      args ? [ ],
    }:
    let
      argsStr = pkgs.lib.concatStringsSep " " args;
      dir = builtins.dirOf file;
      base = builtins.baseNameOf file;
      cmd = ''cd ${dir}; ${pkgs.typst}/bin/typst compile ${base} ${argsStr} "$out/${outName}"'';
    in
    cmdGen {
      inherit outName;
      runtimeInputs = [ pkgs.typst ];
      inherit cmd;
      redirect = false;
    };

  # Build a generated file by executing an arbitrary shell command; stdout is written to the out file.
  # Example: cmdGen { outName = "info.txt"; cmd = "echo hello"; }
  cmdGen =
    {
      outName,
      runtimeInputs ? [ ],
      cmd,
      redirect ? true,
    }:
    pkgs.runCommand outName { buildInputs = runtimeInputs; } ''
      set -euo pipefail
      mkdir -p "$out"
      if ${pkgs.lib.optionalString redirect "true"}${pkgs.lib.optionalString (!redirect) "false"}; then
        ${cmd} > "$out/${outName}"
      else
        ${cmd}
      fi
    '';

  # Build a Rust crate to a single module.wasm using the wasm32-unknown-unknown target.
  wasmModule =
    { src, cargoHash }:
    pkgs.rustPlatform.buildRustPackage {
      pname = "page-wasm";
      version = "0.1.0";
      inherit src cargoHash;
      nativeBuildInputs = [ pkgs.llvmPackages.lld ];
      cargoBuildFlags = [
        "--target"
        "wasm32-unknown-unknown"
      ];
      doCheck = false;
      installPhase = ''
        set -euo pipefail
        mkdir -p "$out"
        wasm=$(ls -1 target/wasm32-unknown-unknown/release/*.wasm 2>/dev/null | head -n1 || true)
        if [ -n "$wasm" ] && [ -f "$wasm" ]; then
          cp "$wasm" "$out/module.wasm"
        else
          echo "No wasm artifact found" >&2
          exit 1
        fi
      '';
    };

  # Build a page by rendering AsciiDoc and copying generated assets and optional WASM.
  buildPage =
    {
      templates,
      slug,
      title,
      date,
      adoc,
      generated ? { },
      wasmDrv ? null,
      showInIndex ? true,
      category ? "blog",
    }:
    let
      copyGenerated = pkgs.lib.concatStringsSep "\n" (
        pkgs.lib.mapAttrsToList (
          name: drv: ''cp ${drv}/${name} "$out/generated/${name}" 2>/dev/null || true''
        ) generated
      );
    in
    pkgs.stdenv.mkDerivation {
      pname = "page-${slug}";
      version = "0.1";
      src = ./.;
      nativeBuildInputs = [ pkgs.asciidoctor ];
      buildPhase = ''
        set -euo pipefail
        mkdir -p build/html
        asciidoctor \
          -a linkcss \
          -a stylesheet! \
          -a source-highlighter=highlightjs \
          -a nofooter \
          -a docinfo=shared -a docinfodir=${templates} \
          -o build/html/${slug}.html ${adoc}
      '';
      installPhase = ''
        set -euo pipefail
        mkdir -p "$out"
        cp -r build/html/* "$out/"
        mkdir -p "$out/generated" "$out/wasm"
        ${copyGenerated}
        ${pkgs.lib.optionalString (wasmDrv != null) ''
          cp ${wasmDrv}/module.wasm "$out/wasm/module.wasm" 2>/dev/null || true
        ''}
      '';
      meta = {
        inherit
          title
          date
          slug
          showInIndex
          category
          ;
        adocPath = adoc;
      };
    };

  # Convenience wrapper: accept a list of generator specs instead of a map.
  # generators = [
  #   { out = "data.json"; python = ./generate-data.py; args = ["--flag"]; }
  #   { out = "info.txt"; cmd = "echo hello"; runtimeInputs = [ pkgs.coreutils ]; }
  #   { out = "plot.svg"; drv = someOtherDerivation; }
  # ]
  # wasm = (optional) pkgs.derivation that contains module.wasm at its root
  mkPage =
    {
      templates,
      slug,
      title,
      date,
      adoc,
      generators ? [ ],
      wasm ? null,
      showInIndex ? true,
      category ? "blog",
    }:
    let
      toDrv =
        g:
        if g ? drv then
          g.drv
        else if g ? python then
          pythonGen {
            script = g.python;
            outName = g.out;
            args = (g.args or [ ]);
          }
        else if g ? typst then
          typstGen {
            file = g.typst;
            outName = g.out;
            args = (g.args or [ ]);
          }
        else if g ? cmd then
          cmdGen {
            outName = g.out;
            runtimeInputs = (g.runtimeInputs or [ ]);
            cmd = g.cmd;
          }
        else
          (throw "mkPage: generator must have one of: drv, python, typst, cmd");

      genMapList = map (g: {
        name = g.out;
        value = toDrv g;
      }) generators;
      genAttr = pkgs.lib.listToAttrs genMapList;
    in
    buildPage {
      inherit
        templates
        slug
        title
        date
        adoc
        category
        ;
      generated = genAttr;
      wasmDrv = wasm;
      showInIndex = showInIndex;
    };
in
{
  inherit
    pythonGen
    cmdGen
    typstGen
    wasmModule
    buildPage
    mkPage
    ;
}
