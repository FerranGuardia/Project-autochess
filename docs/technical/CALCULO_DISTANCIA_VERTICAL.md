# 📏 Cálculo de Distancia Vertical entre Grids

**Verificación de la distancia vertical desde grid enemigo hasta grid aliado**

---

## 📊 Posiciones de los Grids

### Grid Enemigo
- **Centro:** Y = -250
- **Grid de combate:** 500px de alto (5 filas × 100px)
  - Arriba del grid: -250 - 250 = **-500px**
  - Abajo del grid: -250 + 250 = **0px**

### Grid Aliado
- **Centro:** Y = 250
- **Grid de combate:** 500px de alto (5 filas × 100px)
  - Arriba del grid: 250 - 250 = **0px**
  - Abajo del grid: 250 + 250 = **500px**

---

## 🎨 Tiles Decorativos

### Grid Enemigo (con tiles decorativos)
- **Tiles arriba:** Y = top_edge - CELL_SIZE/2 = -250 - 50 = **-300px** (centro)
  - Rango: desde **-350px** hasta **-250px**
- **Tiles abajo:** Y = bottom_edge + CELL_SIZE/2 = 0 + 50 = **50px** (centro)
  - Rango: desde **0px** hasta **100px**

**Grid Enemigo completo (con tiles):**
- Desde: **-350px** (arriba con tiles)
- Hasta: **100px** (abajo con tiles)
- **Total: 450px de alto**

### Grid Aliado (con tiles decorativos)
- **Tiles arriba:** Y = top_edge - CELL_SIZE/2 = 0 - 50 = **-50px** (centro)
  - Rango: desde **-100px** hasta **0px**
- **Tiles abajo:** Y = bottom_edge + CELL_SIZE/2 = 500 + 50 = **550px** (centro)
  - Rango: desde **500px** hasta **600px**

**Grid Aliado completo (con tiles):**
- Desde: **-100px** (arriba con tiles)
- Hasta: **600px** (abajo con tiles)
- **Total: 700px de alto**

---

## ✅ Distancia Vertical Total

**Desde el borde inferior del grid enemigo hasta el borde superior del grid aliado:**

- Grid Enemigo (abajo con tiles): **100px**
- Grid Aliado (arriba con tiles): **-100px** (pero esto se solapa)

**Espera, hay un solapamiento. Déjame recalcular:**

- Grid Enemigo termina en: **100px** (borde inferior con tiles)
- Grid Aliado empieza en: **-100px** (borde superior con tiles)

**Distancia entre bordes exteriores:**
- Desde -350px (arriba grid enemigo) hasta 600px (abajo grid aliado)
- **Total vertical: 950px**

**Pero la distancia entre los grids (sin contar tiles que se solapan):**
- Grid Enemigo termina en: **0px** (borde inferior del grid)
- Grid Aliado empieza en: **0px** (borde superior del grid)
- **Distancia: 0px** (están tocándose)

**Con tiles decorativos:**
- Grid Enemigo (abajo con tiles): **100px**
- Grid Aliado (arriba con tiles): **-100px**
- **Hay solapamiento de 200px en el centro**

---

## 🎯 Respuesta a tu Pregunta

**Si contamos desde el borde superior del grid enemigo (con tiles) hasta el borde inferior del grid aliado (con tiles):**

- Desde: **-350px** (arriba grid enemigo con tiles)
- Hasta: **600px** (abajo grid aliado con tiles)
- **Total: 950px**

**Pero si solo contamos la distancia entre los grids (sin los tiles que se solapan):**

- Grid Enemigo: desde -500px hasta 0px (500px)
- Grid Aliado: desde 0px hasta 500px (500px)
- **Total: 1000px** (pero están tocándose en Y=0)

**Si contamos cada grid completo con sus tiles:**
- Grid Enemigo: 450px de alto (desde -350 hasta 100)
- Grid Aliado: 700px de alto (desde -100 hasta 600)
- **Distancia entre ellos: 0px** (se solapan en el centro)

---

## 💡 Conclusión

La distancia vertical **total** desde el grid enemigo hasta el grid aliado, contando todo:

**Desde -350px hasta 600px = 950px total**

Pero los grids en sí están separados por **0px** (se tocan en Y=0), y los tiles decorativos se solapan en el centro.

**¿Quieres que sea exactamente 700px?** Entonces necesitaríamos ajustar las posiciones.

