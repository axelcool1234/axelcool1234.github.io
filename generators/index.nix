{
  lib,
}:
/* html */ ''
  ${builtins.readFile ../src/index.html}

  <h2 style="margin-bottom: 0;">Posts</h2>
  ${lib.entryListHtml {
    entriesDir = ../src/posts;
    basePath = "posts";
  }}
''
