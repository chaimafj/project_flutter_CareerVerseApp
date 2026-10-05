$ErrorActionPreference = 'Stop'
$flutter = Get-Command flutter -ErrorAction Stop
$flutterRoot = Split-Path (Split-Path $flutter.Source -Parent) -Parent
$env:CAREERVERSE_ICON_FONTS = Join-Path $flutterRoot 'bin\cache\artifacts\material_fonts'
Push-Location (Join-Path $PSScriptRoot '..')
try {
    & flutter test tool\generate_app_icon_test.dart
    if ($LASTEXITCODE -ne 0) {
        throw 'CareerVerse logo rendering failed.'
    }
} finally {
    Pop-Location
    Remove-Item Env:\CAREERVERSE_ICON_FONTS
}
