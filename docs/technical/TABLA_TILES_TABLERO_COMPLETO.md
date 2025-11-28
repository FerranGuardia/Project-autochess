# 📋 Tabla de Tiles del Tablero Completo - AutoChess

**Fecha de creación:** 26 de Diciembre 2024  
**Estado:** ✅ Definido  
**Branch:** `feature/arena-visual`

---

## 🎯 Concepto de Tablero

El **tablero** está compuesto por:
- **Grid Enemigo** (7×5 = 35 celdas)
- **Grid Aliado** (7×5 = 35 celdas)
- **Borde Decorativo** (38 celdas alrededor)
- **Total:** 108 tiles de 100×100 píxeles

---

## 📐 Dimensiones para GIMP

### Canvas del Tablero Completo
- **Ancho:** 900 píxeles (9 columnas × 100px)
- **Alto:** 1,200 píxeles (12 filas × 100px)
- **Total de tiles:** 108 tiles
- **Tamaño de cada tile:** 100×100 píxeles

### Estructura del Tablero
```
┌─────────────────────────────────────────────────────────┐
│ Fila 0: Borde Superior (tiles 1-9)                     │
├─────────────────────────────────────────────────────────┤
│ │ Fila 1: Grid Enemigo Fila 0 (tiles 10-18)          │ │
│ │ Fila 2: Grid Enemigo Fila 1 (tiles 19-27)          │ │
│ │ Fila 3: Grid Enemigo Fila 2 (tiles 28-36)          │ │
│ │ Fila 4: Grid Enemigo Fila 3 (tiles 37-45)          │ │
│ │ Fila 5: Grid Enemigo Fila 4 (tiles 46-54)          │ │
├─────────────────────────────────────────────────────────┤
│ │ Fila 6: Grid Aliado Fila 0 (tiles 55-63)            │ │
│ │ Fila 7: Grid Aliado Fila 1 (tiles 64-72)           │ │
│ │ Fila 8: Grid Aliado Fila 2 (tiles 73-81)           │ │
│ │ Fila 9: Grid Aliado Fila 3 (tiles 82-90)           │ │
│ │ Fila 10: Grid Aliado Fila 4 (tiles 91-99)          │ │
├─────────────────────────────────────────────────────────┤
│ Fila 11: Borde Inferior (tiles 100-108)                 │
└─────────────────────────────────────────────────────────┘
```

---

## 🔢 Numeración de Tiles

### Sistema de Numeración
- **Formato:** `tile_board_1.png` a `tile_board_108.png`
- **Orden:** De izquierda a derecha, de arriba a abajo
- **Primer tile:** Esquina superior izquierda = `tile_board_1.png`
- **Último tile:** Esquina inferior derecha = `tile_board_108.png`

### Mapeo Detallado

#### Fila 0 - Borde Superior (tiles 1-9)
| Col | Tile | Descripción |
|-----|------|-------------|
| 0 | tile_board_1.png | Esquina superior izquierda |
| 1 | tile_board_2.png | Borde superior |
| 2 | tile_board_3.png | Borde superior |
| 3 | tile_board_4.png | Borde superior |
| 4 | tile_board_5.png | Borde superior |
| 5 | tile_board_6.png | Borde superior |
| 6 | tile_board_7.png | Borde superior |
| 7 | tile_board_8.png | Borde superior |
| 8 | tile_board_9.png | Esquina superior derecha |

#### Filas 1-5 - Grid Enemigo

**Fila 1 (Grid Enemigo Fila 0):** tiles 10-18
- Col 0 (borde): tile_board_10.png
- Cols 1-7 (grid): tiles 11-17
- Col 8 (borde): tile_board_18.png

**Fila 2 (Grid Enemigo Fila 1):** tiles 19-27
- Col 0 (borde): tile_board_19.png
- Cols 1-7 (grid): tiles 20-26
- Col 8 (borde): tile_board_27.png

**Fila 3 (Grid Enemigo Fila 2):** tiles 28-36
- Col 0 (borde): tile_board_28.png
- Cols 1-7 (grid): tiles 29-35
- Col 8 (borde): tile_board_36.png

**Fila 4 (Grid Enemigo Fila 3):** tiles 37-45
- Col 0 (borde): tile_board_37.png
- Cols 1-7 (grid): tiles 38-44
- Col 8 (borde): tile_board_45.png

**Fila 5 (Grid Enemigo Fila 4):** tiles 46-54
- Col 0 (borde): tile_board_46.png
- Cols 1-7 (grid): tiles 47-53
- Col 8 (borde): tile_board_54.png

#### Filas 6-10 - Grid Aliado

**Fila 6 (Grid Aliado Fila 0):** tiles 55-63
- Col 0 (borde): tile_board_55.png
- Cols 1-7 (grid): tiles 56-62
- Col 8 (borde): tile_board_63.png

**Fila 7 (Grid Aliado Fila 1):** tiles 64-72
- Col 0 (borde): tile_board_64.png
- Cols 1-7 (grid): tiles 65-71
- Col 8 (borde): tile_board_72.png

**Fila 8 (Grid Aliado Fila 2):** tiles 73-81
- Col 0 (borde): tile_board_73.png
- Cols 1-7 (grid): tiles 74-80
- Col 8 (borde): tile_board_81.png

**Fila 9 (Grid Aliado Fila 3):** tiles 82-90
- Col 0 (borde): tile_board_82.png
- Cols 1-7 (grid): tiles 83-89
- Col 8 (borde): tile_board_90.png

**Fila 10 (Grid Aliado Fila 4):** tiles 91-99
- Col 0 (borde): tile_board_91.png
- Cols 1-7 (grid): tiles 92-98
- Col 8 (borde): tile_board_99.png

#### Fila 11 - Borde Inferior (tiles 100-108)
| Col | Tile | Descripción |
|-----|------|-------------|
| 0 | tile_board_100.png | Esquina inferior izquierda |
| 1 | tile_board_101.png | Borde inferior |
| 2 | tile_board_102.png | Borde inferior |
| 3 | tile_board_103.png | Borde inferior |
| 4 | tile_board_104.png | Borde inferior |
| 5 | tile_board_105.png | Borde inferior |
| 6 | tile_board_106.png | Borde inferior |
| 7 | tile_board_107.png | Borde inferior |
| 8 | tile_board_108.png | Esquina inferior derecha |

---

## 📍 Mapeo de Posiciones del Grid a Tiles

### Grid Enemigo
Para una posición `(col, row)` en el grid enemigo (col: 0-6, row: 0-4):
```
tile_index = ((row + 1) * 9) + (col + 1) + 1
```

**Ejemplos:**
- Grid Enemigo (0, 0) → tile_board_11.png
- Grid Enemigo (3, 2) → tile_board_32.png
- Grid Enemigo (6, 4) → tile_board_53.png

### Grid Aliado
Para una posición `(col, row)` en el grid aliado (col: 0-6, row: 0-4):
```
tile_index = ((row + 6) * 9) + (col + 1) + 1
```

**Ejemplos:**
- Grid Aliado (0, 0) → tile_board_56.png
- Grid Aliado (3, 2) → tile_board_77.png
- Grid Aliado (6, 4) → tile_board_98.png

---

## 📂 Estructura de Archivos

### Carpeta de Tiles
```
assets/sprites/arena/tiles/board/
├── tile_board_1.png
├── tile_board_2.png
├── ...
└── tile_board_108.png
```

### Notas de Importación
- Todos los tiles deben ser de **100×100 píxeles**
- Formato: **PNG**
- Puedes crear tiles gradualmente (el sistema usará fallback si faltan)
- El sistema intentará cargar tiles genéricos (1-9) si no encuentra el específico

---

## ✅ Resumen Ejecutivo

| Concepto | Valor |
|----------|-------|
| **Ancho canvas GIMP** | 900 píxeles |
| **Alto canvas GIMP** | 1,200 píxeles |
| **Total de tiles** | 108 tiles |
| **Tamaño de tile** | 100×100 píxeles |
| **Primer tile** | tile_board_1.png (esquina superior izquierda) |
| **Último tile** | tile_board_108.png (esquina inferior derecha) |
| **Carpeta** | assets/sprites/arena/tiles/board/ |

---

**Última actualización:** 26 de Diciembre 2024

