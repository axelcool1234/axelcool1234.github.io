{
  description = "Website";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.lib // import ./lib.nix { lib = pkgs.lib; };
 
      # Themes
      themeNames =
        let
          themes = builtins.readDir ./src/themes;
        in
        lib.pipe themes [
          builtins.attrNames
          (builtins.filter (name: themes.${name} == "regular"))
          (builtins.sort builtins.lessThan)
        ];
 
      # Placed after the body of all pages
      bodyTail = ''<script src="/navbar.js"></script>'';
 
      # Navigation bar
      navbar = import ./generators/navbar.nix {
        inherit lib themeNames;
      };

      # Site output (this is the static site generation in action)
      site =
        let
          renderCollection =
            entriesDir: basePath:
            lib.renderEntries {
              inherit pkgs navbar entriesDir basePath bodyTail;
            };

          writeWrappedPage =
            path: title: body:
            pkgs.writeTextDir path (
              lib.wrapPage {
                inherit title body navbar bodyTail;
              }
            );

          writeSourceFile = path: source: pkgs.writeTextDir path (builtins.readFile source);
        in
        pkgs.symlinkJoin {
          name = "site";
          paths =
            # Posts
            (renderCollection ./src/posts "posts")
            # Notes
            ++ (renderCollection ./src/notes "notes")
            # Presentations
            ++ (renderCollection ./src/presentations "presentations")
            ++
            [
              # Resume
              (import ./generators/resume-pdf.nix { inherit pkgs; })
              # Global stylesheet
              (writeSourceFile "style.css" ./src/style.css)
              # Navbar behavior
              (writeSourceFile "navbar.js" ./generators/navbar.js)
              # Index file (home)
              (writeWrappedPage "index.html" "Axel Sorenson" (import ./generators/index.nix { inherit lib; }))
              # Notes list
              (writeWrappedPage "notes/index.html" "Notes" (import ./generators/notes.nix { inherit lib; }))
              # Presentations list
              (writeWrappedPage "presentations/index.html" "Presentations" (
                import ./generators/presentations.nix { inherit lib; }
              ))
              # Figures for the CoExec deck, rendered from source at build time
              (import ./generators/coexec-figures.nix { inherit pkgs; })
              (pkgs.writeTextDir ".nojekyll" "")
              # All 66 themes in ONE derivation. They used to be one writeTextDir
              # each, and writeTextDir sets allowSubstitutes = false: Nix rebuilds
              # such paths every time rather than fetching them, so CI rebuilt all
              # 66 on every run and the cache dutifully re-uploaded them -- to a
              # cache that, by that same flag, would never be read from. Copying
              # the directory once is substitutable and is a single store path.
              (pkgs.runCommand "themes" { } ''
                mkdir -p "$out/themes"
                cp ${./src/themes}/*.css "$out/themes/"
              '')
            ];
        };
    in {
      packages.${system} = {
        inherit site;
        # Buildable on its own so the ~7 min figure render can be iterated on
        # without rebuilding the whole site.
        figures = import ./generators/coexec-figures.nix { inherit pkgs; };
      };

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
