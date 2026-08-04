# Renders every figure in the CoExec deck from source, at site build time.
#
# The alternative was committing ~20 MB of MP4/GIF/PNG into a repo whose entire
# history is 1.4 MB. Instead src/figures/coexec/ holds the manim scenes, the
# matplotlib scripts, and ~76 KB of JSON distilled from the scheduler debug logs
# (which are 237 MB and could never live here), and this derivation turns them
# into video.
#
# It also sidesteps a limitation of the page generator: lib.renderEntries copies
# entry assets with `writeTextDir (readFile ...)`, and readFile refuses binary
# files outright. Media produced by a derivation lands in $out directly and never
# goes near readFile, which is why the figures are built rather than checked in.
{ pkgs }:
let
  # matplotlib and manim ship their own interpreters; call each explicitly rather
  # than relying on whichever python wins on PATH.
  py = pkgs.python3.withPackages (p: [ p.matplotlib p.numpy p.pillow ]);

  # scene file : manim class : output basename
  scenes = [
    { file = "anim_readyqueue.py"; scene = "ReadyQueue"; name = "readyqueue"; }
    { file = "anim_tooearly.py"; scene = "TooEarly"; name = "tooearly"; }
    { file = "anim_dagedits.py"; scene = "DagEdits"; name = "dagedits"; }
    { file = "anim_dagedges.py"; scene = "DagEdges"; name = "dagedges"; }
  ];

  # Each script writes <name>-still.png next to the video, which becomes the
  # <video poster>. They disagree on how the output path is passed: the two that
  # can also draw a static chart take it after --animate, the rest after -o.
  plots = [
    { script = "plot-budget.py"; args = "--data budget-f16.json"; out = "-o"; name = "budget-f16"; }
    { script = "plot-budget.py"; args = "--data budget-canonical.json"; out = "-o"; name = "budget-canonical"; }
    { script = "plot-lifelines.py"; args = "--data lifelines-f16.json"; out = "--animate"; name = "lifelines-f16"; }
    { script = "plot-lifelines.py"; args = "--data lifelines-canonical.json"; out = "--animate"; name = "lifelines-canonical"; }
    { script = "plot-drains.py"; args = "--data drains.json"; out = "--animate"; name = "drains"; }
    { script = "plot-results.py"; args = ""; out = "-o"; name = "results"; }
  ];

  renderScenes = pkgs.lib.concatMapStringsSep "\n" (s: ''
    manim -qm --media_dir ./media ${s.file} ${s.scene}
    cp ./media/videos/${pkgs.lib.removeSuffix ".py" s.file}/720p30/${s.scene}.mp4 \
       "$media/${s.name}.mp4"
    # manim scenes have no still of their own. Frame 0 is pure black -- every
    # scene opens by fading its title in -- so seek a third of the way in, where
    # the layout is assembled, and use that as the poster.
    dur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$media/${s.name}.mp4")
    ffmpeg -loglevel error -y -ss "$(awk "BEGIN{printf \"%.3f\", $dur*0.35}")" \
      -i "$media/${s.name}.mp4" -frames:v 1 "$media/${s.name}-still.png"
  '') scenes;

  renderPlots = pkgs.lib.concatMapStringsSep "\n" (p: ''
    ${py}/bin/python3 ${p.script} ${p.args} --dark ${p.out} "$media/${p.name}.mp4"
  '') plots;
in
pkgs.runCommand "coexec-figures"
{
  nativeBuildInputs = [ pkgs.manim pkgs.ffmpeg pkgs.fontconfig pkgs.dejavu_fonts py ];
} ''
  set -euo pipefail

  # manim and matplotlib both want somewhere to scribble; the store is read-only.
  export HOME=$TMPDIR
  export XDG_CACHE_HOME=$TMPDIR/cache
  export MPLCONFIGDIR=$TMPDIR/mpl

  # The scenes render text in DejaVu Sans Mono (sched_common.MONO). Without a
  # fontconfig pointing at it the sandbox has no fonts at all and every label
  # comes out blank rather than failing loudly.
  cat > fonts.conf <<EOF
  <?xml version="1.0"?>
  <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
  <fontconfig>
    <dir>${pkgs.dejavu_fonts}/share/fonts</dir>
    <cachedir>$TMPDIR/fc</cachedir>
  </fontconfig>
  EOF
  export FONTCONFIG_FILE=$PWD/fonts.conf

  cp -r ${../src/figures/coexec}/. .
  chmod -R u+w .
  export FIGURE_DATA=$PWD/data
  export PYTHONPATH=$PWD

  media="$out/presentations/coexec-scheduler/media"
  mkdir -p "$media"

  ${renderScenes}
  ${renderPlots}

  echo "rendered $(ls "$media"/*.mp4 | wc -l) videos, $(ls "$media"/*.png | wc -l) posters"
''
