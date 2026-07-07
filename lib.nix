{ lib }:
let
  # dirNames :: path -> [ string ]
  # dir: a directory path whose top level entries should be scanned.
  # Returns sorted directory names directly inside dir.
  dirNames = dir:
    let
      entries = builtins.readDir dir;
    in
    lib.pipe entries [
      builtins.attrNames
      (builtins.filter (name: entries.${name} == "directory"))
      (builtins.sort builtins.lessThan)
    ];
in
rec {
  # titleFromName :: string -> string
  # name: a dash separated name like "lambda-cube".
  # Returns a title cased string like "Lambda Cube".
  titleFromName = name:
    lib.concatMapStringsSep " " (
      word:
      let
        head = builtins.substring 0 1 word;
        tail = builtins.substring 1 (builtins.stringLength word - 1) word;
      in
      lib.toUpper head + tail
    ) (lib.splitString "-" name);

  # entryListHtml :: { entriesDir :: path, basePath :: string } -> string
  # entriesDir: root directory containing entry subdirectories.
  # basePath: output collection path, like "posts" or "notes".
  # Returns an HTML list linking to each top level entry.
  entryListHtml =
    {
      entriesDir,
      basePath,
    }:
    let
      # loadPageMeta :: { dir :: path, name :: string } -> attrset
      # dir: a page directory containing index.html and optionally default.nix.
      # name: the default title stem, usually the page directory name.
      # Returns page metadata with title and optional date.
      loadPageMeta =
        {
          dir,
          name,
        }:
        let
          # raw :: attrset
          # Contents of default.nix when present, or {} when the page has no metadata file.
          raw = if builtins.pathExists (dir + "/default.nix") then import (dir + "/default.nix") else { };
        in
        {
          title = raw.title or (titleFromName name);
          date = raw.date or null;
        };
    in
    /* html */ ''
      <ul>
        ${lib.pipe (dirNames entriesDir) [
          (map (
            entry:
            let
              meta = loadPageMeta {
                dir = entriesDir + "/${entry}";
                name = entry;
              };
              dateSuffix = if meta.date == null then "" else " (${meta.date})";
            in
            ''<li><a href="/${basePath}/${entry}/">${meta.title}</a>${dateSuffix}</li>''
          ))
          (lib.concatStringsSep "\n")
        ]}
      </ul>
    '';

  # wrapPage :: { title :: string, body :: string, navbar ? string, stylesheet ? string, head ? string, bodyTail ? string } -> string
  # title: page title for the <title> tag.
  # body: inner HTML placed inside <main>.
  # navbar: already rendered HTML inserted inside <nav>.
  # stylesheet: site wide stylesheet URL placed in the global <link rel="stylesheet"> tag.
  # head: extra HTML inserted into <head>.
  # bodyTail: extra HTML inserted just before </body>.
  # Returns one complete HTML document string.
  wrapPage =
    {
      title,
      body,
      navbar ? "",
      stylesheet ? "/style.css",
      head ? "",
      bodyTail ? "",
    }:
    /* html */ ''
      <!doctype html>
      <html lang="en">
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <title>${title}</title>
          <link rel="stylesheet" href="${stylesheet}">
          <link id="theme-stylesheet" rel="stylesheet" href="/themes/noctalia.css">
          ${head}
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
          ${bodyTail}
        </body>
      </html>
    '';

  # renderEntries :: { pkgs :: attrset, entriesDir :: path, basePath :: string, navbar ? string, stylesheet ? string, bodyTail ? string } -> [ derivation ]
  # pkgs: nixpkgs package set, used for pkgs.writeTextDir.
  # entriesDir: root directory containing entry subdirectories.
  # basePath: output collection path, like "posts" or "notes".
  # navbar: already rendered HTML inserted inside <nav>.
  # stylesheet: site wide stylesheet URL passed through to wrapPage.
  # bodyTail: shared HTML appended to every wrapped page body.
  # Returns wrapped and copied outputs for every top level entry in entriesDir.
  renderEntries =
    {
      pkgs,
      entriesDir,
      basePath,
      navbar ? "",
      stylesheet ? "/style.css",
      bodyTail ? "",
    }:
    let
      # loadPageMeta :: { dir :: path, name :: string } -> attrset
      # dir: a page directory containing index.html and optionally default.nix.
      # name: the default title stem, usually the page directory name.
      # Returns page metadata with title, optional date, relative style URL lists,
      # and script specs of the form { src :: string, module :: bool }.
      loadPageMeta =
        {
          dir,
          name,
        }:
        let
          # raw :: attrset
          # Contents of default.nix when present, or {} when the page has no metadata file.
          raw = if builtins.pathExists (dir + "/default.nix") then import (dir + "/default.nix") else { };
        in
        {
          title = raw.title or (titleFromName name);
          date = raw.date or null;
          styles = raw.styles or [ ];
          scripts = map (script: script // { module = script.module or false; }) (raw.scripts or [ ]);
        };

      # nestedPageDirs :: path -> [ string ]
      # dir: a directory path whose descendants should be scanned for wrapped pages.
      # Returns sorted relative directory paths under dir that contain index.html.
      nestedPageDirs = dir:
        let
          # descend :: string -> [ string ]
          # name: one direct child directory name inside dir.
          # Returns relative page directory paths contributed by that child and its descendants.
          descend =
            name:
            let
              path = dir + "/${name}";
              self = if builtins.pathExists (path + "/index.html") then [ name ] else [ ];
              children = map (child: "${name}/${child}") (nestedPageDirs path);
            in
            self ++ children;
        in
        lib.pipe (dirNames dir) [
          (map descend)
          lib.flatten
          (builtins.sort builtins.lessThan)
        ];
      # relativeFiles :: path -> [ string ]
      # dir: a directory path whose contents should be scanned recursively.
      # Returns sorted relative file paths for every regular file under dir.
      relativeFiles = dir:
        let
          entries = builtins.readDir dir;
          # descend :: string -> [ string ]
          # name: one direct child entry name inside dir.
          # Returns relative file paths contributed by that child, recursing into directories.
          descend =
            name:
            let
              kind = entries.${name};
              path = dir + "/${name}";
            in
            if kind == "regular" then
              [ name ]
            else if kind == "directory" then
              map (child: "${name}/${child}") (relativeFiles path)
            else
              [ ];
        in
        lib.pipe entries [
          builtins.attrNames
          (map descend)
          lib.flatten
          (builtins.sort builtins.lessThan)
        ];
      # outputPath :: string -> string
      # path: a source relative asset or script path, possibly ending in .ts.
      # Returns the built output path, with .ts rewritten to .js.
      outputPath = path:
        if lib.hasSuffix ".ts" path then
          lib.removeSuffix ".ts" path + ".js"
        else
          path;
      # duplicateItems :: [ string ] -> [ string ]
      # items: a list of output paths.
      # Returns the unique paths that appear more than once in items.
      duplicateItems = items:
        lib.unique (
          builtins.filter (
            item:
            builtins.length (builtins.filter (candidate: candidate == item) items) > 1
          ) items
        );
      # pageSupportFiles :: [ string ] -> [ string ]
      # pages: page directory paths relative to one entry, with "" for the entry root page.
      # Returns the index.html and default.nix paths reserved for wrapped pages.
      pageSupportFiles = pages:
        lib.pipe pages [
          (map (
            page:
            let
              prefix = if page == "" then "" else "${page}/";
            in
            [
              "${prefix}index.html"
              "${prefix}default.nix"
            ]
          ))
          lib.flatten
        ];
      # buildAsset :: { entry :: string, dir :: path, file :: string } -> derivation
      # entry: top level entry name under basePath.
      # dir: source directory path for the entry.
      # file: relative non-TypeScript asset path under dir.
      # Returns one derivation that copies file into the built site.
      buildAsset =
        {
          entry,
          dir,
          file,
        }:
        let
          outputFile = outputPath file;
          sourceFile = dir + "/${file}";
        in
        pkgs.writeTextDir "${basePath}/${entry}/${outputFile}" (builtins.readFile sourceFile);
      # buildTsAssets :: { entry :: string, dir :: path, files :: [ string ], supportFiles :: [ string ] } -> derivation
      # entry: top level entry name under basePath.
      # dir: source directory path for the entry.
      # files: relative TypeScript file paths under dir to compile together.
      # supportFiles: all relative support file paths under dir, copied into the temporary compile tree.
      # Returns one derivation that compiles the entry's TypeScript module graph into matching .js files.
      buildTsAssets =
        {
          entry,
          dir,
          files,
          supportFiles,
        }:
        pkgs.runCommand "site-ts-assets-${builtins.replaceStrings [ "/" "." ] [ "-" "-" ] entry}" {
          nativeBuildInputs = [ pkgs.nodePackages.typescript ];
        } ''
          set -euo pipefail
          mkdir source out "$out"
          cd source
          for file in ${lib.escapeShellArgs supportFiles}; do
            mkdir -p "$(dirname "$file")"
            cp ${dir}/"$file" "$file"
          done
          tsc \
            --target es2020 \
            --module es2020 \
            --moduleResolution bundler \
            --rootDir . \
            --outDir ../out \
            ${lib.escapeShellArgs files}
          mkdir -p "$out/${basePath}/${entry}"
          cp -r ../out/. "$out/${basePath}/${entry}/"
        '';
      # renderWrappedPage :: { entry :: string, dir :: path, page :: string } -> derivation
      # entry: top level entry name under basePath.
      # dir: source directory path for the entry.
      # page: page directory path relative to dir, with "" for the entry root page.
      # Returns one wrapped index.html derivation for the requested page.
      renderWrappedPage =
        {
          entry,
          dir,
          page,
        }:
        let
          pageDir = if page == "" then dir else dir + "/${page}";
          pageName = if page == "" then entry else lib.last (lib.splitString "/" page);
          meta = loadPageMeta {
            dir = pageDir;
            name = pageName;
          };
          outputPrefix =
            if page == "" then
              "${basePath}/${entry}/"
            else
              "${basePath}/${entry}/${page}/";
          head = lib.concatMapStringsSep "\n" (style: ''<link rel="stylesheet" href="${style}">'') meta.styles;
          pageBodyTail = lib.concatMapStringsSep "\n" (
            script:
            if script.module then
              ''<script type="module" src="${outputPath script.src}"></script>''
            else
              ''<script src="${outputPath script.src}"></script>''
          ) meta.scripts;
        in
        pkgs.writeTextDir "${outputPrefix}index.html" (
          wrapPage {
            title = meta.title;
            body = builtins.readFile (pageDir + "/index.html");
            inherit navbar stylesheet head;
            bodyTail = lib.concatStringsSep "\n" [ pageBodyTail bodyTail ];
          }
        );
    in
    lib.pipe (dirNames entriesDir) [
      (map (
        entry:
        let
          dir = entriesDir + "/${entry}";
          pages = [ "" ] ++ nestedPageDirs dir;
          copiedFiles = builtins.filter (
            file: !(builtins.elem file (pageSupportFiles pages))
          ) (relativeFiles dir);
          tsFiles = builtins.filter (file: lib.hasSuffix ".ts" file) copiedFiles;
          nonTsFiles = builtins.filter (file: !(lib.hasSuffix ".ts" file)) copiedFiles;
          duplicateOutputFiles = duplicateItems (map outputPath copiedFiles);
        in
        if duplicateOutputFiles != [ ] then
          throw "duplicate built asset paths in ${toString dir}: ${lib.concatStringsSep ", " duplicateOutputFiles}"
        else
          (map (page: renderWrappedPage { inherit entry dir page; }) pages)
          ++ lib.optional (tsFiles != [ ]) (
            buildTsAssets {
              inherit entry dir;
              files = tsFiles;
              supportFiles = copiedFiles;
            }
          )
          ++ map (file: buildAsset { inherit entry dir file; }) nonTsFiles
      ))
      lib.flatten
    ];
}
