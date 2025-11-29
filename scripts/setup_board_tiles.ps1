# Script para configurar tiles del tablero
# Copia tile_board_borde.png a todos los bordes decorativos
# Copia tile_board_combat.png a todos los tiles del interior (grid ally + grid enemy)

$boardDir = "assets/sprites/arena/tiles/board"
$tileBorde = "$boardDir/tile_board_borde.png"
$tileCombat = "$boardDir/tile_board_combat.png"

# Verificar que existen los archivos fuente
if (-not (Test-Path $tileBorde)) {
    Write-Host "ERROR: No se encuentra $tileBorde" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $tileCombat)) {
    Write-Host "ERROR: No se encuentra $tileCombat" -ForegroundColor Red
    exit 1
}

Write-Host "Configurando tiles del tablero..." -ForegroundColor Cyan
Write-Host "Bordes (tile_board_borde.png) -> 38 tiles" -ForegroundColor Yellow
Write-Host "Interior (tile_board_combat.png) -> 70 tiles" -ForegroundColor Yellow
Write-Host ""

# Definir tiles de borde (38 tiles)
$borderTiles = @()
# Fila superior (tiles 1-9)
$borderTiles += 1..9
# Fila inferior (tiles 100-108)
$borderTiles += 100..108
# Columna izquierda, filas 1-10 (tiles 10, 19, 28, 37, 46, 55, 64, 73, 82, 91)
$borderTiles += 10, 19, 28, 37, 46, 55, 64, 73, 82, 91
# Columna derecha, filas 1-10 (tiles 18, 27, 36, 45, 54, 63, 72, 81, 90, 99)
$borderTiles += 18, 27, 36, 45, 54, 63, 72, 81, 90, 99

# Definir tiles del interior (70 tiles)
# Grid Enemigo: filas 1-5, columnas 1-7
# Grid Aliado: filas 6-10, columnas 1-7
$interiorTiles = @(11..17) + @(20..26) + @(29..35) + @(38..44) + @(47..53) + @(56..62) + @(65..71) + @(74..80) + @(83..89) + @(92..98)

# Copiar tile_board_borde.png a todos los bordes
Write-Host "Copiando tile_board_borde.png a bordes..." -ForegroundColor Green
$borderCount = 0
foreach ($tileNum in $borderTiles) {
    $destFile = "$boardDir/tile_board_$tileNum.png"
    Copy-Item -Path $tileBorde -Destination $destFile -Force -ErrorAction SilentlyContinue
    $borderCount++
    if ($borderCount % 10 -eq 0) {
        Write-Host "  Procesados $borderCount bordes..." -ForegroundColor Gray
    }
}
Write-Host "  ✓ $borderCount tiles de borde configurados" -ForegroundColor Green

# Copiar tile_board_combat.png a todos los tiles del interior
Write-Host "Copiando tile_board_combat.png a interior..." -ForegroundColor Green
$interiorCount = 0
foreach ($tileNum in $interiorTiles) {
    $destFile = "$boardDir/tile_board_$tileNum.png"
    Copy-Item -Path $tileCombat -Destination $destFile -Force -ErrorAction SilentlyContinue
    $interiorCount++
    if ($interiorCount % 10 -eq 0) {
        Write-Host "  Procesados $interiorCount tiles de interior..." -ForegroundColor Gray
    }
}
Write-Host "  ✓ $interiorCount tiles de interior configurados" -ForegroundColor Green

Write-Host ""
Write-Host "✅ Configuración completada!" -ForegroundColor Cyan
Write-Host "   Total de tiles configurados: $($borderCount + $interiorCount) de 108" -ForegroundColor Cyan

