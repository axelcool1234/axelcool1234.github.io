{ lib }:
rec {
  # capitalize :: string -> string
  # word: a single word like "about".
  # Returns the same word with its first character uppercased.
  capitalize = word:
    let
      head = builtins.substring 0 1 word;
      tail = builtins.substring 1 (builtins.stringLength word - 1) word;
    in
    lib.toUpper head + tail;

  # titleFromFile :: string -> string
  # file: an HTML filename like "formal-methods.html".
  # Returns a title like "Formal Methods" derived from the filename stem.
  titleFromFile = file:
    let
      stem = lib.removeSuffix ".html" file;
    in
    lib.concatMapStringsSep " " capitalize (lib.splitString "-" stem);

  # htmlFiles :: path -> [ string ]
  # dir: a directory path whose top level entries should be scanned.
  # Returns sorted ".html" filenames directly inside dir.
  htmlFiles = dir:
    let
      entries = builtins.readDir dir;
    in
    builtins.sort builtins.lessThan (
      builtins.filter (
        name: entries.${name} == "regular" && lib.hasSuffix ".html" name
      ) (builtins.attrNames entries)
    );

  # wrapPage :: { title :: string, body :: string, navbar ? string, stylesheet ? string } -> string
  # title: page title for the <title> tag.
  # body: inner HTML placed inside <main>.
  # navbar: already rendered HTML inserted inside <nav>.
  # stylesheet: stylesheet URL placed in the <link rel="stylesheet"> tag.
  # Returns one complete HTML document string.
  wrapPage =
    {
      title,
      body,
      navbar ? "",
      stylesheet ? "/style.css",
    }:
    /* html */ ''
      <!doctype html>
      <html lang="en">
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <title>${title}</title>
          <link rel="stylesheet" href="${stylesheet}">
        </head>
        <body>
          <header>
            <nav>
              ${navbar}
            </nav>
          </header>

          <main>
            ${body}
          </main>
        </body>
      </html>
    '';

  # renderPage :: { pkgs :: attrset, dir :: path, file :: string, prefix ? string, navbar ? string, stylesheet ? string } -> derivation
  # pkgs: nixpkgs package set, used for pkgs.writeTextDir.
  # dir: source directory path to read the fragment from.
  # file: HTML filename inside dir, like "about.html".
  # prefix: output path prefix in the built site, like "" or "posts/".
  # navbar: already rendered HTML inserted inside <nav>.
  # stylesheet: stylesheet URL passed through to wrapPage.
  # Returns a derivation that writes prefix + file into the built site.
  renderPage =
    {
      pkgs,
      dir,
      file,
      prefix ? "",
      navbar ? "",
      stylesheet ? "/style.css",
    }:
    pkgs.writeTextDir "${prefix}${file}" (
      wrapPage {
        title = titleFromFile file;
        body = builtins.readFile (dir + "/${file}");
        inherit navbar stylesheet;
      }
    );

  # renderPages :: { pkgs :: attrset, dir :: path, prefix ? string, navbar ? string, stylesheet ? string } -> [ derivation ]
  # pkgs: nixpkgs package set, used for pkgs.writeTextDir.
  # dir: source directory path whose top level .html files should be rendered.
  # prefix: output path prefix in the built site, like "" or "posts/".
  # navbar: already rendered HTML inserted inside <nav>.
  # stylesheet: stylesheet URL passed through to wrapPage.
  # Returns one derivation per top level .html file in dir.
  renderPages =
    {
      pkgs,
      dir,
      prefix ? "",
      navbar ? "",
      stylesheet ? "/style.css",
    }:
    map (
      file:
      renderPage {
        inherit pkgs dir file prefix navbar stylesheet;
      }
    ) (htmlFiles dir);
}
