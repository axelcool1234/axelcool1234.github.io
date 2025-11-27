{ pkgs }:

let
  lib = pkgs.lib;

  mkCardsAdoc =
    { metas }:
    let
      # Prefer newer first by date (YYYY-MM-DD); tie-breaker: slug
      compareDesc = a: b: if a.date == b.date then a.slug > b.slug else a.date > b.date;
      metasSorted = lib.sort compareDesc metas;

      getExcerpt =
        meta:
        let
          adocPath = meta.adocPath or null;
          dir = if adocPath == null then null else builtins.dirOf adocPath;
          excerptPath = if dir == null then null else dir + "/excerpt.adoc";
        in
        if excerptPath != null && builtins.pathExists excerptPath then
          builtins.readFile excerptPath
        else
          "";

      cardFor =
        meta:
        let
          titleLine = "link:" + meta.slug + ".html[" + meta.title + "]";
          dateLine = meta.date;
          readMore = "link:" + meta.slug + ".html[Read more →]";
          excerpt = getExcerpt meta;
        in
        lib.concatStringsSep "\n" [
          "[.card]"
          "--"
          "[.card-title]"
          titleLine
          ""
          "[.card-meta]"
          dateLine
          ""
          "[.excerpt]"
          excerpt
          ""
          readMore
          "--"
        ];
    in
    lib.concatStringsSep "\n\n" (map cardFor metasSorted);

  mkFeedPage =
    {
      templates,
      title,
      metas,
      headerAdoc ? "",
      outName ? null,
    }:
    let
      fileBase =
        if outName == null then
          (lib.toLower (lib.replaceStrings [ " " ] [ "-" ] title) + ".html")
        else
          outName;
      cards = mkCardsAdoc { inherit metas; };
      pageAdoc = pkgs.writeText "page.adoc" (
        (if title == "" then "" else "== " + title)
        + "\n\n"
        + headerAdoc
        + (if headerAdoc == "" then "" else "\n\n")
        + cards
        + "\n"
      );
    in
    pkgs.stdenv.mkDerivation {
      pname = "feed-" + (lib.toLower (lib.replaceStrings [ " " ] [ "-" ] title));
      version = "0.1";
      nativeBuildInputs = [ pkgs.asciidoctor ];
      buildCommand = ''
        set -euo pipefail
        mkdir -p $out
        asciidoctor \
          -a linkcss \
          -a stylesheet! \
          -a source-highlighter=highlightjs \
          -a nofooter \
          -a docinfo=shared -a docinfodir=${templates} \
          -o $out/${fileBase} ${pageAdoc}
      '';
    };
in
{
  inherit mkCardsAdoc mkFeedPage;
}
