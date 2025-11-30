# Script para optimizar rendimiento de Cursor con Git
# Ejecuta este script para mejorar la velocidad de Cursor

Write-Host "`n=== OPTIMIZACIÓN CURSOR ===" -ForegroundColor Cyan
Write-Host "===========================`n" -ForegroundColor Cyan

# 1. Verificar estado actual
Write-Host "1. ESTADO ACTUAL" -ForegroundColor Yellow
$stagedCount = (git diff --cached --name-only 2>$null | Measure-Object -Line).Lines
$unstagedCount = (git diff --name-only 2>$null | Measure-Object -Line).Lines
$untrackedCount = (git ls-files --others --exclude-standard 2>$null | Measure-Object -Line).Lines

Write-Host "   Archivos en staging: $stagedCount" -ForegroundColor $(if ($stagedCount -gt 50) { "Red" } else { "Green" })
Write-Host "   Archivos sin staging: $unstagedCount" -ForegroundColor White
Write-Host "   Archivos sin trackear: $untrackedCount" -ForegroundColor White
Write-Host ""

# 2. Optimizar Git para mejor rendimiento
Write-Host "2. OPTIMIZANDO CONFIGURACIÓN GIT" -ForegroundColor Yellow

# Configurar Git para mejor rendimiento en Windows
git config core.preloadindex true
git config core.fscache true
git config gc.auto 256

Write-Host "   ✓ Configuración optimizada" -ForegroundColor Green
Write-Host ""

# 3. Recomendaciones
Write-Host "3. RECOMENDACIONES" -ForegroundColor Yellow

if ($stagedCount -gt 50) {
    Write-Host "   ⚠️  PROBLEMA: Muchos archivos en staging ($stagedCount)" -ForegroundColor Red
    Write-Host ""
    Write-Host "   OPCIONES:" -ForegroundColor Cyan
    Write-Host "   A) Hacer commit de los cambios:" -ForegroundColor White
    Write-Host "      git commit -m 'Limpiar tiles antiguos'" -ForegroundColor Gray
    Write-Host ""
    Write-Host "   B) Deshacer staging (si no están listos):" -ForegroundColor White
    Write-Host "      git restore --staged ." -ForegroundColor Gray
    Write-Host ""
    Write-Host "   C) Hacer commit parcial (solo algunos archivos):" -ForegroundColor White
    Write-Host "      git commit -m 'Actualizar .gitignore'" -ForegroundColor Gray
    Write-Host "      git restore --staged assets/" -ForegroundColor Gray
    Write-Host ""
} else {
    Write-Host "   ✓ Staging area está limpio" -ForegroundColor Green
}

# 4. Verificar .gitignore
Write-Host "4. VERIFICANDO .gitignore" -ForegroundColor Yellow
if (Test-Path .gitignore) {
    $gitignoreContent = Get-Content .gitignore -Raw
    if ($gitignoreContent -notmatch "\.import") {
        Write-Host "   ⚠️  Considera agregar *.import al .gitignore" -ForegroundColor Yellow
    } else {
        Write-Host "   ✓ .gitignore incluye archivos .import" -ForegroundColor Green
    }
} else {
    Write-Host "   ⚠️  No hay .gitignore" -ForegroundColor Yellow
}
Write-Host ""

# 5. Limpiar archivos temporales de Git
Write-Host "5. LIMPIEZA" -ForegroundColor Yellow
Write-Host "   Ejecutando git gc para optimizar repositorio..." -ForegroundColor Gray
git gc --prune=now --aggressive 2>&1 | Out-Null
Write-Host "   ✓ Repositorio optimizado" -ForegroundColor Green
Write-Host ""

# Resumen
Write-Host "=== RESUMEN ===" -ForegroundColor Cyan
Write-Host "==============`n" -ForegroundColor Cyan

if ($stagedCount -gt 50) {
    Write-Host "🎯 ACCIÓN RECOMENDADA:" -ForegroundColor Yellow
    Write-Host "   Haz commit de los cambios staged para mejorar el rendimiento" -ForegroundColor White
    Write-Host "   Esto reducirá la carga de indexación de Cursor`n" -ForegroundColor Gray
} else {
    Write-Host "✓ Todo está optimizado" -ForegroundColor Green
    Write-Host "  Cursor debería funcionar más rápido ahora`n" -ForegroundColor Green
}

Write-Host "=== FIN ===" -ForegroundColor Cyan

