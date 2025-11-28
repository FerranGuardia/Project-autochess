# 🎨 Implementación Paso a Paso: Arena Visual

**Guía práctica para reemplazar el grid por una arena visual**

---

## 🎯 Plan de Implementación

### Fase 1: Preparación (5 minutos)
1. Crear carpeta para assets de arena
2. Preparar sprites de arena (o usar placeholders temporales)

### Fase 2: Modificar GridAlly (15 minutos)
1. Cambiar background de Polygon2D a Sprite2D
2. Hacer celdas invisibles o muy sutiles
3. Mantener sistema de highlight

### Fase 3: Modificar GridEnemy (15 minutos)
1. Mismos cambios que GridAlly
2. Usar sprite diferente para diferenciar

### Fase 4: Testing (10 minutos)
1. Verificar que drag & drop funciona
2. Verificar que posicionamiento es correcto
3. Ajustar escalas si es necesario

**Tiempo total estimado: 45 minutos**

---

## 📁 Estructura de Carpetas

```
assets/
  sprites/
    arena/
      arena_ally.png      # Arena para grid aliado (700×500px)
      arena_enemy.png     # Arena para grid enemigo (700×500px)
      arena_placeholder.png  # Placeholder temporal (opcional)
```

---

## 🛠️ Paso 1: Crear Assets Temporales (Si no tienes sprites)

Si no tienes sprites de arena todavía, puedes:

### Opción A: Usar ColorRect temporal
- Crear un ColorRect con gradiente o color sólido
- Reemplazar después con sprite real

### Opción B: Generar sprite simple programáticamente
- Usar Godot para generar un sprite básico
- O usar un generador online

### Opción C: Descargar assets gratuitos
- **Kenney.nl** → Buscar "Arena" o "Battle"
- **OpenGameArt.org** → Buscar "arena" o "battlefield"
- **itch.io** → Assets gratuitos de arena

---

## 🔧 Paso 2: Modificar GridAlly.gd

### Cambios en create_grid()

**ANTES:**
```gdscript
func create_grid():
    # Crear fondo del grid
    if not background:
        background = Polygon2D.new()
        background.name = "Background"
        background.color = Color(0.2, 0.2, 1.0, 0.25)  # Azul semitransparente
        # ... resto del código
```

**DESPUÉS:**
```gdscript
func create_grid():
    # Crear fondo de arena con sprite
    if not background:
        background = Sprite2D.new()
        background.name = "Background"
        
        # Intentar cargar textura de arena
        var arena_path = "res://assets/sprites/arena/arena_ally.png"
        var arena_texture = load(arena_path)
        
        if arena_texture:
            background.texture = arena_texture
            background.centered = true
            
            # Escalar para que coincida con el tamaño del grid (700×500px)
            var grid_width = float(COLUMNS * CELL_SIZE)  # 700px
            var grid_height = float(ROWS * CELL_SIZE)    # 500px
            var tex_width = arena_texture.get_width()
            var tex_height = arena_texture.get_height()
            
            if tex_width > 0 and tex_height > 0:
                background.scale = Vector2(
                    grid_width / tex_width,
                    grid_height / tex_height
                )
        else:
            # Fallback: usar Polygon2D con color si no hay textura
            print("Warning: No se encontró textura de arena en ", arena_path)
            print("Usando color de fondo temporal. Crea el sprite para mejor visualización.")
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
    
    # ... resto del código (crear celdas, etc.)
```

### Cambios en create_cell() - Hacer celdas invisibles

**ANTES:**
```gdscript
func create_cell(col: int, row: int):
    # ...
    cell.color = Color(0.3, 0.3, 1.0, 0.1)  # Azul muy transparente
    # ...
```

**DESPUÉS:**
```gdscript
func create_cell(col: int, row: int):
    """Crea una celda individual - ahora invisible (solo para lógica)"""
    var cell = Polygon2D.new()
    cell.name = "Cell_%d_%d" % [col, row]
    
    # Tamaño y posición de la celda
    var x = (float(col) - float(COLUMNS) / 2.0 + 0.5) * float(CELL_SIZE)
    var y = (float(row) - float(ROWS) / 2.0 + 0.5) * float(CELL_SIZE)
    var pos = Vector2(x - float(CELL_SIZE) / 2.0, y - float(CELL_SIZE) / 2.0)
    
    # Celda completamente invisible (solo existe para lógica de posicionamiento)
    cell.color = Color(1.0, 1.0, 1.0, 0.0)  # Alpha = 0 (invisible)
    
    var cell_size_float = float(CELL_SIZE)
    cell.polygon = PackedVector2Array([
        pos,
        pos + Vector2(cell_size_float, 0),
        pos + Vector2(cell_size_float, cell_size_float),
        pos + Vector2(0, cell_size_float)
    ])
    
    # NO crear bordes por defecto (solo aparecerán en highlight durante drag)
    # Los bordes se crean dinámicamente en update_highlight_cell()
    
    cells_container.add_child(cell)
    cells.append(cell)
```

### Cambios en create_cell_border() - Solo crear cuando sea necesario

**OPCIÓN:** Eliminar la creación automática de bordes, solo crear en highlight.

O mantener pero hacerlos muy sutiles:

```gdscript
func create_cell_border(pos: Vector2, size: Vector2) -> Line2D:
    """Crea el borde visual de una celda - ahora muy sutil"""
    var border = Line2D.new()
    border.width = 1.0  # Más delgado
    border.default_color = Color(1.0, 1.0, 1.0, 0.1)  # Muy transparente
    
    # Crear rectángulo con líneas
    var points = PackedVector2Array([
        pos,
        pos + Vector2(size.x, 0),
        pos + size,
        pos + Vector2(0, size.y),
        pos  # Cerrar el rectángulo
    ])
    border.points = points
    
    return border
```

---

## 🔧 Paso 3: Modificar GridEnemy.gd

**Mismos cambios que GridAlly, pero:**
- Usar `arena_enemy.png` en lugar de `arena_ally.png`
- Mantener colores rojos en el fallback si no hay sprite

```gdscript
var arena_path = "res://assets/sprites/arena/arena_enemy.png"
# ... resto igual
```

---

## ✅ Paso 4: Verificar Funcionalidad

### Checklist de Testing

1. **Visual:**
   - [ ] La arena se muestra correctamente
   - [ ] Las celdas no son visibles (o muy sutiles)
   - [ ] El highlight aparece al hacer drag

2. **Funcionalidad:**
   - [ ] Drag & drop funciona correctamente
   - [ ] Las unidades se posicionan en el centro de las celdas
   - [ ] El sistema de highlight muestra verde/rojo correctamente

3. **Performance:**
   - [ ] No hay lag al mover unidades
   - [ ] La arena se carga rápidamente

---

## 🎨 Mejoras Opcionales

### 1. Agregar Efectos Visuales Sutiles

```gdscript
# En create_grid(), después de crear el background
if background is Sprite2D:
    # Agregar shader sutil (opcional)
    # O agregar partículas sutiles
    pass
```

### 2. Diferentes Arenas por Ronda

```gdscript
func set_arena_variant(variant: int):
    """Cambia la arena según la ronda"""
    var arena_paths = [
        "res://assets/sprites/arena/arena_ally.png",
        "res://assets/sprites/arena/arena_ally_2.png",
        "res://assets/sprites/arena/arena_ally_3.png"
    ]
    if variant < arena_paths.size():
        var texture = load(arena_paths[variant])
        if texture and background is Sprite2D:
            background.texture = texture
```

### 3. Animación Sutil de la Arena

```gdscript
# Agregar animación muy sutil (opcional)
func _process(delta):
    if background is Sprite2D:
        # Efecto de respiración muy sutil
        var time = Time.get_ticks_msec() / 1000.0
        background.modulate = Color(1.0, 1.0, 1.0, 0.98 + sin(time * 0.5) * 0.02)
```

---

## 🐛 Solución de Problemas

### Problema: La arena no se muestra
- **Solución:** Verificar que la ruta del archivo es correcta
- **Solución:** Verificar que el archivo existe en el proyecto
- **Solución:** Verificar que el formato es PNG o JPG válido

### Problema: La arena está mal escalada
- **Solución:** Ajustar el cálculo de `background.scale`
- **Solución:** Verificar dimensiones del sprite (debe ser 700×500px o múltiplo)

### Problema: Las unidades no se posicionan correctamente
- **Solución:** No cambiar `get_world_position()` ni `get_grid_position()`
- **Solución:** Verificar que `CELL_SIZE` sigue siendo 100

### Problema: El highlight no aparece
- **Solución:** Verificar que `update_highlight_cell()` sigue funcionando
- **Solución:** Los bordes se crean dinámicamente, no deberían afectarse

---

## 📝 Notas Finales

- **Mantener la lógica:** No cambiar funciones de posicionamiento
- **Z-index:** El fondo debe estar detrás de las unidades (z_index = -1)
- **Performance:** Un sprite grande es más eficiente que muchos pequeños
- **Iteración:** Empieza simple, mejora después

---

**¡Listo para implementar!** 🚀


