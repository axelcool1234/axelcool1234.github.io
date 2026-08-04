{
  lib,
}:
/* html */ ''
  <h1>Presentations</h1>
  ${lib.entryListHtml {
    entriesDir = ../src/presentations;
    basePath = "presentations";
  }}
''
