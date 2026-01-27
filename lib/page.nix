{ pkgs, typix }:

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
      packages ? [ ],
    }:
    let
      build-script = typix.lib.${pkgs.system}.buildTypstProjectLocal {
        unstable_typstPackages = packages;
        name = "typst-${builtins.baseNameOf file}";
        src = builtins.path { path = builtins.dirOf file; }; 
        typstSource = builtins.baseNameOf file;
        typstOpts = { format = if pkgs.lib.hasSuffix ".svg" outName then "svg" else "pdf"; };
      };
    in
    cmdGen {
      inherit outName;
      runtimeInputs = [ pkgs.typst ];
      redirect = false;

      cmd = ''
        ${build-script}/bin/typst-build "$out/${outName}"
      '';
    };

  latexGen =
    {
      file,           # ./diagram.tex
      outName,        # diagram.svg | diagram.pdf
      engine ? "pdflatex",
      post ? null,    # "pdf2svg" | "none"
      args ? [ ],
    }:  
   let
      base = builtins.baseNameOf file;
      stem = pkgs.lib.removeSuffix ".tex" base;
      argsStr = pkgs.lib.concatStringsSep " " args;

      latex = {
        pdflatex = "${pkgs.texliveFull}/bin/pdflatex";
        lualatex = "${pkgs.texliveFull}/bin/lualatex";
        xelatex = "${pkgs.texliveFull}/bin/xelatex";
      }.${engine};
    in
    cmdGen {
      inherit outName;
      runtimeInputs = [
        pkgs.texliveFull
        pkgs.pdf2svg
      ];
      cmd = ''
        set -euo pipefail

        work="$TMPDIR/latex"
        mkdir -p "$work"
        cp ${file} "$work/${base}"
        cd "$work"

        ${latex} -interaction=nonstopmode -halt-on-error ${argsStr} ${base}

        if [ "${post}" = "svg" ]; then
          ${pkgs.pdf2svg}/bin/pdf2svg ${stem}.pdf "$out/${outName}"
        else
          cp ${stem}.pdf "$out/${outName}"
        fi
      '';
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
            packages = (g.packages or [ ]);
          }
        else if g ? cmd then
          cmdGen {
            outName = g.out;
            runtimeInputs = (g.runtimeInputs or [ ]);
            cmd = g.cmd;
          }
        else if g ? latex then
          latexGen ({
            file = g.latex;
            outName = g.out;
            engine = (g.engine or "pdflatex");
            post = (g.post or null);
            args = (g.args or [ ]);
          } // g.latex)
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
    latexGen
    wasmModule
    buildPage
    mkPage
    ;
}
