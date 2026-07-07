{ lib, themeNames }:
let
  themeOptions = lib.concatMapStringsSep "\n" (
    name:
    let
      label = lib.titleFromName (lib.removeSuffix ".css" name);
    in
    ''<button type="button" class="theme-option" data-theme-file="${name}" data-theme-label="${label}">${label}</button>''
  ) themeNames;
in
/* html */ ''
  <div class="nav-links">
    <a href="/index.html">Home</a>
    <a href="/notes/">Notes</a>
  </div>

  <div class="nav-controls">
    <details id="theme-picker" class="theme-picker">
      <summary id="theme-summary" class="theme-summary">Theme</summary>
      <div class="theme-menu">
        <input id="theme-search" class="theme-search" type="search" placeholder="Search themes">
        <div class="theme-options">
          ${themeOptions}
        </div>
      </div>
    </details>

    <details id="mode-picker" class="mode-picker">
      <summary id="mode-summary" class="mode-summary">Mode</summary>
      <div class="mode-menu">
        <button type="button" class="mode-option" data-theme-mode="system">System</button>
        <button type="button" class="mode-option" data-theme-mode="dark">Dark</button>
        <button type="button" class="mode-option" data-theme-mode="light">Light</button>
      </div>
    </details>
  </div>
''
