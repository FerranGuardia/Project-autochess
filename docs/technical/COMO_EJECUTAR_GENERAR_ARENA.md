# 🚀 Cómo Ejecutar el Script de Generación de Arena

**Script:** `generate_arena.gd` (en la raíz del proyecto)

---

## 📋 Pasos para Ejecutar

### Método 1: Desde el Editor de Godot (Recomendado)

1. **Abrir Godot** y cargar el proyecto `autochess`

2. **Abrir la escena Board.tscn** (o cualquier escena)

3. **Agregar el script temporalmente:**
   - En el árbol de escena, seleccionar el nodo raíz (Board)
   - En el Inspector, buscar "Script" o "Add Script"
   - O simplemente arrastrar `generate_arena.gd` al nodo Board

4. **Alternativa más simple:**
   - Click derecho en el nodo Board (o cualquier nodo)
   - "Attach Script"
   - Seleccionar `generate_arena.gd` como script
   - O crear un nodo temporal y agregar el script

5. **Ejecutar la escena** (F5 o Play)
   - El script se ejecutará automáticamente en `_ready()`
   - Verás mensajes en la consola
   - Las arenas se generarán en `assets/sprites/arena/`

6. **Verificar resultado:**
   - Revisar que se crearon:
     - `assets/sprites/arena/arena_ally.png`
     - `assets/sprites/arena/arena_enemy.png`

7. **Eliminar el script:**
   - Desconectar el script del nodo
   - O simplemente eliminar `generate_arena.gd` del proyecto

---

### Método 2: Crear Nodo Temporal

1. **En Godot, crear un nodo temporal:**
   - Click derecho en la escena
   - "Add Node" → "Node" (nodo básico)
   - Nombrarlo "ArenaGenerator"

2. **Agregar el script:**
   - Seleccionar el nodo
   - En Inspector, "Attach Script"
   - Seleccionar `generate_arena.gd`

3. **Ejecutar la escena** (F5)

4. **Eliminar el nodo** después de generar

---

### Método 3: Desde Consola de Godot

1. **Abrir consola de Godot** (no la consola del juego)

2. **Ejecutar:**
   ```gdscript
   var script = load("res://generate_arena.gd")
   var node = Node.new()
   node.set_script(script)
   get_tree().root.add_child(node)
   ```

---

## ✅ Verificación

Después de ejecutar, deberías ver en la consola:

```
==================================================
Generando arenas desde Tiny Dungeons...
==================================================
✓ Cargado: res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0000.png
✓ Cargado: res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0001.png
✓ Cargado: res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0002.png
✓ Tiles cargados para arena aliada: 3
✓ Arena aliada generada: res://assets/sprites/arena/arena_ally.png
✓ Tiles cargados para arena enemiga: 3
✓ Arena enemiga generada: res://assets/sprites/arena/arena_enemy.png
==================================================
¡Arenas generadas exitosamente!
Revisa: assets/sprites/arena/
==================================================
```

---

## 🐛 Solución de Problemas

### Error: "No se pudieron cargar tiles"

**Causa:** Los tiles no están en la ruta correcta

**Solución:**
1. Verificar que los tiles estén en:
   - `assets/sprites/arena/tiny_dungeons/Tiles/tile_0000.png`
   - `assets/sprites/arena/tiny_dungeons/Tiles/tile_0001.png`
   - `assets/sprites/arena/tiny_dungeons/Tiles/tile_0002.png`

2. Si faltan, copiarlos desde:
   - `C:\Users\Nitropc\Desktop\tiny dungeons pack\Tiles\`

### Error: "No se pudo guardar"

**Causa:** La carpeta de destino no existe o no tiene permisos

**Solución:**
1. Verificar que existe: `assets/sprites/arena/`
2. Si no existe, crearla manualmente
3. El script intenta crearla automáticamente, pero puede fallar

### Las arenas se generan pero están vacías o mal

**Causa:** Los tiles no se cargaron correctamente

**Solución:**
1. Verificar que los tiles son PNG válidos
2. Verificar que los tiles tienen 16×16px (tamaño original)
3. Revisar la consola para ver qué tiles se cargaron

---

## 🎨 Personalización

### Cambiar Tiles Usados

Editar `generate_arena.gd` y cambiar estos arrays:

```gdscript
var floor_tiles = [
    "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0000.png",
    "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_XXXX.png",  # Cambiar número
]
```

### Cambiar Patrón

En el script, hay 3 opciones comentadas:

**Opción 1: Patrón de ajedrez (actual)**
```gdscript
var tile_index = (col + row) % tile_images.size()
```

**Opción 2: Todo el mismo tile**
```gdscript
var tile_index = 0
```

**Opción 3: Patrón aleatorio**
```gdscript
var rng = RandomNumberGenerator.new()
rng.seed = hash(Vector2i(col, row))
var tile_index = rng.randi_range(0, tile_images.size() - 1)
```

---

## 📝 Notas

- El script se auto-elimina después de 2 segundos
- Las arenas se generan en formato PNG
- Tamaño final: 700×500px (7×5 celdas de 100×100px)
- Los tiles se escalan de 16×16px a 100×100px usando interpolación nearest (pixel art)

---

**¡Listo para ejecutar!** 🚀


