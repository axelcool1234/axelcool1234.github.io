{ pkgs }:
pkgs.runCommand "resume-pdf" { nativeBuildInputs = [ pkgs.typst ]; } ''
  set -euo pipefail
  mkdir -p "$out"
  cp ${../src/resume/resume.typ} ./resume.typ
  cp ${../src/resume/template.typ} ./template.typ
  typst compile ./resume.typ "$out/resume.pdf"
''
