// Active theme stylesheet link that gets replaced when switching themes.
let themeLink = document.querySelector("#theme-stylesheet");

// Theme picker UI and behavior configuration.
const themeSearch = document.querySelector("#theme-search");
const themeControl = {
  picker: document.querySelector("#theme-picker"),
  summary: document.querySelector("#theme-summary"),
  buttons: Array.from(document.querySelectorAll(".theme-option")),
  storageKey: "theme-file",
  defaultValue: "noctalia.css",
  value: button => button.dataset.themeFile,
  label: button => button.dataset.themeLabel,
  effect: value => swapThemeStylesheet("/themes/" + value)
};

// Mode picker UI and behavior configuration.
const modeControl = {
  picker: document.querySelector("#mode-picker"),
  summary: document.querySelector("#mode-summary"),
  buttons: Array.from(document.querySelectorAll(".mode-option")),
  storageKey: "theme-mode",
  defaultValue: "system",
  value: button => button.dataset.themeMode,
  label: button => button.textContent,
  effect: value => {
    document.documentElement.dataset.themeMode = value;
  }
};

// Mark exactly one button in a group as selected.
function selectButton(buttons, selectedButton) {
  for (const button of buttons) {
    button.classList.toggle("selected", button === selectedButton);
  }
}

// Hide theme buttons that do not match the current search query.
function updateThemeFilter() {
  const query = themeSearch.value.trim().toLowerCase();

  for (const button of themeControl.buttons) {
    const label = button.dataset.themeLabel.toLowerCase();
    const file = button.dataset.themeFile.toLowerCase();
    button.hidden = !(label.includes(query) || file.includes(query));
  }
}

// Load a new theme stylesheet before removing the old one.
function swapThemeStylesheet(href) {
  // If the currently loaded theme stylesheet is already the requested one, nothing needs to be done.
  if (themeLink.getAttribute("href") === href) {
    return;
  }

  const nextThemeLink = themeLink.cloneNode();

  nextThemeLink.removeAttribute("id");
  nextThemeLink.href = href;
  nextThemeLink.addEventListener("load", () => {
    themeLink.remove();
    nextThemeLink.id = "theme-stylesheet";
    themeLink = nextThemeLink;
  });
  themeLink.insertAdjacentElement("afterend", nextThemeLink);
}

// Read a saved control value, falling back if it no longer exists in the UI.
function storedValue(control) {
  const value = localStorage.getItem(control.storageKey);
  return control.buttons.some(button => control.value(button) === value) ? value : control.defaultValue;
}

// Apply one control value: update summary text, storage, selected button, and side effects.
function applyControl(control, value) {
  const selectedButton = control.buttons.find(button => control.value(button) === value);

  if (!selectedButton) {
    return;
  }

  control.summary.textContent = control.summary.textContent.split(":")[0] + ": " + control.label(selectedButton);
  localStorage.setItem(control.storageKey, value);
  selectButton(control.buttons, selectedButton);
  control.effect(value);
}

// Theme selection clicks apply the stylesheet and reset the search UI.
for (const button of themeControl.buttons) {
  button.addEventListener("click", () => {
    applyControl(themeControl, button.dataset.themeFile);
    themeControl.picker.open = false;
    themeSearch.value = "";
    updateThemeFilter();
  });
}

// Mode selection clicks update the root data attribute and close the picker.
for (const button of modeControl.buttons) {
  button.addEventListener("click", () => {
    applyControl(modeControl, button.dataset.themeMode);
    modeControl.picker.open = false;
  });
}

// Keep the theme list filtered as the user types.
themeSearch.addEventListener("input", updateThemeFilter);

// When the theme picker opens, focus the search box for immediate typing.
themeControl.picker.addEventListener("toggle", () => {
  if (themeControl.picker.open) {
    themeSearch.focus();
    themeSearch.select();
  }
});

// Initialize the navbar from saved values, then sync the theme list visibility.
applyControl(modeControl, storedValue(modeControl));
applyControl(themeControl, storedValue(themeControl));
updateThemeFilter();
