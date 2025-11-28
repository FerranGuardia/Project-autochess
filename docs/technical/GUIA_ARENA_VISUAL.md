# 🎨 Guía: Crear Arena Visual para AutoChess

**Fecha de creación:** 26 de Diciembre 2024  
**Estado:** Guía de implementación

---

## 🎯 Objetivo

Reemplazar el grid visual actual (Polygon2D con colores semitransparentes) por una arena visual atractiva, manteniendo toda la funcionalidad del sistema de grid lógico.

---

## 📋 Opciones de Implementación

### ✅ Opción 1: Sprite de Fondo de Arena (RECOMENDADA para empezar)

**Ventajas:**
- ✅ Implementación rápida (30-60 minutos)
- ✅ Mantiene toda la funcionalidad actual
- ✅ Fácil de iterar y mejorar
- ✅ Permite usar una imagen completa de arena

**Desventajas:**
- ⚠️ Menos flexibilidad para variaciones por celda
- ⚠️ Requiere una imagen de arena bien diseñada

**Implementación:**
1. Crear/obtener sprite de arena (700×500px para cada grid, o 700×1000px para ambos)
2. Reemplazar `Polygon2D` background por `Sprite2D` o `ColorRect` con textura
3. Hacer celdas invisibles o muy sutiles (solo bordes al hacer hover)
4. Mantener toda la lógica de posicionamiento

---

### ✅ Opción 2: TileMap de Arena

**Ventajas:**
- ✅ Muy escalable y fácil de variar
- ✅ Permite diferentes tiles por celda
- ✅ Sistema nativo de Godot optimizado

**Desventajas:**
- ⚠️ Requiere crear tileset de arena
- ⚠️ Más complejo de configurar inicialmente

**Implementación:**
1. Crear TileSet con tiles de arena (piedra, hierba, etc.)
2. Crear TileMap con 7×5 celdas
3. Mantener grid lógico invisible
4. Usar TileMap solo para visualización

---

### ✅ Opción 3: Sprites Individuales por Celda

**Ventajas:**
- ✅ Control total sobre cada celda
- ✅ Fácil agregar efectos visuales por celda
- ✅ Permite variaciones sutiles

**Desventajas:**
- ⚠️ Más nodos en la escena (35 sprites por grid)
- ⚠️ Requiere más assets (tiles de suelo)

**Implementación:**
1. Crear tiles de suelo (100×100px cada uno)
2. Reemplazar cada `Polygon2D` por `Sprite2D`
3. Mantener sistema de bordes/highlight

---

## 🎨 Recomendación: Enfoque Híbrido (Mejor de todos)

**Combinar:**
- **Fondo de arena:** Sprite2D grande con textura de arena completa
- **Celdas sutiles:** Sprites pequeños o tiles solo para marcar posiciones (opcional)
- **Bordes de highlight:** Mantener solo cuando se hace drag & drop

**Ventajas:**
- ✅ Visualmente atractivo
- ✅ Mantiene funcionalidad
- ✅ Flexible para mejoras futuras

---

## 📐 Dimensiones Necesarias

### Para cada Grid (7×5 celdas)
- **Tamaño:** 700px (ancho) × 500px (alto)
- **Resolución recomendada:** 1400×1000px (2x para pantallas de alta resolución)
- **Formato:** PNG con transparencia (si es necesario)

### Para Arena Completa (ambos grids)
- **Tamaño:** 700px (ancho) × 1000px (alto)
- **Resolución recomendada:** 1400×2000px (2x)

### Para Tiles Individuales
- **Tamaño:** 100×100px cada tile
- **Resolución recomendada:** 200×200px (2x)

---

## 🛠️ Implementación Paso a Paso (Opción 1: Sprite de Fondo)

### Paso 1: Preparar Assets

1. **Crear/obtener sprite de arena:**
   - Opción A: Diseñar en herramienta gráfica (Photoshop, GIMP, Aseprite)
   - Opción B: Usar assets gratuitos (Kenney.nl, OpenGameArt.org)
   - Opción C: Generar proceduralmente con shaders (avanzado)

2. **Guardar en:** `assets/sprites/arena/`
   - `arena_ally.png` - Arena para grid aliado
   - `arena_enemy.png` - Arena para grid enemigo
   - O `arena_complete.png` - Arena completa para ambos

### Paso 2: Modificar GridAlly.gd

**Cambios necesarios:**
```gdscript
# En lugar de Polygon2D, usar Sprite2D
var background: Sprite2D  # Cambiar de Polygon2D a Sprite2D

func create_grid():
    # Crear fondo con sprite
    if not background:
        background = Sprite2D.new()
        background.name = "Background"
        background.texture = load("res://assets/sprites/arena/arena_ally.png")
        background.centered = true
        background.scale = Vector2(700.0 / background.texture.get_width(), 
                                   500.0 / background.texture.get_height())
        add_child(background)
    
    # Hacer celdas invisibles o muy sutiles
    # ... resto del código
```

### Paso 3: Modificar GridEnemy.gd

**Mismos cambios que GridAlly, pero con arena_enemy.png**

### Paso 4: Ajustar Celdas (Opcional)

**Opciones:**
- **A:** Hacer celdas completamente invisibles (solo aparecen en hover)
- **B:** Hacer celdas muy sutiles (alpha 0.05-0.1)
- **C:** Usar sprites de tiles sutiles en lugar de Polygon2D

---

## 🎨 Ideas de Diseño de Arena

### Tema Medieval/Fantasy
- Suelo de piedra con grietas
- Bordes de arena con hierba
- Detalles de batalla (huellas, manchas)

### Tema Moderno/Futurista
- Suelo de metal/tecnológico
- Líneas de energía sutiles
- Efectos de luz

### Tema Neutral
- Suelo de arena/arena de combate
- Bordes simples pero elegantes
- Colores neutros que no compiten con unidades

---

## 🔧 Código de Ejemplo: Implementación Básica

### GridAlly.gd - Modificación del Background

```gdscript
func create_grid():
    """Crea el grid visual de 7×5 celdas con arena"""
    # Crear fondo de arena con sprite
    if not background:
        background = Sprite2D.new()
        background.name = "Background"
        
        # Cargar textura de arena
        var arena_texture = load("res://assets/sprites/arena/arena_ally.png")
        if arena_texture:
            background.texture = arena_texture
            background.centered = true
            
            # Escalar para que coincida con el tamaño del grid
            var grid_width = float(COLUMNS * CELL_SIZE)
            var grid_height = float(ROWS * CELL_SIZE)
            var tex_width = arena_texture.get_width()
            var tex_height = arena_texture.get_height()
            
            background.scale = Vector2(
                grid_width / tex_width,
                grid_height / tex_height
            )
        else:
            # Fallback: usar color si no hay textura
            print("Warning: No se encontró textura de arena, usando color de fondo")
            background = Polygon2D.new()
            background.color = Color(0.2, 0.2, 1.0, 0.25)
            var width = float(COLUMNS * CELL_SIZE)
            var height = float(ROWS * CELL_SIZE)
            background.polygon = PackedVector2Array([
                Vector2(-width / 2.0, -height / 2.0),
                Vector2(width / 2.0, -height / 2.0),
                Vector2(width / 2.0, height / 2.0),
                Vector2(-width / 2.0, height / 2.0)
            ])
        
        add_child(background)
    
    # Crear contenedor de celdas si no existe
    if not cells_container:
        cells_container = Node2D.new()
        cells_container.name = "CellsContainer"
        add_child(cells_container)
    
    # Crear celdas (ahora invisibles o muy sutiles)
    for row in range(ROWS):
        for col in range(COLUMNS):
            create_cell(col, row)
```

### Modificar create_cell() para celdas sutiles

```gdscript
func create_cell(col: int, row: int):
    """Crea una celda individual - ahora muy sutil o invisible"""
    var cell = Polygon2D.new()
    cell.name = "Cell_%d_%d" % [col, row]
    
    # Tamaño y posición de la celda
    var x = (float(col) - float(COLUMNS) / 2.0 + 0.5) * float(CELL_SIZE)
    var y = (float(row) - float(ROWS) / 2.0 + 0.5) * float(CELL_SIZE)
    var pos = Vector2(x - float(CELL_SIZE) / 2.0, y - float(CELL_SIZE) / 2.0)
    
    # Celda invisible o muy sutil
    cell.color = Color(1.0, 1.0, 1.0, 0.0)  # Completamente invisible
    # O muy sutil: Color(1.0, 1.0, 1.0, 0.05)
    
    var cell_size_float = float(CELL_SIZE)
    cell.polygon = PackedVector2Array([
        pos,
        pos + Vector2(cell_size_float, 0),
        pos + Vector2(cell_size_float, cell_size_float),
        pos + Vector2(0, cell_size_float)
    ])
    
    # Bordes solo visibles en hover (crear solo cuando sea necesario)
    # No crear bordes por defecto, solo en highlight
    
    cells_container.add_child(cell)
    cells.append(cell)
```

---

## 📦 Recursos Recomendados

### Assets Gratuitos
- **Kenney.nl** - Tilesets de arena/combate gratuitos
- **OpenGameArt.org** - Assets de dominio público
- **itch.io** - Assets gratuitos y de pago

### Herramientas de Diseño
- **Aseprite** - Para sprites pixel art
- **GIMP/Photoshop** - Para diseño general
- **Tiled** - Para crear tilesets

---

## ✅ Checklist de Implementación

- [ ] Crear/obtener sprites de arena
- [ ] Guardar en `assets/sprites/arena/`
- [ ] Modificar `GridAlly.gd` para usar Sprite2D
- [ ] Modificar `GridEnemy.gd` para usar Sprite2D
- [ ] Hacer celdas invisibles o muy sutiles
- [ ] Probar drag & drop (debe seguir funcionando)
- [ ] Ajustar escala si es necesario
- [ ] Probar en diferentes resoluciones

---

## 🚀 Próximos Pasos (Mejoras Futuras)

1. **Efectos visuales:**
   - Partículas en la arena
   - Animaciones sutiles
   - Shaders para efectos especiales

2. **Variaciones:**
   - Diferentes arenas por ronda
   - Efectos según el estado del combate

3. **Optimización:**
   - Usar TileMap si se necesita más variación
   - Optimizar texturas para mejor rendimiento

---

## 📝 Notas Importantes

- **Mantener la lógica del grid:** No cambiar `get_world_position()` ni `get_grid_position()`
- **Z-index:** Asegurar que el fondo esté detrás de las unidades
- **Escalado:** Usar `scale` en lugar de cambiar el tamaño del sprite para mantener calidad
- **Performance:** Sprites grandes son más eficientes que muchos sprites pequeños

---

**Última actualización:** 26 de Diciembre 2024


