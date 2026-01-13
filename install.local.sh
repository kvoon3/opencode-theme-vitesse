#!/bin/bash
set -e

OPENCODE_DIR="$HOME/.config/opencode"
THEMES_DIR="$OPENCODE_DIR/themes"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES_SRC="$SCRIPT_DIR/themes"

echo "📦 Installing Vitesse Theme for OpenCode (Local)..."

if [ ! -d "$THEMES_SRC" ]; then
  echo "❌ Error: themes directory not found at $THEMES_SRC"
  echo "   Make sure you're running this script from the opencode-theme-vitesse repository root."
  exit 1
fi

if ! ls "$THEMES_SRC"/vitesse*.json >/dev/null 2>&1; then
  echo "❌ Error: No vitesse theme files found in $THEMES_SRC"
  exit 1
fi

mkdir -p "$THEMES_DIR"

echo "📋 Copying Vitesse theme files from local repository..."
cp -fv "$THEMES_SRC"/vitesse*.json "$THEMES_DIR/"

echo ""
echo "✅ Installation complete!"
echo ""
echo "📁 Installed themes to: $THEMES_DIR"
echo "   - vitesse.json"
echo "   - vitesse-soft.json"
echo "   - vitesse-dark.json"
echo "   - vitesse-dark-soft.json"
echo "   - vitesse-black.json"
echo "   - vitesse-light.json"
echo "   - vitesse-light-soft.json"
echo ""
echo "🚀 To activate the theme, run in OpenCode:"
echo "   /theme vitesse"
echo ""
echo "💡 Available themes:"
echo "   /theme vitesse              # Auto-switch (light/dark)"
echo "   /theme vitesse-soft         # Auto-switch (soft)"
echo "   /theme vitesse-dark         # Dark"
echo "   /theme vitesse-dark-soft    # Dark (soft)"
echo "   /theme vitesse-black        # Dark (black)"
echo "   /theme vitesse-light        # Light"
echo "   /theme vitesse-light-soft   # Light (soft)"
