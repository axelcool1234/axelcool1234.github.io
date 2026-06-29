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

      # Navigation bar
      navbar = lib.concatStringsSep "\n" (
        [ ''<a href="/index.html">Home</a>'' ]
        ++ map (
          file:
          ''<a href="/${file}">${lib.titleFromFile file}</a>''
        ) (lib.htmlFiles ./src/nav)
      );

      # Index page
      indexHtml = /* html */ ''
        ${builtins.readFile ./src/index.html}

        <h2 style="margin-bottom: 0;">Posts</h2>
        <ul>
          ${lib.concatMapStringsSep "\n" (
            file:
            ''<li><a href="/posts/${file}">${lib.titleFromFile file}</a></li>''
          ) (lib.htmlFiles ./src/posts)}
        </ul>
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
          (lib.renderPages {
            inherit pkgs navbar;
            dir = ./src/nav;
          })
          ++
          (lib.renderPages {
            inherit pkgs navbar;
            dir = ./src/posts;
            prefix = "posts/";
          })
          ++
          [
            resumePdf
            (pkgs.writeTextDir "style.css" (builtins.readFile ./src/style.css))
            (pkgs.writeTextDir "index.html" (
              lib.wrapPage {
                title = "Axel Sorenson";
                body = indexHtml;
                inherit navbar;
              }
            ))
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
