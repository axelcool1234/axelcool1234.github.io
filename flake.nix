{
  description = "Website";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.lib // import ./lib.nix { lib = pkgs.lib; };
      postsDir = ./src/posts;
      notesDir = ./src/notes;
      renderCollection =
        entriesDir: basePath:
        lib.renderEntries {
          inherit pkgs navbar entriesDir basePath;
        };
      writeWrappedPage =
        path: title: body:
        pkgs.writeTextDir path (
          lib.wrapPage {
            inherit title body navbar;
          }
        );

      # Navigation bar
      navbar = lib.concatStringsSep "\n" [
        ''<a href="/index.html">Home</a>''
        ''<a href="/notes/">Notes</a>''
      ];

      # Index page
      indexHtml = /* html */ ''
        ${builtins.readFile ./src/index.html}

        <h2 style="margin-bottom: 0;">Posts</h2>
        ${lib.entryListHtml {
          entriesDir = postsDir;
          basePath = "posts";
        }}
      '';

      notesIndexHtml = /* html */ ''
        <h1>Notes</h1>
        ${lib.entryListHtml {
          entriesDir = notesDir;
          basePath = "notes";
        }}
      '';

      # Compiled PDF
      resumePdf = pkgs.runCommand "resume-pdf" { nativeBuildInputs = [ pkgs.typst ]; } ''
        set -euo pipefail
        mkdir -p "$out"
        cp ${./src/resume/resume.typ} ./resume.typ
        cp ${./src/resume/template.typ} ./template.typ
        typst compile ./resume.typ "$out/resume.pdf"
      '';

      # Site output (this is the static site generation in action)
      site = pkgs.symlinkJoin {
        name = "site";
        paths =
          (renderCollection postsDir "posts")
          ++ (renderCollection notesDir "notes")
          ++
          [
            resumePdf
            (pkgs.writeTextDir "style.css" (builtins.readFile ./src/style.css))
            (writeWrappedPage "index.html" "Axel Sorenson" indexHtml)
            (writeWrappedPage "notes/index.html" "Notes" notesIndexHtml)
            (pkgs.writeTextDir ".nojekyll" "")
          ];
      };
    in {
      packages.${system}.site = site;

      apps.${system} = {
        default = {
          type = "app";
          program =
            let
              moddConfig = pkgs.writeText "modd.conf" ''
                src/** flake.nix flake.lock {
                  prep: nix build .#site
                  prep: chmod -R u+w _site 2>/dev/null || true
                  prep: rm -rf _site
                  prep: mkdir -p _site
                  prep: cp -rL result/. _site/
                  prep: chmod -R u+w _site

                  daemon: "
                    if [ \"''${OPEN_BROWSER:-0}\" = 1 ]; then
                      exec devd -om _site
                    else
                      exec devd -m _site
                    fi
                  "
                }
              '';

              app = pkgs.writeShellApplication {
                name = "site-dev";
                runtimeInputs = [
                  pkgs.devd
                  pkgs.modd
                ];
                text = ''
                  set -euo pipefail
                  exec modd -c -f ${moddConfig}
                '';
              };
            in
            "${app}/bin/site-dev";
        };
      };
    };
}
