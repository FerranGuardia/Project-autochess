# 📐 Dimensiones de la Arena Completa

**Para crear un grid en GIMP y diseñar la arena completa**

---

## 📊 Dimensiones Totales

### Arena Completa (Grid + Tiles Decorativos)

- **Ancho total:** 900 píxeles
- **Alto total:** 700 píxeles

### Desglose

#### Grid de Combate (Centro)
- **Ancho:** 700px (7 columnas × 100px)
- **Alto:** 500px (5 filas × 100px)

#### Tiles Decorativos Alrededor
- **Arriba:** 7 tiles de 100×100px = 700px de ancho
- **Abajo:** 7 tiles de 100×100px = 700px de ancho
- **Izquierda:** 5 tiles de 100×100px = 500px de alto
- **Derecha:** 5 tiles de 100×100px = 500px de alto
- **Esquinas:** 4 tiles de 100×100px cada uno

#### Cálculo del Tamaño Total
- **Ancho:** 700px (grid) + 100px (izquierda) + 100px (derecha) = **900px**
- **Alto:** 500px (grid) + 100px (arriba) + 100px (abajo) = **700px**

---

## 🎨 Configuración para GIMP

### Crear Nuevo Archivo en GIMP

1. **Archivo → Nuevo**
2. Configurar:
   - **Ancho:** 900 píxeles
   - **Alto:** 700 píxeles
   - **Resolución:** 72 ppp (píxeles por pulgada)
   - **Color:** RGB
   - **Relleno:** Blanco o Transparente

### Configurar Grid en GIMP

1. **Ver → Mostrar cuadrícula** (activar)
2. **Ver → Ajustar cuadrícula...**
3. Configurar:
   - **Espaciado:** 100×100 píxeles
   - **Desplazamiento:** 0, 0

Esto te dará un grid de 9×7 celdas de 100×100px cada una.

---

## 📍 Distribución Visual

```
┌─────────────────────────────────────────────────────────┐
│ [Esquina] [Top] [Top] [Top] [Top] [Top] [Top] [Esquina] │ ← 100px
├─────────────────────────────────────────────────────────┤
│ [Left]   │ Grid de Combate 7×5 (700×500px) │ [Right]  │
│ [Left]   │                                 │ [Right]  │
│ [Left]   │                                 │ [Right]  │
│ [Left]   │                                 │ [Right]  │
│ [Left]   │                                 │ [Right]  │
├─────────────────────────────────────────────────────────┤
│ [Esquina] [Bottom][Bottom][Bottom][Bottom][Bottom][Bottom] [Esquina] │ ← 100px
└─────────────────────────────────────────────────────────┘
    100px             700px                 100px
         └─────────────────────────────────┘
                     900px total
```

---

## 🎯 Áreas de Diseño

### Zona Central (Grid de Combate)
- **Posición:** Centro del canvas
- **Tamaño:** 700×500px
- **Coordenadas en GIMP:** Desde (100, 100) hasta (800, 600)

### Zona Superior (Tiles Arriba)
- **Posición:** Arriba del grid
- **Tamaño:** 700×100px
- **Coordenadas en GIMP:** Desde (100, 0) hasta (800, 100)

### Zona Inferior (Tiles Abajo)
- **Posición:** Abajo del grid
- **Tamaño:** 700×100px
- **Coordenadas en GIMP:** Desde (100, 600) hasta (800, 700)

### Zona Izquierda (Tiles Izquierda)
- **Posición:** Izquierda del grid
- **Tamaño:** 100×500px
- **Coordenadas en GIMP:** Desde (0, 100) hasta (100, 600)

### Zona Derecha (Tiles Derecha)
- **Posición:** Derecha del grid
- **Tamaño:** 100×500px
- **Coordenadas en GIMP:** Desde (800, 100) hasta (900, 600)

### Esquinas
- **Superior Izquierda:** 0, 0 hasta 100, 100
- **Superior Derecha:** 800, 0 hasta 900, 100
- **Inferior Izquierda:** 0, 600 hasta 100, 700
- **Inferior Derecha:** 800, 600 hasta 900, 700

---

## 💡 Consejos para Diseñar en GIMP

1. **Usa capas separadas:**
   - Capa 1: Grid de combate
   - Capa 2: Tiles decorativos arriba
   - Capa 3: Tiles decorativos abajo
   - Capa 4: Tiles decorativos izquierda
   - Capa 5: Tiles decorativos derecha
   - Capa 6: Esquinas

2. **Guía visual:**
   - Dibuja líneas guía en x=100, x=800 (bordes del grid)
   - Dibuja líneas guía en y=100, y=600 (bordes del grid)

3. **Exportar tiles individuales:**
   - Una vez diseñada la arena completa, puedes exportar cada sección de 100×100px como tile individual

---

## 📝 Resumen Rápido

**Tamaño total para GIMP:**
- **900×700 píxeles**

**Grid de 100×100px:**
- **9 columnas × 7 filas**

**Zona central (grid de combate):**
- **7×5 celdas (700×500px)**

---

**¡Listo para diseñar tu arena completa! 🎨**

