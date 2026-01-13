#!/bin/bash
set -e

OPENCODE_DIR="$HOME/.config/opencode"
THEMES_DIR="$OPENCODE_DIR/themes"
TEMP_DIR=$(mktemp -d)
REPO_URL="https://github.com/kvoon3/opencode-theme-vitesse.git"

echo "📦 Installing Vitesse Theme for OpenCode..."

mkdir -p "$THEMES_DIR"

echo "⬇️  Downloading theme files..."
git clone --depth 1 --filter=blob:none --sparse "$REPO_URL" "$TEMP_DIR"
cd "$TEMP_DIR"
git sparse-checkout set themes

echo "📋 Copying Vitesse theme files..."
cp -f themes/vitesse*.json "$THEMES_DIR/"

rm -rf "$TEMP_DIR"

echo ""
echo "✅ Installation complete!"
echo ""
echo "📁 Installed themes to: $THEMES_DIR"
echo "   - vitesse.json"
echo "   - vitesse-soft.json"
echo "   - vitesse-dark.json"
echo "   - vitesse-dark-soft.json"
echo "   - vitesse-light.json"
echo "   - vitesse-light-soft.json"
echo ""
echo "🚀 To activate the theme, run in OpenCode:"
echo "   /theme vitesse"
echo ""
echo "💡 Available themes:"
echo "   /theme vitesse         # Auto-switch (light/dark)"
echo "   /theme vitesse-soft    # Auto-switch (soft)"
echo "   /theme vitesse-dark    # Dark"
echo "   /theme vitesse-dark-soft # Dark (soft)"
echo "   /theme vitesse-light   # Light"
echo "   /theme vitesse-light-soft # Light (soft)"
