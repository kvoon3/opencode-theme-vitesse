const dark = {
  foreground: "#d4cfbf",
  background: "#1e1e1e",
  comment: "#758575",
  string: "#d48372",
  literal: "#429988",
  keyword: "#4d9375",
  function: "#a1b567",
  deleted: "#a14f55",
  class: "#54b1bf",
  builtin: "#e0a569",
  property: "#dd8e6e",
  namespace: "#db889a",
  punctuation: "#858585",
  decorator: "#bd8f8f",
  number: "#6394bf",
  boolean: "#1c6b48",
  variable: "#c2b36e",
  regex: "#ab5e3f",
  panel: "#252525",
  border: "#3a3a3a",
  border_active: "#4d9375",
  muted: "#6e6e6e",
  diffAddedBg: "#2a3a2a",
  diffRemovedBg: "#3a2a2a",
};

const light = {
  foreground: "#393a34",
  background: "#fbfbfb",
  comment: "#a0ada0",
  string: "#b56959",
  literal: "#2f8a89",
  keyword: "#1c6b48",
  function: "#6c7834",
  deleted: "#a14f55",
  class: "#2993a3",
  builtin: "#ab5959",
  property: "#b58451",
  namespace: "#b05a78",
  punctuation: "#8e8f8b",
  decorator: "#bd8f8f",
  number: "#296aa3",
  boolean: "#1c6b48",
  variable: "#393a34",
  regex: "#ab5e3f",
  panel: "#f3f3f3",
  border: "#e0e0e0",
  border_active: "#1c6b48",
  muted: "#999999",
  diffAddedBg: "#e8f4e8",
  diffRemovedBg: "#f4e8e8",
};

const darkSoft = { ...dark, background: "#222222", panel: "#292929", border: "#252525" };
const darkBlack = { ...dark, background: "#000000", panel: "#0a0a0a", border: "#1a1a1a" };
const lightSoft = { ...light, background: "#F1F0E9", panel: "#E7E5DB", border: "#E7E5DB" };

const themeKeys = [
  ["primary", "keyword"],
  ["secondary", "class"],
  ["accent", "literal"],
  ["error", "deleted"],
  ["warning", "builtin"],
  ["success", "keyword"],
  ["info", "class"],
  ["text", "foreground"],
  ["textMuted", "muted"],
  ["background", "background"],
  ["backgroundPanel", "panel"],
  ["backgroundElement", "panel"],
  ["border", "border"],
  ["borderActive", "border_active"],
  ["borderSubtle", "border"],
  ["diffAdded", "keyword"],
  ["diffRemoved", "deleted"],
  ["diffContext", "comment"],
  ["diffHunkHeader", "comment"],
  ["diffHighlightAdded", "function"],
  ["diffHighlightRemoved", "string"],
  ["diffAddedBg", "diffAddedBg"],
  ["diffRemovedBg", "diffRemovedBg"],
  ["diffContextBg", "panel"],
  ["diffLineNumber", "punctuation"],
  ["diffAddedLineNumberBg", "diffAddedBg"],
  ["diffRemovedLineNumberBg", "diffRemovedBg"],
  ["markdownText", "foreground"],
  ["markdownHeading", "keyword"],
  ["markdownLink", "class"],
  ["markdownLinkText", "literal"],
  ["markdownCode", "string"],
  ["markdownBlockQuote", "comment"],
  ["markdownEmph", "property"],
  ["markdownStrong", "builtin"],
  ["markdownHorizontalRule", "punctuation"],
  ["markdownListItem", "keyword"],
  ["markdownListEnumeration", "literal"],
  ["markdownImage", "class"],
  ["markdownImageText", "literal"],
  ["markdownCodeBlock", "foreground"],
  ["syntaxComment", "comment"],
  ["syntaxKeyword", "keyword"],
  ["syntaxFunction", "function"],
  ["syntaxVariable", "variable"],
  ["syntaxString", "string"],
  ["syntaxNumber", "number"],
  ["syntaxType", "class"],
  ["syntaxOperator", "keyword"],
  ["syntaxPunctuation", "punctuation"],
] as const;

type Defs = Record<string, string>;

function createTheme(defs: Defs) {
  const theme: Record<string, string> = {};
  for (const [key, ref] of themeKeys) theme[key] = ref;
  return { $schema: "https://opencode.ai/theme.json", defs, theme };
}

function createDualTheme(darkDefs: Defs, lightDefs: Defs) {
  const defs: Defs = {};
  for (const [k, v] of Object.entries(darkDefs)) defs[`dark_${k}`] = v;
  for (const [k, v] of Object.entries(lightDefs)) defs[`light_${k}`] = v;

  const theme: Record<string, { dark: string; light: string }> = {};
  for (const [key, ref] of themeKeys) {
    theme[key] = { dark: `dark_${ref}`, light: `light_${ref}` };
  }
  return { $schema: "https://opencode.ai/theme.json", defs, theme };
}

const themes = {
  "vitesse-dark": createTheme(dark),
  "vitesse-light": createTheme(light),
  "vitesse-dark-soft": createTheme(darkSoft),
  "vitesse-black": createTheme(darkBlack),
  "vitesse-light-soft": createTheme(lightSoft),
  vitesse: createDualTheme(dark, light),
  "vitesse-soft": createDualTheme(darkSoft, lightSoft),
};

await Bun.$`mkdir -p ./themes`;
for (const [name, theme] of Object.entries(themes)) {
  await Bun.write(`./themes/${name}.json`, JSON.stringify(theme, null, 2) + "\n");
  console.log(`✓ ${name}`);
}
console.log(`\n✓ Generated ${Object.keys(themes).length} themes`);
