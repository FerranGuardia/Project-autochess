# 🎨 Guía: Tiles Decorativos para la Arena

**Objetivo:** Crear tiles decorativos de 100×100px alrededor de los grids de combate para formar una arena visual completa

---

## 📐 Especificaciones

- **Tamaño de cada tile:** 100×100 píxeles
- **Formato:** PNG con transparencia (si es necesario)
- **Ubicación:** Alrededor de cada grid de combate (7×5 celdas)

---

## 🗺️ Distribución de Tiles Decorativos

Para cada grid (aliado y enemigo), se colocan tiles alrededor:

### Distribución Visual

```
[Esquina] [Top] [Top] [Top] [Top] [Top] [Top] [Esquina]
[Left]    [Grid de Combate 7×5]        [Right]
[Left]    [Grid de Combate 7×5]        [Right]
[Left]    [Grid de Combate 7×5]        [Right]
[Left]    [Grid de Combate 7×5]        [Right]
[Left]    [Grid de Combate 7×5]        [Right]
[Esquina] [Bottom][Bottom][Bottom][Bottom][Bottom][Bottom] [Esquina]
```

### Cantidad de Tiles

- **Arriba (top):** 7 tiles
- **Abajo (bottom):** 7 tiles
- **Izquierda (left):** 5 tiles
- **Derecha (right):** 5 tiles
- **Esquinas:** 4 tiles (top_left, top_right, bottom_left, bottom_right)

**Total:** 28 tiles decorativos por grid

---

## 📁 Estructura de Carpetas

```
assets/sprites/arena/decorative/
├── ally/
│   ├── decorative_ally_top_00.png
│   ├── decorative_ally_top_01.png
│   ├── decorative_ally_bottom_00.png
│   ├── decorative_ally_left_00.png
│   ├── decorative_ally_right_00.png
│   ├── decorative_ally_top_left_00.png
│   ├── decorative_ally_top_right_00.png
│   ├── decorative_ally_bottom_left_00.png
│   └── decorative_ally_bottom_right_00.png
└── enemy/
    ├── decorative_enemy_top_00.png
    ├── decorative_enemy_bottom_00.png
    └── ...
```

---

## 🎯 Convención de Nombres

### Formato General
```
decorative_[tipo]_[lado]_[índice].png
```

### Ejemplos

**Para tablero aliado:**
- `decorative_ally_top_00.png` - Primer tile arriba
- `decorative_ally_top_01.png` - Segundo tile arriba
- `decorative_ally_bottom_00.png` - Primer tile abajo
- `decorative_ally_left_00.png` - Primer tile izquierda
- `decorative_ally_right_00.png` - Primer tile derecha
- `decorative_ally_top_left_00.png` - Esquina superior izquierda
- `decorative_ally_top_right_00.png` - Esquina superior derecha
- `decorative_ally_bottom_left_00.png` - Esquina inferior izquierda
- `decorative_ally_bottom_right_00.png` - Esquina inferior derecha

**Para tablero enemigo:**
- `decorative_enemy_top_00.png` - Primer tile arriba
- `decorative_enemy_bottom_00.png` - Primer tile abajo
- etc.

---

## 🎨 Ideas de Diseño

### Para Tablero Aliado (Azul/Amigable)
- **Bordes de piedra clara**
- **Columnas decorativas**
- **Banderas o estandartes**
- **Escaleras o plataformas**
- **Elementos de defensa (muros, barricadas)**

### Para Tablero Enemigo (Rojo/Oscuro)
- **Bordes de piedra oscura**
- **Espinas o púas**
- **Fogatas o brasas**
- **Elementos agresivos**
- **Ambiente más oscuro y amenazante**

---

## 📝 Cómo Crear Tiles Decorativos

### Paso 1: Crear en GIMP

1. **Abrir GIMP**
2. **Archivo → Nuevo** (100×100 píxeles)
3. **Diseñar el tile** según el lado:
   - **Top/Bottom:** Tiles horizontales (pueden tener patrones que se repiten)
   - **Left/Right:** Tiles verticales
   - **Esquinas:** Tiles especiales que conectan los bordes

### Paso 2: Guardar

1. **Archivo → Exportar como...**
2. Nombre: `decorative_ally_top_00.png` (o el que corresponda)
3. Guardar en: `assets/sprites/arena/decorative/ally/`
4. **Exportar**

### Paso 3: Probar

1. Ejecutar el juego
2. Ver cómo se ven los tiles decorativos
3. Ajustar si es necesario

---

## 🔄 Sistema de Carga

El sistema carga tiles en este orden:

1. **Tiles específicos:** `decorative_ally_top_00.png`, `decorative_ally_top_01.png`, etc.
   - Si existen, se usan en orden

2. **Tiles genéricos:** `decorative_ally_top_00.png`
   - Si no hay tiles específicos, se repite el genérico

3. **Sin tiles:** No se muestra nada (el grid se ve sin decoración)

---

## 💡 Consejos

### Diseño
- **Consistencia:** Mantén un estilo coherente
- **Repetición:** Los tiles de top/bottom deben verse bien repetidos
- **Esquinas:** Diseña esquinas que conecten bien los bordes
- **Contraste:** Asegúrate de que el grid de combate se destaque

### Técnico
- **Tamaño exacto:** Siempre 100×100px
- **Formato PNG:** Mejor para transparencia
- **Nombres correctos:** Sigue la convención exacta
- **Ubicación correcta:** Carpeta ally/ o enemy/

### Flujo de Trabajo
- **Empieza con tiles genéricos:** Crea `decorative_ally_top_00.png` y se repetirá
- **Crea variaciones:** Una vez que te guste el estilo, crea tiles específicos
- **Prueba frecuentemente:** Ve cómo se ven en el juego
- **Itera:** Mejora basándote en cómo se ven

---

## 🎯 Ejemplo Práctico

### Crear tu Primer Tile Decorativo

1. **Abre GIMP**
2. **Crea:** 100×100px, fondo transparente
3. **Diseña:** Un borde de piedra simple para arriba
4. **Guarda:** `decorative_ally_top_00.png` en `assets/sprites/arena/decorative/ally/`
5. **Ejecuta el juego:** Verás el tile repetido 7 veces arriba del grid aliado

### Expandir Gradualmente

- Crea `decorative_ally_bottom_00.png` para abajo
- Crea `decorative_ally_left_00.png` para izquierda
- Crea `decorative_ally_right_00.png` para derecha
- Crea las 4 esquinas
- Repite para el tablero enemigo

---

## 📊 Resumen

- **28 tiles decorativos** por grid (aliado y enemigo)
- **Tiles de 100×100px** cada uno
- **Sistema flexible:** Puedes crear tiles gradualmente
- **Puramente visual:** No afectan el gameplay
- **Crea una arena completa** alrededor de los grids de combate

---

**¡Diviértete creando tu arena visual! 🎮**

