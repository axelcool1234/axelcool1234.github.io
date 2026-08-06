# Builds the CoExec slide deck from source, at site build time.
#
# The alternative was committing ~20 MB of MP4 into a repo whose entire history
# is 1.4 MB. Instead src/figures/coexec/ holds the manim scenes, the matplotlib
# scripts, and ~76 KB of JSON distilled from the scheduler debug logs (which are
# 237 MB and could never live here), and this derivation turns them into a deck.
#
# It also sidesteps a limitation of the page generator: lib.renderEntries copies
# entry assets with `writeTextDir (readFile ...)`, and readFile refuses binary
# files outright. Media produced by a derivation lands in $out directly and never
# goes near readFile, which is why the deck is built rather than checked in.
#
# format = "html" builds the deck the website serves; "pptx" builds the same
# scenes, in the same order, as a PowerPoint to hand round. One recipe, so the
# two cannot drift -- the pptx used to be assembled by a separate script that
# pasted the plot slides on after the fact.
{ pkgs, format ? "html" }:
let
  # manim-slides pulls in rtoml, whose Rust extension segfaults running its OWN
  # pytest suite under CPython 3.14. The package is fine -- only the test run
  # crashes -- so skip it. (Using python3.12 instead is not an option: its manim
  # fails to build on svgelements, so neither interpreter has both packages.)
  python = pkgs.python3.override {
    packageOverrides = _: prev: {
      rtoml = prev.rtoml.overridePythonAttrs (_: { doCheck = false; });
    };
  };

  py = python.withPackages (p: [
    p.manim
    p.manim-slides
    p.matplotlib
    p.numpy
    p.pillow
    p.python-pptx   # manim-slides' pptx exporter
  ]);

  # reveal.js, pinned rather than loaded from jsDelivr at view time: the deck
  # should not make third-party requests, and a build must not depend on a CDN
  # still being up. manim-slides' cdn_url option is pointed at this copy below.
  revealjs = pkgs.fetchzip {
    url = "https://registry.npmjs.org/reveal.js/-/reveal.js-6.0.1.tgz";
    hash = "sha256-xvpqmoEJEDbP824mei5Ggyx6oy6YKvqhA+/bNH0ODpU=";
  };

  # Matplotlib figures, rendered before the scenes that embed them. They disagree
  # on how the output path is passed: the two that can also draw a static chart
  # take it after --animate, the rest after -o.
  plots = [
    { script = "plot-budget.py"; args = "--data budget-f16.json"; out = "-o"; name = "budget-f16"; }
    { script = "plot-budget.py"; args = "--data budget-canonical.json"; out = "-o"; name = "budget-canonical"; }
    { script = "plot-lifelines.py"; args = "--data lifelines-f16.json"; out = "--animate"; name = "lifelines-f16"; }
    { script = "plot-lifelines.py"; args = "--data lifelines-canonical.json"; out = "--animate"; name = "lifelines-canonical"; }
    { script = "plot-drains.py"; args = "--data drains.json"; out = "--animate"; name = "drains"; }
    { script = "plot-results.py"; args = ""; out = "-o"; name = "results"; }
  ];

  # Deck order. The budget derivation sits between the four DAG edits and the
  # animation that follows, because that animation displays the W[] gates the
  # budget produces -- they arrive unexplained otherwise.
  sceneOrder = [
    { file = "slides_readyqueue.py"; scene = "ReadyQueueSlides"; }
    { file = "slides_tooearly.py"; scene = "TooEarlySlides"; }
    { file = "slides_dagedits.py"; scene = "DagEditsSlides"; }
    { file = "figures_slides.py"; scene = "BudgetSlides"; }
    { file = "slides_dagedges.py"; scene = "DagEdgesSlides"; }
    { file = "figures_slides.py"; scene = "ResultSlides"; }
  ];

  renderPlots = pkgs.lib.concatMapStringsSep "\n" (p: ''
    python3 ${p.script} ${p.args} --dark ${p.out} "fig/${p.name}.mp4"
  '') plots;

  renderScenes = pkgs.lib.concatMapStringsSep "\n" (s: ''
    manim-slides render -qm --media_dir ./media ${s.file} ${s.scene}
  '') sceneOrder;

  # A missing asset shows up in the browser only as a slide that will not
  # advance, and a remote one silently reintroduces a CDN dependency, so check
  # for both. HTML comments are stripped first: the template ships several
  # optional hooks (index.css, index.js, lib/css/zenburn.css) commented out, and
  # those are not references.
  checkDeck = pkgs.writeText "check-deck.py" ''
    import pathlib, re, sys

    dest = pathlib.Path(sys.argv[1])
    html = re.sub(r"<!--.*?-->", "", (dest / "deck.html").read_text(), flags=re.S)
    refs = sorted(set(re.findall(r'(?:src|href)="([^"]+)"', html)))
    remote = [r for r in refs if r.startswith(("http://", "https://", "//"))]
    missing = [r for r in refs if r not in remote and not (dest / r).exists()]
    for label, bad in (("remote", remote), ("missing", missing)):
        for r in bad:
            print("ERROR: " + label + " asset: " + r, file=sys.stderr)
    if remote or missing:
        sys.exit(1)
    print("deck: " + str(len(refs)) + " local references, all resolve, none remote")
  '';

  sceneList = pkgs.lib.concatMapStringsSep " " (s: s.scene) sceneOrder;
in
pkgs.runCommand (if format == "pptx" then "coexec-talk-pptx" else "coexec-figures")
{
  nativeBuildInputs = [ py pkgs.ffmpeg pkgs.fontconfig pkgs.dejavu_fonts ];
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

  mkdir -p fig
  ${renderPlots}
  ${renderScenes}

  if [ "${format}" = pptx ]; then
    mkdir -p "$out"
    # Same BT.601 stamp as the html path applies to the copied deck assets, but
    # done here on the sources, because the pptx embeds them and there is no
    # later chance. See the long note further down for why.
    find ./media ./fig -name '*.mp4' -print0 | while IFS= read -r -d "" v; do
      ffmpeg -loglevel error -y -i "$v" -c copy -f mp4 \
        -bsf:v h264_metadata=colour_primaries=6:transfer_characteristics=6:matrix_coefficients=6 \
        "$v.tagged" && mv "$v.tagged" "$v"
    done
    manim-slides convert --to=pptx ${sceneList} "$out/coexec-talk.pptx"
    echo "pptx: $(du -h "$out/coexec-talk.pptx" | cut -f1), from ${toString (builtins.length sceneOrder)} scenes"
    exit 0
  fi

  dest="$out/presentations/coexec-scheduler"
  mkdir -p "$dest"

  # cdn_url is relative to the deck, so the generated HTML asks for
  # reveal/dist/... next to itself instead of reaching for jsDelivr.
  manim-slides convert --to=html ${sceneList} "$dest/deck.html" \
    -ccdn_url=reveal -ccontrols=true -cprogress=true
  # Copy only the reveal assets the generated deck actually asks for. The npm
  # package is 6 MB, almost all of it themes we do not use; the five referenced
  # files embed their fonts as data URIs, so they stand alone. Driven off the
  # deck itself, so it stays correct if the template ever references more.
  grep -oE '(src|href)="reveal/[^"]+"' "$dest/deck.html" \
    | sed -E 's/.*"reveal\/([^"]+)"/\1/' | sort -u | while read -r rel; do
      mkdir -p "$dest/reveal/$(dirname "$rel")"
      cp "${revealjs}/$rel" "$dest/reveal/$rel"
    done

  # Every video here was written by ffmpeg, which converts RGB->YUV with BT.601
  # but records no colour metadata. A browser seeing an untagged HD video assumes
  # BT.709, decodes with the wrong matrix, and the flat saturated red comes out
  # (253,85,67) instead of (239,68,68) -- visibly a different red from the still
  # PNG on the preceding slide, which is unambiguous sRGB.
  #
  # So say what was actually done: stamp BT.601 (code 6) into the bitstream. This
  # is a metadata rewrite with -c copy, not a re-encode, so it costs nothing and
  # adds no second generation of loss. Re-encoding to BT.709 instead measured
  # worse on every colour, for exactly that reason.
  for v in "$dest"/deck_assets/*.mp4; do
    # -f mp4 because the temp name has no recognised extension, and it must not
    # end in .mp4 or this loop's own glob would pick it up mid-iteration.
    ffmpeg -loglevel error -y -i "$v" -c copy -f mp4 \
      -bsf:v h264_metadata=colour_primaries=6:transfer_characteristics=6:matrix_coefficients=6 \
      "$v.tagged"
    mv "$v.tagged" "$v"
  done

  # An untagged file must never ship again: the symptom is subtle enough to
  # survive review, and only shows up next to the still.
  untagged=0
  for v in "$dest"/deck_assets/*.mp4; do
    cs=$(ffprobe -v error -select_streams v:0 -show_entries stream=color_space -of csv=p=0 "$v")
    [ "$cs" = smpte170m ] || { echo "ERROR: $(basename "$v") colour_space=$cs" >&2; untagged=1; }
  done
  [ "$untagged" = 0 ] || exit 1
  echo "colour: $(ls "$dest"/deck_assets/*.mp4 | wc -l) videos tagged BT.601"

  python3 ${checkDeck} "$dest"

  slides=$(grep -c "<section" "$dest/deck.html" || true)
  echo "deck.html: $slides sections, $(du -sh "$dest" | cut -f1) total"
''
