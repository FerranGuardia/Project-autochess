# 🎨 Guía: Crear Tiles para el Tablero en GIMP

**Objetivo:** Crear tiles personalizados de 100×100px para el tablero del juego

---

## 📐 Especificaciones Técnicas

- **Tamaño de cada tile:** 100×100 píxeles
- **Formato:** PNG con transparencia (si es necesario)
- **Grid del tablero:** 7 columnas × 5 filas = 35 tiles por tablero
- **Tableros:** 2 (aliado y enemigo) = 70 tiles en total

---

## 🎯 Paso 1: Configurar GIMP

### 1.1 Crear un Nuevo Archivo

1. Abre GIMP
2. **Archivo → Nuevo** (o `Ctrl+N`)
3. Configura:
   - **Ancho:** 100 píxeles
   - **Altura:** 100 píxeles
   - **Resolución X:** 72 ppp (píxeles por pulgada)
   - **Resolución Y:** 72 ppp
   - **Color:** RGB
   - **Relleno:** Transparente (si quieres fondo transparente) o Blanco

4. Haz clic en **Aceptar**

### 1.2 Configurar la Vista

- **Ver → Zoom → Ajustar ventana a imagen** (o `Ctrl+Shift+E`)
- **Ver → Mostrar cuadrícula** (opcional, ayuda para alinear)
- **Ver → Ajustar cuadrícula...** → Configurar a 10×10 píxeles (ayuda para ver divisiones)

---

## 🎨 Paso 2: Diseñar tu Primer Tile

### 2.1 Ideas de Diseño

**Para tablero aliado (azul/amigable):**
- Suelo de piedra clara
- Suelo de hierba
- Suelo de madera
- Patrones geométricos simples
- Colores: Azules, verdes, blancos

**Para tablero enemigo (rojo/oscuro):**
- Suelo de piedra oscura
- Suelo de lava
- Suelo de tierra
- Patrones más agresivos
- Colores: Rojos, negros, grises oscuros

### 2.2 Herramientas Útiles en GIMP

- **Pincel (P):** Para dibujar a mano
- **Cubo de pintura (Shift+B):** Para rellenar áreas
- **Gradiente (L):** Para crear degradados
- **Selección rectangular (R):** Para seleccionar áreas
- **Texto (T):** Para agregar texto (si es necesario)

### 2.3 Crear un Tile Básico

**Ejemplo: Tile de piedra simple**

1. **Rellenar fondo:**
   - Selecciona la herramienta **Cubo de pintura**
   - Elige un color base (ej: gris claro #CCCCCC)
   - Haz clic en el canvas para rellenar

2. **Agregar textura:**
   - Usa el **Pincel** con un color más oscuro
   - Dibuja líneas o puntos para simular textura de piedra
   - Usa diferentes opacidades para profundidad

3. **Agregar bordes (opcional):**
   - Usa la herramienta **Lápiz** o **Pincel**
   - Dibuja un borde sutil alrededor del tile

---

## 💾 Paso 3: Guardar el Tile

### 3.1 Exportar como PNG

1. **Archivo → Exportar como...** (o `Ctrl+Shift+E`)
2. Navega a: `assets/sprites/arena/tiles/`
3. Nombre del archivo: `tile_ally_00.png` (para el primer tile aliado)
4. Haz clic en **Exportar**
5. En la ventana de opciones PNG:
   - ✅ **Guardar color de fondo** (si no usas transparencia)
   - ✅ **Guardar valores de transparencia** (si usas transparencia)
   - **Nivel de compresión:** 6 (balance entre calidad y tamaño)
6. Haz clic en **Exportar**

### 3.2 Convención de Nombres

**Para tablero aliado:**
- `tile_ally_00.png` - Primer tile
- `tile_ally_01.png` - Segundo tile
- `tile_ally_02.png` - Tercer tile
- etc.

**Para tablero enemigo:**
- `tile_enemy_00.png` - Primer tile
- `tile_enemy_01.png` - Segundo tile
- `tile_enemy_02.png` - Tercer tile
- etc.

---

## 🔄 Paso 4: Crear Variaciones

### 4.1 Crear Múltiples Tiles

**Opción A: Crear desde cero cada uno**
- Diseña cada tile individualmente
- Más trabajo pero más control

**Opción B: Usar el tile base y modificar**
1. **Archivo → Abrir como capas...**
2. Selecciona tu tile anterior
3. Modifica colores, texturas, etc.
4. Exporta como nuevo archivo

**Opción C: Usar capas para variaciones**
1. Crea un tile base
2. Duplica la capa
3. Modifica la capa duplicada (colores, filtros, etc.)
4. Exporta cada variación

### 4.2 Consejos para Variaciones

- **Cambiar colores:** Herramientas → Color → Tono-Saturación
- **Agregar ruido:** Filtros → Ruido → RGB Noise
- **Invertir colores:** Colores → Invertir
- **Ajustar brillo:** Colores → Brillo-Contraste

---

## 📁 Paso 5: Organizar los Tiles

### 5.1 Estructura de Carpetas

```
assets/sprites/arena/
├── tiles/
│   ├── ally/
│   │   ├── tile_ally_00.png
│   │   ├── tile_ally_01.png
│   │   └── ...
│   └── enemy/
│       ├── tile_enemy_00.png
│       ├── tile_enemy_01.png
│       └── ...
```

### 5.2 Crear las Carpetas

En GIMP o en el explorador de archivos:
1. Crea: `assets/sprites/arena/tiles/`
2. Crea: `assets/sprites/arena/tiles/ally/`
3. Crea: `assets/sprites/arena/tiles/enemy/`

---

## 🎮 Paso 6: Colocar Tiles en el Tablero

Una vez que tengas tus tiles creados, el sistema del juego los colocará automáticamente en el grid. Solo necesitas:

1. Guardar los tiles en las carpetas correctas
2. El código cargará cada tile y lo colocará en su posición

**Nota:** El sistema está diseñado para que puedas crear tiles gradualmente. Puedes empezar con 1-2 tiles y el juego los repetirá, o crear 35 tiles únicos para cada tablero.

---

## 💡 Consejos y Trucos

### Diseño
- **Mantén consistencia:** Usa una paleta de colores coherente
- **Simplicidad:** Tiles simples se ven mejor en juegos
- **Contraste:** Asegúrate de que las unidades se vean sobre los tiles
- **Bordes sutiles:** Ayudan a definir las celdas sin ser intrusivos

### Técnico
- **Tamaño exacto:** Siempre 100×100px (no 99 o 101)
- **Formato PNG:** Mejor para transparencia y calidad
- **Optimización:** No uses compresión excesiva
- **Nombres claros:** Facilita encontrar tiles específicos

### Flujo de Trabajo
- **Crea un tile base primero:** Úsalo como referencia
- **Haz variaciones sistemáticamente:** No mezcles estilos
- **Prueba en el juego:** Ve cómo se ven antes de crear muchos
- **Guarda versiones:** Por si quieres volver atrás

---

## 🎯 Checklist para Cada Tile

Antes de guardar, verifica:

- [ ] Tamaño: 100×100 píxeles exactos
- [ ] Formato: PNG
- [ ] Nombre: Sigue la convención (tile_ally_XX.png)
- [ ] Ubicación: Carpeta correcta (ally/ o enemy/)
- [ ] Calidad: Se ve bien en el juego
- [ ] Consistencia: Coincide con otros tiles del mismo tipo

---

## 🚀 Siguiente Paso

Una vez que tengas algunos tiles creados, el sistema del juego los cargará automáticamente. Puedes crear tiles gradualmente:

1. **Empieza con 1-2 tiles** para cada tablero
2. **Prueba en el juego** para ver cómo se ven
3. **Crea más tiles** según necesites
4. **Ajusta el diseño** basándote en cómo se ven en el juego

---

**¡Diviértete creando tus tiles! 🎨**

