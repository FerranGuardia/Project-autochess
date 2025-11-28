# 📐 Dimensiones del Tablero Combinado - AutoChess

**Fecha de creación:** 26 de Diciembre 2024  
**Estado:** ✅ Definido - Tablero Simple/MVP  
**Branch:** `feature/arena-visual`

> **Nota:** Este es el tablero base simple que se está usando actualmente. Usa solo 2 sprites (tile_board_1 para bordes, tile_board_2 para interior) para simplificar la configuración. Ver `CONFIGURACION_TILES_TABLERO.md` para más detalles.

---

## 🎯 Concepto de Tablero

El **tablero** está compuesto por:
1. **Zona de Combate** (dos grids contiguos):
   - **Grid Enemigo** (superior)
   - **Grid Aliado** (inferior)
2. **Borde Decorativo** (alrededor de la zona de combate):
   - Grid puramente decorativo que establece los límites visuales del tablero

Ambos componentes están diseñados para ser visualizados como una unidad continua en GIMP.

---

## 📏 Dimensiones del Tablero

### Configuración Base
- **Tamaño de cada celda:** 100px × 100px
- **Grid Enemigo:** 7 columnas × 5 filas
- **Grid Aliado:** 7 columnas × 5 filas
- **Borde Decorativo:** 1 fila/columna alrededor de la zona de combate

### Dimensiones de la Zona de Combate

#### Ancho (Horizontal)
- **Ancho zona de combate:** 700 píxeles
- **Cálculo:** 7 columnas × 100px = 700px
- **Aplica a ambos grids:** Mismo ancho

#### Alto (Vertical)
- **Alto zona de combate:** 1,000 píxeles
- **Cálculo:** 
  - Grid Enemigo: 5 filas × 100px = 500px
  - Grid Aliado: 5 filas × 100px = 500px
  - **Total:** 500px + 500px = 1,000px

### Dimensiones del Tablero Completo (con Borde Decorativo)

#### Ancho Total
- **Ancho total:** 900 píxeles
- **Cálculo:** 700px (zona combate) + 100px (borde izquierdo) + 100px (borde derecho) = 900px
- **Columnas totales:** 9 columnas (7 de combate + 2 de borde)

#### Alto Total
- **Alto total:** 1,200 píxeles
- **Cálculo:** 1,000px (zona combate) + 100px (borde superior) + 100px (borde inferior) = 1,200px
- **Filas totales:** 12 filas (10 de combate + 2 de borde)

### Resumen Visual
```
┌─────────────────────────────────────┐
│  BORDE DECORATIVO (superior)        │  100px alto
│  9 celdas × 1 fila                  │
├─────────────────────────────────────┤
│ │                                 │ │
│ │   GRID ENEMIGO (7×5)            │ │  500px alto
│ │   700px × 500px                 │ │
│ │                                 │ │
│ ├─────────────────────────────────┤ │ ← Tocándose (0px separación)
│ │                                 │ │
│ │   GRID ALIADO (7×5)             │ │  500px alto
│ │   700px × 500px                 │ │
│ │                                 │ │
│ └─────────────────────────────────┘ │
│  BORDE DECORATIVO (inferior)        │  100px alto
│  9 celdas × 1 fila                  │
└─────────────────────────────────────┘

ZONA DE COMBATE: 700px × 1,000px
TABLERO COMPLETO: 900px × 1,200px
```

---

## 🔢 Número de Celdas de 100×100

### Cálculo por Componente

#### Zona de Combate
- **Grid Enemigo:** 7 × 5 = **35 celdas**
- **Grid Aliado:** 7 × 5 = **35 celdas**
- **Subtotal zona de combate:** 70 celdas

#### Borde Decorativo
- **Fila superior:** 9 celdas (1 fila × 9 columnas)
- **Fila inferior:** 9 celdas (1 fila × 9 columnas)
- **Columna izquierda:** 10 celdas (10 filas × 1 columna, sin contar esquinas ya contadas)
- **Columna derecha:** 10 celdas (10 filas × 1 columna, sin contar esquinas ya contadas)
- **Subtotal borde decorativo:** 9 + 9 + 10 + 10 = **38 celdas**

### Total de Celdas
- **Total zona de combate:** 70 celdas
- **Total borde decorativo:** 38 celdas
- **TOTAL GENERAL:** 70 + 38 = **108 celdas de 100×100 píxeles**

---

## 📊 Especificaciones para GIMP

### Dimensiones del Canvas del Tablero Completo
- **Ancho:** 900 píxeles (9 columnas × 100px)
- **Alto:** 1,200 píxeles (12 filas × 100px)
- **Resolución:** 100 píxeles por unidad (cada celda es 100×100)
- **Total de tiles:** 108 tiles (numerados de tile_board_1.png a tile_board_108.png)

### Sistema de Numeración
- **Formato:** `tile_board_1.png` a `tile_board_108.png`
- **Orden:** De izquierda a derecha, de arriba a abajo
- **Primer tile:** Esquina superior izquierda = `tile_board_1.png`
- **Último tile:** Esquina inferior derecha = `tile_board_108.png`
- **Carpeta:** `assets/sprites/arena/tiles/board/`

> **Ver tabla completa de mapeo:** `docs/technical/TABLA_TILES_TABLERO_COMPLETO.md`

### Estructura Visual

#### Borde Decorativo
- **Fila superior:** Y: 0px a 100px, X: 0px a 900px (9 celdas)
- **Fila inferior:** Y: 1,100px a 1,200px, X: 0px a 900px (9 celdas)
- **Columna izquierda:** Y: 100px a 1,100px, X: 0px a 100px (10 celdas)
- **Columna derecha:** Y: 100px a 1,100px, X: 800px a 900px (10 celdas)

#### Zona de Combate
- **Grid Enemigo (superior):**
  - Filas: 1 a 5 (5 filas)
  - Columnas: 1 a 7 (7 columnas)
  - Rango Y: 100px a 600px
  - Rango X: 100px a 800px

- **Grid Aliado (inferior):**
  - Filas: 6 a 10 (5 filas)
  - Columnas: 1 a 7 (7 columnas)
  - Rango Y: 600px a 1,100px
  - Rango X: 100px a 800px

### Guía de Cuadrícula en GIMP
- **Espaciado de cuadrícula:** 100px × 100px
- **Total de cuadrados:** 108 (9 columnas × 12 filas)
- **Zona de combate:** 70 cuadrados (7 columnas × 10 filas)
- **Borde decorativo:** 38 cuadrados

---

## ✅ Resumen Ejecutivo

| Concepto | Valor |
|----------|-------|
| **Ancho zona de combate** | 700 píxeles |
| **Alto zona de combate** | 1,000 píxeles |
| **Ancho tablero completo** | 900 píxeles |
| **Alto tablero completo** | 1,200 píxeles |
| **Celdas zona de combate** | 70 celdas |
| **Celdas borde decorativo** | 38 celdas |
| **Total celdas de 100×100** | 108 celdas |
| **Grid Enemigo** | 35 celdas (700×500px) |
| **Grid Aliado** | 35 celdas (700×500px) |
| **Separación entre grids** | 0px (contiguos) |
| **Borde decorativo** | 1 fila/columna alrededor |

---

## 📝 Notas para Desarrollo

- El tablero se crea como una imagen única de **900×1,200 píxeles** (incluye borde decorativo)
- La zona de combate ocupa **700×1,000 píxeles** (centrada en el tablero)
- Cada celda ocupa exactamente **100×100 píxeles**
- Los grids de combate están contiguos (sin separación visual entre ellos)
- El borde decorativo rodea completamente la zona de combate (1 celda de grosor)
- El grid enemigo está en la parte superior de la zona de combate (Y: 100-600px en el canvas)
- El grid aliado está en la parte inferior de la zona de combate (Y: 600-1,100px en el canvas)
- El borde decorativo es puramente visual y no afecta la lógica de juego

---

---

## 🪑 Posición del Banquillo

### Configuración
- **Altura del banquillo:** 100px
- **Ancho del banquillo:** 1,000px (10 slots × 100px)
- **Posición:** Centrado horizontalmente, 100px separado del borde decorativo inferior

### Cálculo de Posición
- **Borde decorativo inferior termina en:** Y = +600px (en coordenadas del mundo)
- **Separación requerida:** 100px
- **Borde superior del banquillo:** Y = +700px
- **Centro del banquillo:** Y = +750px (700px + 50px mitad del banquillo)
- **Borde inferior del banquillo:** Y = +800px

### Resumen
- **Posición del centro:** `(0, +750)` en coordenadas del mundo
- **Rango Y:** +700px a +800px
- **Rango X:** -500px a +500px (centrado)

---

**Última actualización:** 26 de Diciembre 2024

