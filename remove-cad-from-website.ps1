$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "==============================================" -ForegroundColor Red
Write-Host " KOD4BR UNITED - REMOVE WEBSITE CAD" -ForegroundColor White
Write-Host "==============================================" -ForegroundColor Red
Write-Host ""

$root = Get-Location

if (!(Test-Path "$root\package.json")) {
    Write-Host "ERROR: package.json was not found." -ForegroundColor Red
    Write-Host ""
    Write-Host "Run this script from your Next.js website root." -ForegroundColor Yellow
    exit 1
}

Write-Host "Website detected:" -ForegroundColor Cyan
Write-Host $root
Write-Host ""

# ============================================================
# REMOVE CAD APP
# ============================================================

$cadApp = Join-Path $root "src\app\cad"

if (Test-Path $cadApp) {

    Write-Host "Removing CAD application..." -ForegroundColor Yellow

    Remove-Item `
        -Path $cadApp `
        -Recurse `
        -Force

    Write-Host "Removed src\app\cad" -ForegroundColor Green

}
else {
    Write-Host "src\app\cad was already removed." -ForegroundColor DarkGray
}

# ============================================================
# REMOVE CAD COMPONENTS
# ============================================================

$cadComponents = Join-Path $root "src\components\cad"

if (Test-Path $cadComponents) {

    Write-Host "Removing CAD components..." -ForegroundColor Yellow

    Remove-Item `
        -Path $cadComponents `
        -Recurse `
        -Force

    Write-Host "Removed src\components\cad" -ForegroundColor Green

}
else {
    Write-Host "src\components\cad was already removed." -ForegroundColor DarkGray
}

# ============================================================
# REMOVE CAD LIBRARY
# ============================================================

$cadLibrary = Join-Path $root "src\lib\cad"

if (Test-Path $cadLibrary) {

    Write-Host "Removing CAD library..." -ForegroundColor Yellow

    Remove-Item `
        -Path $cadLibrary `
        -Recurse `
        -Force

    Write-Host "Removed src\lib\cad" -ForegroundColor Green

}
else {
    Write-Host "src\lib\cad was already removed." -ForegroundColor DarkGray
}

# ============================================================
# REMOVE CAD-SPECIFIC CSS
# ============================================================

$globals = Join-Path $root "src\app\globals.css"

if (Test-Path $globals) {

    Write-Host ""
    Write-Host "Checking globals.css for CAD styles..." -ForegroundColor Cyan

    $css = Get-Content $globals -Raw

    # Remove common CAD sections if they are wrapped in
    # identifiable CAD comments.
    $css = [regex]::Replace(
        $css,
        '(?s)/\*\s*CAD.*?\*/.*?(?=/\*\s*END CAD|\z)',
        ''
    )

    $css = [regex]::Replace(
        $css,
        '(?s)/\*\s*CAD.*?\*/.*?/\*\s*END CAD.*?\*/',
        ''
    )

    Set-Content `
        -Path $globals `
        -Value $css `
        -Encoding UTF8

    Write-Host "globals.css checked." -ForegroundColor Green
}

# ============================================================
# REMOVE NEXT CACHE
# ============================================================

$nextCache = Join-Path $root ".next"

if (Test-Path $nextCache) {

    Write-Host ""
    Write-Host "Removing Next.js build cache..." -ForegroundColor Yellow

    Remove-Item `
        -Path $nextCache `
        -Recurse `
        -Force

    Write-Host ".next removed." -ForegroundColor Green
}

# ============================================================
# SEARCH FOR REMAINING CAD REFERENCES
# ============================================================

Write-Host ""
Write-Host "Searching website source for remaining CAD references..." -ForegroundColor Cyan
Write-Host ""

$src = Join-Path $root "src"

if (Test-Path $src) {

    $references = Get-ChildItem `
        -Path $src `
        -Recurse `
        -File `
        -Include *.tsx,*.ts,*.jsx,*.js,*.css `
        | Select-String `
            -Pattern "CADPanelLayout|CAD_PANELS|/cad/|@/components/cad|@/lib/cad" `
            -SimpleMatch `
            -ErrorAction SilentlyContinue

    if ($references) {

        Write-Host "WARNING: CAD references still exist:" -ForegroundColor Yellow
        Write-Host ""

        foreach ($reference in $references) {
            Write-Host "$($reference.Path):$($reference.LineNumber)" -ForegroundColor Yellow
            Write-Host $reference.Line.Trim()
            Write-Host ""
        }

    }
    else {

        Write-Host "No obvious CAD imports/routes remain." -ForegroundColor Green

    }
}

# ============================================================
# CHECK TYPESCRIPT
# ============================================================

Write-Host ""
Write-Host "Checking TypeScript..." -ForegroundColor Cyan
Write-Host ""

$tsc = Join-Path $root "node_modules\.bin\tsc.cmd"

if (Test-Path $tsc) {

    & $tsc --noEmit

    if ($LASTEXITCODE -eq 0) {

        Write-Host ""
        Write-Host "TypeScript check PASSED." -ForegroundColor Green

    }
    else {

        Write-Host ""
        Write-Host "TypeScript reported errors." -ForegroundColor Red
        Write-Host "These may be remaining CAD imports that need removal." -ForegroundColor Yellow

    }

}
else {

    Write-Host "TypeScript executable not found. Skipping check." -ForegroundColor Yellow

}

# ============================================================
# DONE
# ============================================================

Write-Host ""
Write-Host "==============================================" -ForegroundColor Green
Write-Host " WEBSITE CAD REMOVAL COMPLETE" -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
Write-Host ""

Write-Host "Removed:" -ForegroundColor Cyan
Write-Host "  src\app\cad"
Write-Host "  src\components\cad"
Write-Host "  src\lib\cad"
Write-Host ""

Write-Host "Your main website remains intact." -ForegroundColor Green
Write-Host ""

Write-Host "IMPORTANT:" -ForegroundColor Yellow
Write-Host "Your Supabase project/database was NOT deleted."
Write-Host "You can use it with your standalone CAD application."
Write-Host ""

Write-Host "Start the website with:" -ForegroundColor Cyan
Write-Host "npm run dev" -ForegroundColor White
Write-Host ""
