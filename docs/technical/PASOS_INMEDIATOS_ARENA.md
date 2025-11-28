# 🎯 Pasos Inmediatos: Implementar Arena con Tiny Dungeons

**Guía rápida paso a paso para implementar la arena visual**

---

## ✅ Estado Actual

- ✅ Carpeta creada: `assets/sprites/arena/tiny_dungeons/`
- ✅ Tiles copiados: `tile_0000.png`, `tile_0001.png`, `tile_0002.png`
- ✅ Tilesheet copiado: `tilemap.png`

---

## 🚀 Pasos a Seguir (en orden)

### Paso 1: Generar Sprites de Arena (5 minutos)

**Opción A: Usar Script de Godot (Recomendado)**

1. **Crear script temporal** `generate_arena.gd` en la raíz del proyecto
2. **Copiar código** del archivo `SCRIPT_GENERAR_ARENA.md`
3. **Ajustar rutas** en el script si es necesario
4. **Ejecutar** desde Godot (agregar como nodo temporal o desde consola)
5. **Verificar** que se crearon:
   - `assets/sprites/arena/arena_ally.png` (700×500px)
   - `assets/sprites/arena/arena_enemy.png` (700×500px)
6. **Eliminar** el script temporal

**Opción B: Crear Manualmente (Si prefieres control total)**

1. Abrir GIMP/Photoshop
2. Crear imagen nueva: 700×500px
3. Cargar tiles de 16×16px
4. Escalar cada tile a 100×100px
5. Colocar 7×5 tiles para crear la arena
6. Guardar como PNG en `assets/sprites/arena/`

---

### Paso 2: Modificar GridAlly.gd (10 minutos)

**Cambios necesarios:**

1. **Cambiar tipo de background:**
   ```gdscript
   var background: Sprite2D  # Cambiar de Polygon2D a Sprite2D
   ```

2. **Modificar create_grid():**
   ```gdscript
   func create_grid():
       # Crear fondo de arena con sprite
       if not background:
           background = Sprite2D.new()
           background.name = "Background"
           
           var arena_texture = load("res://assets/sprites/arena/arena_ally.png")
           if arena_texture:
               background.texture = arena_texture
               background.centered = true
               
               # Escalar si es necesario (debe ser 700×500px)
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
               # Fallback: usar Polygon2D temporal
               print("Warning: No se encontró arena_ally.png")
               background = Polygon2D.new()
               background.color = Color(0.2, 0.2, 1.0, 0.25)
               # ... código de fallback
           
           background.z_index = -1  # Detrás de las unidades
           add_child(background)
       
       # ... resto del código (crear celdas, etc.)
   ```

3. **Hacer celdas invisibles:**
   ```gdscript
   func create_cell(col: int, row: int):
       # ...
       cell.color = Color(1.0, 1.0, 1.0, 0.0)  # Invisible
       # ...
   ```

---

### Paso 3: Modificar GridEnemy.gd (10 minutos)

**Mismos cambios que GridAlly, pero:**
- Usar `arena_enemy.png` en lugar de `arena_ally.png`
- Mantener colores rojos en el fallback

```gdscript
var arena_texture = load("res://assets/sprites/arena/arena_enemy.png")
```

---

### Paso 4: Probar (5 minutos)

1. **Ejecutar el juego** en Godot
2. **Verificar visualmente:**
   - ✅ La arena se muestra correctamente
   - ✅ Las celdas no son visibles (o muy sutiles)
   - ✅ El highlight aparece al hacer drag

3. **Verificar funcionalidad:**
   - ✅ Drag & drop funciona
   - ✅ Las unidades se posicionan correctamente
   - ✅ El sistema de highlight funciona

---

## 📋 Checklist Completo

### Preparación
- [ ] Tiles copiados al proyecto
- [ ] Tilesheet copiado (opcional, para referencia)

### Generación de Arena
- [ ] Script `generate_arena.gd` creado
- [ ] Script ejecutado
- [ ] `arena_ally.png` generado (700×500px)
- [ ] `arena_enemy.png` generado (700×500px)
- [ ] Script eliminado

### Implementación
- [ ] `GridAlly.gd` modificado (Sprite2D en lugar de Polygon2D)
- [ ] `GridEnemy.gd` modificado
- [ ] Celdas hechas invisibles
- [ ] Z-index configurado correctamente

### Testing
- [ ] Arena se muestra visualmente
- [ ] Drag & drop funciona
- [ ] Posicionamiento correcto
- [ ] Highlight funciona
- [ ] Sin errores en consola

---

## 🎨 Personalización Opcional

### Variar Tiles por Celda

Si quieres usar diferentes tiles en diferentes celdas:

1. **Modificar script de generación** para usar múltiples tiles
2. **Crear patrón** (ajedrez, aleatorio, etc.)
3. **Regenerar** las arenas

### Agregar Efectos Visuales

Después de la implementación básica:
- Partículas sutiles
- Animaciones de fondo
- Shaders para efectos especiales

---

## 🐛 Solución de Problemas

### Problema: La arena no se muestra
- **Solución:** Verificar que la ruta del archivo es correcta
- **Solución:** Verificar que el archivo existe y tiene el tamaño correcto
- **Solución:** Revisar consola de Godot para errores

### Problema: La arena está mal escalada
- **Solución:** Verificar que la imagen es 700×500px
- **Solución:** Ajustar el cálculo de `background.scale`

### Problema: Las unidades no se posicionan correctamente
- **Solución:** No cambiar `get_world_position()` ni `get_grid_position()`
- **Solución:** Verificar que `CELL_SIZE` sigue siendo 100

---

## 📝 Archivos a Modificar

1. **`scripts/GridAlly.gd`**
   - Cambiar `background: Polygon2D` a `background: Sprite2D`
   - Modificar `create_grid()`
   - Modificar `create_cell()` (hacer invisible)

2. **`scripts/GridEnemy.gd`**
   - Mismos cambios que GridAlly
   - Usar `arena_enemy.png`

3. **`assets/sprites/arena/`** (nuevos archivos)
   - `arena_ally.png` (generado)
   - `arena_enemy.png` (generado)

---

## ⏱️ Tiempo Estimado Total

- **Generación de arena:** 5 minutos
- **Modificar GridAlly:** 10 minutos
- **Modificar GridEnemy:** 10 minutos
- **Testing:** 5 minutos
- **Total:** ~30 minutos

---

## 🎯 Resultado Esperado

Después de completar estos pasos:
- ✅ Arena visual atractiva en lugar del grid simple
- ✅ Toda la funcionalidad del grid se mantiene
- ✅ Drag & drop funciona perfectamente
- ✅ Visualización profesional

---

**¡A implementar!** 🚀


