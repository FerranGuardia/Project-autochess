# 🎨 Configuración de Tiles del Tablero - AutoChess

**Fecha de creación:** 26 de Diciembre 2024  
**Estado:** ✅ Configurado - Tablero Simple/MVP  
**Branch:** `feature/arena-visual`

---

## 📋 Resumen

### ⚠️ Tablero Simple (MVP)

Este es el **tablero base simple** que se está usando actualmente. Se decidió usar solo **dos sprites** para simplificar la creación y evitar problemas de configuración.

**Decisión de diseño:** Usar un sistema simple con solo 2 sprites diferentes en lugar de 108 tiles únicos facilita:
- ✅ Creación rápida del tablero
- ✅ Menos problemas de configuración
- ✅ Más fácil de mantener
- ✅ Base sólida para futuros tableros más complejos

**Nota:** En el futuro se pueden crear tableros más complejos con tiles únicos, pero este servirá como base estable.

### Configuración Actual

El tablero utiliza **dos sprites diferentes**:

- **`tile_board_borde.png`** → Usado para todos los **bordes decorativos** (38 tiles)
- **`tile_board_combat.png`** → Usado para todo el **interior** (grid ally + grid enemy) (70 tiles)

**Total:** 108 tiles configurados

---

## 🔢 Distribución de Tiles

### Bordes Decorativos (38 tiles) - `tile_board_borde.png`

#### Fila Superior
- Tiles: **1-9** (9 tiles)

#### Fila Inferior
- Tiles: **100-108** (9 tiles)

#### Columna Izquierda (filas 1-10)
- Tiles: **10, 19, 28, 37, 46, 55, 64, 73, 82, 91** (10 tiles)

#### Columna Derecha (filas 1-10)
- Tiles: **18, 27, 36, 45, 54, 63, 72, 81, 90, 99** (10 tiles)

**Total bordes:** 9 + 9 + 10 + 10 = **38 tiles**

### Interior - Grid de Combate (70 tiles) - `tile_board_combat.png`

#### Grid Enemigo (35 tiles)
- Fila 1: tiles **11-17** (7 tiles)
- Fila 2: tiles **20-26** (7 tiles)
- Fila 3: tiles **29-35** (7 tiles)
- Fila 4: tiles **38-44** (7 tiles)
- Fila 5: tiles **47-53** (7 tiles)

#### Grid Aliado (35 tiles)
- Fila 6: tiles **56-62** (7 tiles)
- Fila 7: tiles **65-71** (7 tiles)
- Fila 8: tiles **74-80** (7 tiles)
- Fila 9: tiles **83-89** (7 tiles)
- Fila 10: tiles **92-98** (7 tiles)

**Total interior:** 35 + 35 = **70 tiles**

---

## 🛠️ Script de Configuración

Se ha creado un script PowerShell para automatizar la configuración de tiles:

**Ubicación:** `scripts/setup_board_tiles.ps1`

### Uso

```powershell
powershell -ExecutionPolicy Bypass -File scripts/setup_board_tiles.ps1
```

### Funcionalidad

El script:
1. Verifica que existan `tile_board_borde.png` y `tile_board_combat.png`
2. Copia `tile_board_borde.png` a todos los tiles de borde (38 tiles)
3. Copia `tile_board_combat.png` a todos los tiles del interior (70 tiles)
4. Genera un resumen de la configuración

---

## 📂 Estructura de Archivos

```
assets/sprites/arena/tiles/board/
├── tile_board_borde.png      (sprite de borde - fuente)
├── tile_board_combat.png     (sprite de interior - fuente)
├── tile_board_borde.png.import
├── tile_board_combat.png.import
├── tile_board_1.png          (copia de tile_board_borde.png)
├── tile_board_2.png          (copia de tile_board_borde.png)
├── ...
├── tile_board_108.png        (copia de tile_board_borde.png o tile_board_combat.png según posición)
└── [archivos .import correspondientes]
```

---

## 🎯 Mapeo Visual

```
┌─────────────────────────────────────┐
│  BORDE (tile_board_borde)           │ ← Fila 0: tiles 1-9
├─────────────────────────────────────┤
│ │                                 │ │
│ │   GRID ENEMIGO (tile_board_combat) │ ← Filas 1-5: tiles 11-17, 20-26, 29-35, 38-44, 47-53
│ │                                 │ │
│ ├─────────────────────────────────┤ │
│ │                                 │ │
│ │   GRID ALIADO (tile_board_combat)  │ ← Filas 6-10: tiles 56-62, 65-71, 74-80, 83-89, 92-98
│ │                                 │ │
│ └─────────────────────────────────┘ │
│  BORDE (tile_board_borde)           │ ← Fila 11: tiles 100-108
└─────────────────────────────────────┘
```

---

## ✅ Verificación

Para verificar que todos los tiles están configurados correctamente:

```powershell
# Contar tiles
Get-ChildItem -Path "assets/sprites/arena/tiles/board" -Filter "tile_board_*.png" | Measure-Object | Select-Object -ExpandProperty Count
# Debe mostrar: 108

# Listar todos los tiles
Get-ChildItem -Path "assets/sprites/arena/tiles/board" -Filter "tile_board_*.png" | Select-Object Name | Sort-Object { [int]($_ -replace '[^0-9]', '') }
```

---

## 📝 Notas

- Los tiles se numeran de **1 a 108** en orden de izquierda a derecha, arriba a abajo
- Cada tile es de **100×100 píxeles**
- El sistema carga los tiles automáticamente según su índice
- Si falta un tile, el sistema intentará usar un fallback genérico

## 🔮 Futuros Tableros

Este tablero simple servirá como base. Para futuros tableros más complejos:

1. **Crear nuevos sprites** con variaciones visuales
2. **Actualizar el script** `setup_board_tiles.ps1` con la nueva distribución
3. **Ejecutar el script** para configurar los tiles
4. **Probar en GitHub** antes de pasar a producción

El sistema está diseñado para ser flexible y permitir diferentes configuraciones de tablero.

---

**Última actualización:** 26 de Diciembre 2024

