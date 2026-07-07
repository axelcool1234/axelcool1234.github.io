{
  lib,
}:
/* html */ ''
  <h1>Notes</h1>
  ${lib.entryListHtml {
    entriesDir = ../src/notes;
    basePath = "notes";
  }}
''
