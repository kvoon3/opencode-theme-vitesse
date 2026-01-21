$ErrorActionPreference = "Stop"

$OPENCODE_DIR = "$env:USERPROFILE\.config\opencode"
$THEMES_DIR = "$OPENCODE_DIR\themes"
$TEMP_DIR = Join-Path $env:TEMP "vitesse-theme-$(Get-Random)"
$REPO_URL = "https://github.com/kvoon3/opencode-theme-vitesse.git"

Write-Host "📦 Installing Vitesse Theme for OpenCode..." -ForegroundColor Cyan

New-Item -ItemType Directory -Force -Path $THEMES_DIR | Out-Null

Write-Host "⬇️  Downloading theme files..." -ForegroundColor Yellow

# Try to clone with retries
$maxRetries = 3
$retryCount = 0
$cloneSuccess = $false

while (-not $cloneSuccess -and $retryCount -lt $maxRetries) {
    try {
        if ($retryCount -gt 0) {
            Write-Host "🔄 Retry attempt $retryCount of $maxRetries..." -ForegroundColor Yellow
        }
        
        git clone --depth 1 --filter=blob:none --sparse $REPO_URL $TEMP_DIR 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            $cloneSuccess = $true
        } else {
            throw "Git clone failed with exit code $LASTEXITCODE"
        }
    }
    catch {
        $retryCount++
        if ($retryCount -lt $maxRetries) {
            Write-Host "⚠️  Clone failed, retrying in 2 seconds..." -ForegroundColor Yellow
            Start-Sleep -Seconds 2
        } else {
            Write-Host ""
            Write-Host "❌ Error: Failed to download theme files after $maxRetries attempts." -ForegroundColor Red
            Write-Host ""
            Write-Host "This could be due to:" -ForegroundColor Yellow
            Write-Host "  • Network connectivity issues"
            Write-Host "  • Git configuration problems"
            Write-Host "  • GitHub connection issues"
            Write-Host ""
            Write-Host "💡 Possible solutions:" -ForegroundColor Cyan
            Write-Host "  1. Check your internet connection"
            Write-Host "  2. Try increasing Git buffer size: git config --global http.postBuffer 524288000"
            Write-Host "  3. Try using a VPN or different network"
            Write-Host "  4. Manual installation: Download from https://github.com/kvoon3/opencode-theme-vitesse"
            Write-Host ""
            exit 1
        }
    }
}

if (-not (Test-Path $TEMP_DIR)) {
    Write-Host "❌ Error: Temporary directory was not created." -ForegroundColor Red
    exit 1
}

Set-Location $TEMP_DIR
git sparse-checkout set themes

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error: Failed to checkout theme files." -ForegroundColor Red
    Set-Location $HOME
    Remove-Item -Recurse -Force $TEMP_DIR -ErrorAction SilentlyContinue
    exit 1
}

Write-Host "📋 Copying Vitesse theme files..." -ForegroundColor Yellow

try {
    $themeFiles = Get-ChildItem -Path "themes\vitesse*.json" -ErrorAction Stop
    if ($themeFiles.Count -eq 0) {
        throw "No theme files found in themes directory"
    }
    Copy-Item -Path "themes\vitesse*.json" -Destination $THEMES_DIR -Force -ErrorAction Stop
}
catch {
    Write-Host "❌ Error: Failed to copy theme files." -ForegroundColor Red
    Write-Host "   $_" -ForegroundColor Red
    Set-Location $HOME
    Remove-Item -Recurse -Force $TEMP_DIR -ErrorAction SilentlyContinue
    exit 1
}

Set-Location $HOME
Remove-Item -Recurse -Force $TEMP_DIR -ErrorAction SilentlyContinue

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
