{
  pkgs,
  typix,
  wasmHashes ? { },
  templates ? ../templates,
  assetHashes ? { },
}:

let
  pagesDir = ../pages;
  pageLib = import ../lib/page.nix { inherit pkgs; inherit typix; };
  feedLib = import ../lib/feed.nix { inherit pkgs; };
  pageNames = pkgs.lib.attrNames (
    pkgs.lib.filterAttrs (_: v: v == "directory") (builtins.readDir pagesDir)
  );
  # Normalize provided cargo hashes: accept SRI ("sha256-…"), or lib.fakeSha256 (64 zeros) and convert to SRI zeros.
  typedZero = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  normalizeHash =
    h:
    if h == null then
      null
    else if (builtins.isString h) && pkgs.lib.hasPrefix "sha256-" h then
      h
    else if h == pkgs.lib.fakeSha256 then
      typedZero
    else
      h;

  pageModules = map (
    name:
    (import "${pagesDir}/${name}/default.nix" {
      inherit pkgs templates pageLib;
      wasmCargoHash = normalizeHash (wasmHashes.${name} or null);
    })
  ) pageNames;

  pageOuts = map (m: m.out) pageModules;
  pageMetas = map (m: m.meta) pageModules;

  # Build Home using feedLib.mkFeedPage
  indexHtml =
    let
      headerAdoc = ''
        [.mini-about]
        --
        image::https://avatars.githubusercontent.com/axelcool1234?s=256[alt=Profile photo]

        [.mini-list]
        * *Axel Sorenson*
        * he/him/his · PhD @ U of U · Salt Lake City, UT
        * link:mailto:AxelPSorenson@gmail.com[Email] · link:https://github.com/axelcool1234[GitHub] · link:https://www.linkedin.com/in/axel-sorenson/[LinkedIn]
        --
      '';
    in
    feedLib.mkFeedPage {
      templates = ../templates;
      title = "Home";
      metas = pkgs.lib.filter (
        m: (m.showInIndex or true) && ((m.category or "blog") == "blog")
      ) pageMetas;
      headerAdoc = headerAdoc;
      outName = "index.html";
    };

  projectsHtml =
    let
      metas = pkgs.lib.filter (
        m: (m.showInIndex or true) && ((m.category or "blog") == "project")
      ) pageMetas;
    in
    feedLib.mkFeedPage {
      templates = ../templates;
      title = "Projects";
      metas = metas;
      headerAdoc = "";
      outName = "projects.html";
    };

  publicationsHtml =
    let
      metas = pkgs.lib.filter (
        m: (m.showInIndex or true) && ((m.category or "blog") == "publication")
      ) pageMetas;
    in
    feedLib.mkFeedPage {
      templates = ../templates;
      title = "Publications";
      metas = metas;
      headerAdoc = "";
      outName = "publications.html";
    };

  # Copy global static assets to root of the site
  staticOut = pkgs.runCommand "site-static" { } ''
    mkdir -p $out
    cp -r ${../static}/* $out/ 2>/dev/null || true
  '';

  # Optional: vendor highlight.js and Catppuccin highlight theme via Nix fetch
  highlightJs =
    let
      h = normalizeHash (assetHashes.highlightJs or null);
    in
    if h == null then
      null
    else
      pkgs.fetchurl {
        # Highlight.js browser build from npm cdn-assets (includes popular languages)
        url = "https://cdn.jsdelivr.net/npm/@highlightjs/cdn-assets@11.9.0/highlight.min.js";
        hash = h;
      };

  # Fetch precompiled Catppuccin highlight.js theme CSS from the npm package via jsDelivr
  # Defaults to css/catppuccin-mocha.css; you can override path/version via assetHashes.
  hljsThemeCss =
    let
      h = normalizeHash (assetHashes.hljsThemeCss or (assetHashes.hljsTheme or null));
      version = assetHashes.hljsNpmVersion or ""; # e.g. "0.3.0"; empty means latest
      path = assetHashes.hljsThemePath or "css/catppuccin-macchiato.css";
      verSeg = if version == "" then "" else "@" + version;
      url = "https://cdn.jsdelivr.net/npm/@catppuccin/highlightjs" + verSeg + "/" + path;
    in
    if h == null then
      null
    else
      pkgs.fetchurl {
        inherit url;
        hash = h;
      };

  # Vendor Catppuccin palette CSS from npm (provides --ctp-<flavor>-* variables)
  paletteCss =
    let
      h = normalizeHash (assetHashes.paletteCss or null);
      version = assetHashes.paletteNpmVersion or ""; # e.g. "1.2.0"; empty means latest
      # Use the master palette css (contains variables for all flavors)
      path = assetHashes.paletteCssPath or "css/catppuccin.css";
      verSeg = if version == "" then "" else "@" + version;
      url = "https://cdn.jsdelivr.net/npm/@catppuccin/palette" + verSeg + "/" + path;
    in
    if h == null then
      null
    else
      pkgs.fetchurl {
        inherit url;
        hash = h;
      };

  vendorOut = pkgs.runCommand "vendor-assets" { } ''
    mkdir -p $out
    ${pkgs.lib.optionalString (highlightJs != null) ''
      cp ${highlightJs} $out/highlight.min.js
    ''}
    ${pkgs.lib.optionalString (hljsThemeCss != null) ''
      mkdir -p $out/themes
      cp ${hljsThemeCss} $out/themes/catppuccin-hljs.css
    ''}
    ${pkgs.lib.optionalString (paletteCss != null) ''
      mkdir -p $out/themes
      cp ${paletteCss} $out/themes/catppuccin-palette.css
    ''}
  '';

  # Ensure GitHub Pages does not run Jekyll over the site
  nojekyll = pkgs.runCommand "nojekyll" { } ''
    mkdir -p $out
    touch $out/.nojekyll
  '';

in
pkgs.symlinkJoin {
  name = "adoc-blog-site";
  # Order: staticOut first (fallback), then vendorOut to override if present
  paths =
    pageOuts
    ++ [
      indexHtml
      projectsHtml
      publicationsHtml
      staticOut
      vendorOut
      nojekyll
    ];
}
