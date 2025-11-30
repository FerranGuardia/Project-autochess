# Script de Diagnóstico Git para PowerShell
# Ejecuta este script desde PowerShell para diagnosticar problemas con git

Write-Host "`n=== DIAGNÓSTICO GIT ===" -ForegroundColor Cyan
Write-Host "========================`n" -ForegroundColor Cyan

# 1. Verificar ubicación actual
Write-Host "1. UBICACIÓN ACTUAL" -ForegroundColor Yellow
$currentPath = Get-Location
Write-Host "   Directorio actual: $currentPath" -ForegroundColor White
Write-Host ""

# 2. Verificar que .git existe
Write-Host "2. VERIFICANDO CARPETA .git" -ForegroundColor Yellow
if (Test-Path .git) {
    Write-Host "   ✓ .git existe" -ForegroundColor Green
    $gitPath = Resolve-Path .git
    Write-Host "   Ruta: $gitPath" -ForegroundColor Gray
} else {
    Write-Host "   ✗ .git NO existe" -ForegroundColor Red
    Write-Host "   ⚠️  Asegúrate de estar en: C:\Users\Nitropc\Desktop\autochess" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "   Para ir al directorio correcto, ejecuta:" -ForegroundColor Cyan
    Write-Host "   cd C:\Users\Nitropc\Desktop\autochess" -ForegroundColor White
}
Write-Host ""

# 3. Verificar Git instalado
Write-Host "3. VERIFICANDO GIT INSTALADO" -ForegroundColor Yellow
try {
    $version = git --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✓ Git instalado: $version" -ForegroundColor Green
    } else {
        Write-Host "   ✗ Error al ejecutar git --version" -ForegroundColor Red
    }
} catch {
    Write-Host "   ✗ Git NO está instalado o no está en PATH" -ForegroundColor Red
    Write-Host "   Error: $_" -ForegroundColor Red
}
Write-Host ""

# 4. Verificar PATH
Write-Host "4. VERIFICANDO PATH" -ForegroundColor Yellow
$pathEntries = $env:PATH -split ';'
$gitInPath = $pathEntries | Where-Object { $_ -like '*git*' }
if ($gitInPath) {
    Write-Host "   ✓ Git encontrado en PATH:" -ForegroundColor Green
    $gitInPath | ForEach-Object { Write-Host "      $_" -ForegroundColor Gray }
} else {
    Write-Host "   ✗ Git NO está en PATH" -ForegroundColor Red
    Write-Host "   ⚠️  Agrega: C:\Program Files\Git\cmd" -ForegroundColor Yellow
}
Write-Host ""

# 5. Verificar repositorio válido
Write-Host "5. VERIFICANDO REPOSITORIO VÁLIDO" -ForegroundColor Yellow
try {
    $topLevel = git rev-parse --show-toplevel 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✓ Repositorio válido en: $topLevel" -ForegroundColor Green
    } else {
        Write-Host "   ✗ No es un repositorio git válido" -ForegroundColor Red
        Write-Host "   Error: $topLevel" -ForegroundColor Red
    }
} catch {
    Write-Host "   ✗ Error al verificar repositorio" -ForegroundColor Red
    Write-Host "   Error: $_" -ForegroundColor Red
}
Write-Host ""

# 6. Verificar branch actual
Write-Host "6. VERIFICANDO BRANCH ACTUAL" -ForegroundColor Yellow
try {
    $branch = git branch --show-current 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✓ Branch actual: $branch" -ForegroundColor Green
    } else {
        Write-Host "   ⚠️  No se pudo determinar el branch" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   ✗ Error al obtener branch" -ForegroundColor Red
}
Write-Host ""

# 7. Verificar estado
Write-Host "7. VERIFICANDO ESTADO DEL REPOSITORIO" -ForegroundColor Yellow
try {
    $status = git status --short 2>&1
    if ($LASTEXITCODE -eq 0) {
        if ($status) {
            Write-Host "   ⚠️  Hay cambios sin commitear:" -ForegroundColor Yellow
            $status | ForEach-Object { Write-Host "      $_" -ForegroundColor Gray }
        } else {
            Write-Host "   ✓ Repositorio limpio (sin cambios pendientes)" -ForegroundColor Green
        }
    } else {
        Write-Host "   ✗ Error al obtener estado" -ForegroundColor Red
        Write-Host "   Error: $status" -ForegroundColor Red
    }
} catch {
    Write-Host "   ✗ Error al verificar estado" -ForegroundColor Red
}
Write-Host ""

# Resumen y recomendaciones
Write-Host "=== RESUMEN Y RECOMENDACIONES ===" -ForegroundColor Cyan
Write-Host "=================================`n" -ForegroundColor Cyan

$allGood = $true

if (-not (Test-Path .git)) {
    Write-Host "❌ PROBLEMA: No estás en el directorio del repositorio" -ForegroundColor Red
    Write-Host "   SOLUCIÓN: Ejecuta: cd C:\Users\Nitropc\Desktop\autochess`n" -ForegroundColor Yellow
    $allGood = $false
}

try {
    $null = git --version 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ PROBLEMA: Git no está instalado o no está en PATH" -ForegroundColor Red
        Write-Host "   SOLUCIÓN: Instala Git o agrega C:\Program Files\Git\cmd al PATH`n" -ForegroundColor Yellow
        $allGood = $false
    }
} catch {
    Write-Host "❌ PROBLEMA: Git no está disponible" -ForegroundColor Red
    $allGood = $false
}

if ($allGood) {
    Write-Host "✓ Todo parece estar bien configurado" -ForegroundColor Green
    Write-Host "  Puedes ejecutar comandos git normalmente`n" -ForegroundColor Green
} else {
    Write-Host "`nPara más ayuda, consulta:" -ForegroundColor Cyan
    Write-Host "  - docs/TROUBLESHOOTING_GIT_POWERSHELL.md" -ForegroundColor White
}

Write-Host "`n=== FIN DEL DIAGNÓSTICO ===`n" -ForegroundColor Cyan








