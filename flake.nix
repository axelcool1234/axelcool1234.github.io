{
  description = "AsciiDoc blog + WASM + generators";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.rustup
            pkgs.cargo
            pkgs.asciidoctor
            pkgs.python3
            pkgs.git
            pkgs.pkg-config
            pkgs.openssl
            pkgs.entr
          ];
        };

        packages.site = pkgs.callPackage ./site {
          assetHashes = {
            # highlight.js browser build (cdn-assets)
            highlightJs     = "sha256-g3pvpbDHNrUrveKythkPMF2j/J7UFoHbUyFQcFe1yEY=";
            # Catppuccin hljs theme (macchiato)
            hljsTheme       = "sha256-LimpL6wfpoc3zFTWTn6nv6fTlE7FQ63aAGPr+1hQ2Us=";
            hljsNpmVersion  = "1.0.1"; # optional pin (leave blank for latest)
            hljsThemePath   = "css/catppuccin-macchiato.css";
            # Catppuccin palette (CSS vars for all flavors)
            paletteCss      = "sha256-wdDGTQ/XkfI5efbqfdBpTXgr6oX1AkjQTkVk9511IrE=";
            paletteNpmVersion = "1.2.0"; # optional pin (leave blank for latest)
            paletteCssPath    = "css/catppuccin.css";
          };
          wasmHashes = { "my-experiment" = "sha256-09TVjf9289QRexeyR7Fle/fNKp4cioi6Rpj1mCbbi1Q="; };
        };

        apps.dev = {
          type = "app";
          program = let
            app = pkgs.writeShellApplication {
              name = "site-dev";
              runtimeInputs = [
                pkgs.nix pkgs.asciidoctor pkgs.python3 pkgs.cargo pkgs.rustc pkgs.entr pkgs.miniserve pkgs.coreutils pkgs.findutils pkgs.bash pkgs.rsync
              ];
              checkPhase = ":";
              text = ''
                set -euo pipefail
                outdir=''${OUTDIR:-"$(pwd)/_site"}

                rebuild=$(mktemp -t site-rebuild.XXXXXX.sh)
                cat > "$rebuild" <<'BASH'
#!/usr/bin/env bash
set -euo pipefail
outdir="''${OUTDIR:-$(pwd)/_site}"
nix build .#site
mkdir -p "$outdir"
rsync -a --delete --chmod=Du+rwx,Fu+rw "result/" "$outdir/"
date +%s > "$outdir"/build.rev
BASH
                chmod +x "$rebuild"

                OUTDIR="$outdir" bash "$rebuild"
                # Ensure build.rev exists before starting server to avoid initial 404 log
                [ -f "$outdir/build.rev" ] || date +%s > "$outdir/build.rev"

                echo "[dev] serving on http://localhost:8080"
                miniserve --index index.html --port 8080 "$outdir" &
                srv=$!

                # watch pages, site, templates, static, and flake files
                (find pages site templates static -type f -print; ls -1 flake.nix flake.lock 2>/dev/null) | \
                  entr -s "echo '[dev] change detected -> rebuild'; OUTDIR='$outdir' bash '$rebuild'"

                kill "$srv" 2>/dev/null || true
              '';
            };
          in "${app}/bin/site-dev";
        };

        apps.clean = {
          type = "app";
          program = let
            app = pkgs.writeShellApplication {
              name = "site-clean";
              runtimeInputs = [ pkgs.coreutils ];
              text = ''
                set -euo pipefail
                [ -d "_site" ] && rm -rf "_site" || true
                [ -L "result" ] && rm -f "result" || true
                echo "Cleaned _site and result"
              '';
            };
          in "${app}/bin/site-clean";
        };

        apps.default = self.apps.${system}.dev;
      });
}
