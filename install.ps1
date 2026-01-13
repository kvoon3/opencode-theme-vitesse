$ErrorActionPreference = "Stop"

$OPENCODE_DIR = "$env:USERPROFILE\.config\opencode"
$THEMES_DIR = "$OPENCODE_DIR\themes"
$TEMP_DIR = Join-Path $env:TEMP "vitesse-theme-$(Get-Random)"
$REPO_URL = "https://github.com/kvoon3/opencode-theme-vitesse.git"

Write-Host "📦 Installing Vitesse Theme for OpenCode..." -ForegroundColor Cyan

New-Item -ItemType Directory -Force -Path $THEMES_DIR | Out-Null

Write-Host "⬇️  Downloading theme files..." -ForegroundColor Yellow
git clone --depth 1 --filter=blob:none --sparse $REPO_URL $TEMP_DIR
Set-Location $TEMP_DIR
git sparse-checkout set themes

Write-Host "📋 Copying Vitesse theme files..." -ForegroundColor Yellow
Copy-Item -Path "themes\vitesse*.json" -Destination $THEMES_DIR -Force

Set-Location $HOME
Remove-Item -Recurse -Force $TEMP_DIR

Write-Host ""
Write-Host "✅ Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📁 Installed themes to: $THEMES_DIR" -ForegroundColor Cyan
Write-Host "   - vitesse.json"
Write-Host "   - vitesse-soft.json"
Write-Host "   - vitesse-dark.json"
Write-Host "   - vitesse-dark-soft.json"
Write-Host "   - vitesse-light.json"
Write-Host "   - vitesse-light-soft.json"
Write-Host ""
Write-Host "🚀 To activate the theme, run in OpenCode:" -ForegroundColor Cyan
Write-Host "   /theme vitesse" -ForegroundColor White
Write-Host ""
Write-Host "💡 Available themes:" -ForegroundColor Cyan
Write-Host "   /theme vitesse         # Auto-switch (light/dark)"
Write-Host "   /theme vitesse-soft    # Auto-switch (soft)"
Write-Host "   /theme vitesse-dark    # Dark"
Write-Host "   /theme vitesse-dark-soft # Dark (soft)"
Write-Host "   /theme vitesse-light   # Light"
Write-Host "   /theme vitesse-light-soft # Light (soft)"
