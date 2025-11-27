# 📐 Especificaciones del Tablero - AutoChess

**Fecha de creación:** 26 de Diciembre 2024, 10:00 AM  
**Última actualización:** 26 de Diciembre 2024, 11:30 AM  
**Estado:** Definido
provas unitarias
prova de integracio
prova end to en 
---

## 🎯 Estructura del Tablero

### Configuración
- **Resolución del juego:** 1920x1080 (Full HD)
- **Grid Enemigo:** 7 columnas × 5 filas
- **Grid Aliado:** 7 columnas × 5 filas
- **Posición:** Centrados en la escena, tocándose

---

## 📏 Referencia: Teamfight Tactics (TFT)

### ⚠️ Lo que SÉ sobre TFT:
- **Forma de celdas:** HEXÁGONOS (no cuadrados)
- **Tamaño del tablero:** 4 filas × 7 columnas por jugador (total: 28 hexágonos por jugador)
- **Dos tableros:** Uno para el jugador, otro para el enemigo, adyacentes
- **Porcentaje de pantalla:** Estimación de 65-70% (NO es un dato oficial exacto)

### ❌ Lo que NO sé (no hay datos oficiales):
- **Dimensiones exactas en píxeles** del tablero de TFT
- **Tamaño exacto de cada hexágono** en píxeles
- **Resolución específica** que usa TFT internamente
- **Porcentaje exacto** que ocupa el tablero (el 65-70% es una estimación visual)

### 🔍 Diferencia importante:
- **TFT usa:** 4 filas × 7 columnas = 28 hexágonos por jugador
- **Nuestro proyecto:** 5 filas × 7 columnas = 35 celdas cuadradas por jugador
- **TFT usa:** Hexágonos (más complejo de calcular área)
- **Nuestro proyecto:** Cuadrados (más simple)

### 📊 Cálculo para nuestro proyecto (7×5 cuadrados)

### Cálculos por Área (70% del espacio total)

**Área total de pantalla:** 1920 × 1080 = 2,073,600 px²  
**70% del área:** 1,451,520 px²  
**Total de celdas:** 7 × 5 × 2 = 70 celdas  
**Área por celda:** 1,451,520 ÷ 70 = 20,736 px²  
**Tamaño de celda (cuadrada):** √20,736 = **144px × 144px**

**Con este tamaño:**
- **Ancho total:** 7 × 144 = 1,008px (52.5% del ancho)
- **Alto total:** 10 × 144 = 1,440px (133% del alto) ❌ **NO CABE**

### Cálculo por Altura (70% de altura)

**Altura total:** 1080px  
**70% de altura:** 756px  
**Total de filas:** 10 filas (5 enemigo + 5 aliado)  
**Altura por fila:** 756 ÷ 10 = **75.6px** → **76px por celda**

**Con este tamaño:**
- **Ancho total:** 7 × 76 = 532px (27.7% del ancho) ⚠️ **MUY PEQUEÑO**
- **Alto total:** 10 × 76 = 760px (70.4% del alto) ✅

### Cálculo Balanceado (Considerando ambos ejes)

**Objetivo:** Ocupar ~70% del espacio visual, balanceando altura y ancho

**Opción A: 90px por celda**
- **Ancho total:** 7 × 90 = 630px (32.8% del ancho)
- **Alto total:** 10 × 90 = 900px (83.3% del alto)
- **Área ocupada:** 630 × 900 = 567,000 px² (27.3% del área total)
- **Proporción visual:** ~60-65% del espacio central

**Opción B: 100px por celda**
- **Ancho total:** 7 × 100 = 700px (36.5% del ancho)
- **Alto total:** 10 × 100 = 1,000px (92.6% del alto)
- **Área ocupada:** 700 × 1,000 = 700,000 px² (33.7% del área total)
- **Proporción visual:** ~70-75% del espacio central ✅

**Opción C: 110px por celda**
- **Ancho total:** 7 × 110 = 770px (40.1% del ancho)
- **Alto total:** 10 × 110 = 1,100px (101.9% del alto) ❌ **NO CABE**

### 📊 Recomendación Final

**Tamaño de celda: 100px × 100px**

**Razones:**
- ✅ Ocupa ~70% de la altura de la pantalla (1,000px de 1,080px)
- ✅ Proporción visual similar a TFT
- ✅ Tamaño adecuado para ver unidades y detalles
- ✅ Deja espacio para UI superior e inferior
- ✅ Cabe perfectamente en 1920×1080

**Dimensiones finales:**
- **Cada grid:** 700px (ancho) × 500px (alto)
- **Tablero completo:** 700px (ancho) × 1,000px (alto)
- **Grid Enemigo (arriba):** Centro en Y = -250px
- **Grid Aliado (abajo):** Centro en Y = +250px
- **Separación entre grids:** 0px (tocándose)

---

## 📍 Posicionamiento en Coordenadas del Mundo

### Sistema de Coordenadas
- **Origen (0, 0):** Centro de la pantalla
- **Eje X:** Positivo = derecha, Negativo = izquierda
- **Eje Y:** Positivo = abajo, Negativo = arriba

### Grid Enemigo (Arriba)
- **Posición del centro:** (0, -250) [para celdas de 100px]
- **Rango X:** -350 a +350 píxeles
- **Rango Y:** -500 a 0 píxeles
- **Celda (0,0) del grid:** Esquina superior izquierda en (-350, -500)

### Grid Aliado (Abajo)
- **Posición del centro:** (0, +250) [para celdas de 100px]
- **Rango X:** -350 a +350 píxeles
- **Rango Y:** 0 a +500 píxeles
- **Celda (0,0) del grid:** Esquina superior izquierda en (-350, 0)

---

## 🎨 Visualización

### Colores Propuestos
- **Grid Enemigo:** Fondo rojo semitransparente (alpha 0.2-0.3)
- **Grid Aliado:** Fondo azul semitransparente (alpha 0.2-0.3)
- **Líneas del grid:** Gris claro (alpha 0.5-0.7)
- **Grosor de líneas:** 2-3 píxeles

### Estructura Visual
- Cada celda debe ser claramente visible
- Bordes entre celdas bien definidos
- Los dos grids deben diferenciarse visualmente

---

## ✅ Decisión Final

**Tamaño de celda seleccionado:** 100px × 100px (temporal, ajustable)

---

## 🗺️ Layout Completo del Tablero (Estructura TFT)

### Distribución Vertical (1920×1080)

```
┌─────────────────────────────────────────┐
│  UI SUPERIOR (Oro, Vida, Ronda)        │ ~80px altura
├─────────────────────────────────────────┤
│                                         │
│      GRID ENEMIGO (7×5)                 │ 500px altura
│      Centro: Y = -250px                 │
│                                         │
├─────────────────────────────────────────┤ ← Tocándose
│                                         │
│      GRID ALIADO (7×5)                  │ 500px altura
│      Centro: Y = +250px                 │
│                                         │
├─────────────────────────────────────────┤
│                                         │
│      BANQUILLO ALIADO (10 slots)        │ ~100px altura
│      Centro: Y = +610px                 │ ✅ **ACTUALIZADO**
│                                         │
├─────────────────────────────────────────┤
│  UI INFERIOR (Tienda, Items, etc.)      │ ~150px altura
└─────────────────────────────────────────┘
```

### Componentes del Layout

#### 1. UI Superior (Futuro)
- **Posición:** Y = -490px a -410px
- **Componentes:**
  - Oro del jugador
  - Vida/HP
  - Ronda actual
  - Temporizador
- **Altura reservada:** ~80px

#### 2. Grid Enemigo
- **Tamaño:** 7 columnas × 5 filas = 35 celdas
- **Dimensiones:** 700px (ancho) × 500px (alto)
- **Posición del centro:** (0, -250px)
- **Rango Y:** -500px a 0px
- **Color:** Rojo semitransparente (alpha 0.2-0.3)

#### 3. Grid Aliado
- **Tamaño:** 7 columnas × 5 filas = 35 celdas
- **Dimensiones:** 700px (ancho) × 500px (alto)
- **Posición del centro:** (0, +250px)
- **Rango Y:** 0px a +500px
- **Color:** Azul semitransparente (alpha 0.2-0.3)
- **Separación con grid enemigo:** 0px (tocándose)

#### 4. Banquillo Aliado
- **Tamaño:** 10 slots horizontales
- **Dimensiones:** 1000px (ancho) × 100px (alto)
- **Posición del centro:** (0, +610px) ✅ **ACTUALIZADO**
- **Rango Y:** +560px a +660px
- **Tamaño de slot:** 100px × 100px
- **Separación entre slots:** 0px (tocándose)
- **Separación con grid aliado:** ~110px (aproximadamente 2 celdas) ✅ **ACTUALIZADO**

#### 5. UI Inferior (Futuro)
- **Posición:** Y = +470px a +540px
- **Componentes:**
  - Tienda (5 unidades disponibles)
  - Items/Equipamiento
  - Botones de acción
- **Altura reservada:** ~150px

### Espacios Laterales

**Ancho total de pantalla:** 1920px  
**Ancho ocupado por grids:** 700px  
**Espacio lateral disponible:** (1920 - 700) / 2 = 610px por lado

**Uso del espacio lateral (futuro):**
- **Lado izquierdo:** Información de unidades, sinergias
- **Lado derecho:** Estadísticas, log de combate, opciones

---

## 📍 Coordenadas Detalladas (100px por celda)

### Grid Enemigo
- **Centro:** (0, -250)
- **Esquina superior izquierda:** (-350, -500)
- **Esquina inferior derecha:** (+350, 0)
- **Celda (0,0) del grid:** (-350, -500)
- **Celda (6,4) del grid:** (+300, -100)

### Grid Aliado
- **Centro:** (0, +250)
- **Esquina superior izquierda:** (-350, 0)
- **Esquina inferior derecha:** (+350, +500)
- **Celda (0,0) del grid:** (-350, 0)
- **Celda (6,4) del grid:** (+300, +400)

### Banquillo
- **Centro:** (0, +610) ✅ **ACTUALIZADO**
- **Slot 0 (izquierda):** (-450, +560)
- **Slot 9 (derecha):** (+450, +560)
- **Ancho total:** 1000px (10 slots × 100px)
- **Cada slot:** 100px × 100px

---

**Nota:** Este layout está listo para implementación en Godot. Los tamaños son ajustables según necesidad visual.

