# Keep HTML accessibility repairs separate from the expensive video render.
{ pkgs, figures }:
pkgs.runCommand "coexec-accessible-deck" { nativeBuildInputs = [ pkgs.python3 ]; } ''
  mkdir -p "$out"
  cp -rs ${figures}/. "$out/"
  find "$out" -type d -exec chmod u+w {} +
  deck=presentations/coexec-scheduler/deck.html
  rm "$out/$deck"
  python3 ${./accessible-deck.py} "${figures}/$deck" "$out/$deck"
''
