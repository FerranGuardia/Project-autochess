# 🛠️ Script: Generar Arena desde Tiny Dungeons

**Script temporal para generar sprites de arena desde tiles de Tiny Dungeons**

---

## 📋 Qué hace este script

1. Carga tiles individuales de Tiny Dungeons (16×16px)
2. Los escala a 100×100px
3. Los compone en una imagen de 700×500px (7×5 celdas)
4. Guarda como `arena_ally.png` y `arena_enemy.png`

---

## 🚀 Cómo Usar

### Opción 1: Script Temporal en Godot

1. **Crear script temporal** `generate_arena.gd` en la raíz del proyecto
2. **Copiar código** de abajo
3. **Ajustar rutas** según donde estén los tiles
4. **Ejecutar** desde el editor de Godot
5. **Eliminar script** después de generar

### Opción 2: Ejecutar desde consola

```gdscript
# En la consola de Godot (F8)
# O crear un script temporal y ejecutarlo
```

---

## 📝 Código del Script

```gdscript
extends Node

# Script temporal para generar arena desde Tiny Dungeons
# Ejecutar una vez, luego eliminar

func _ready():
    print("Generando arenas desde Tiny Dungeons...")
    generate_arena_ally()
    generate_arena_enemy()
    print("¡Arenas generadas! Revisa assets/sprites/arena/")
    queue_free()

func generate_arena_ally():
    """Genera arena_ally.png desde tiles"""
    var output_path = "res://assets/sprites/arena/arena_ally.png"
    
    # Tiles de suelo a usar (puedes cambiar estos números)
    var floor_tiles = [
        "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0000.png",  # Suelo básico
        "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0001.png",  # Variación
        "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0002.png",  # Otra variación
    ]
    
    # Cargar tiles
    var tile_images = []
    for tile_path in floor_tiles:
        var texture = load(tile_path)
        if texture:
            var img = texture.get_image()
            # Escalar de 16×16 a 100×100
            img.resize(100, 100, Image.INTERPOLATE_NEAREST)
            tile_images.append(img)
        else:
            print("Warning: No se encontró ", tile_path)
    
    if tile_images.is_empty():
        print("Error: No se pudieron cargar tiles")
        return
    
    # Crear imagen final 700×500px
    var arena_image = Image.create(700, 500, false, Image.FORMAT_RGBA8)
    
    # Llenar con tiles (7×5 celdas)
    for row in range(5):
        for col in range(7):
            # Seleccionar tile (puedes variar para crear patrones)
            var tile_index = (col + row) % tile_images.size()  # Patrón de ajedrez
            # O usar siempre el mismo: var tile_index = 0
            
            var tile_img = tile_images[tile_index]
            var x = col * 100
            var y = row * 100
            
            # Copiar tile a la posición
            arena_image.blit_rect(tile_img, Rect2i(0, 0, 100, 100), Vector2i(x, y))
    
    # Guardar
    arena_image.save_png(output_path)
    print("Arena aliada generada: ", output_path)

func generate_arena_enemy():
    """Genera arena_enemy.png desde tiles (puede usar tiles diferentes)"""
    var output_path = "res://assets/sprites/arena/arena_enemy.png"
    
    # Tiles de suelo para enemigo (pueden ser diferentes)
    var floor_tiles = [
        "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0003.png",  # Diferente para enemigo
        "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0004.png",
        "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0005.png",
    ]
    
    # Si no hay tiles diferentes, usar los mismos
    if not ResourceLoader.exists(floor_tiles[0]):
        floor_tiles = [
            "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0000.png",
            "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0001.png",
            "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0002.png",
        ]
    
    # Cargar tiles
    var tile_images = []
    for tile_path in floor_tiles:
        var texture = load(tile_path)
        if texture:
            var img = texture.get_image()
            img.resize(100, 100, Image.INTERPOLATE_NEAREST)
            tile_images.append(img)
    
    if tile_images.is_empty():
        print("Error: No se pudieron cargar tiles para enemigo")
        return
    
    # Crear imagen final
    var arena_image = Image.create(700, 500, false, Image.FORMAT_RGBA8)
    
    # Llenar con tiles
    for row in range(5):
        for col in range(7):
            var tile_index = (col + row) % tile_images.size()
            var tile_img = tile_images[tile_index]
            var x = col * 100
            var y = row * 100
            arena_image.blit_rect(tile_img, Rect2i(0, 0, 100, 100), Vector2i(x, y))
    
    # Guardar
    arena_image.save_png(output_path)
    print("Arena enemiga generada: ", output_path)
```

---

## 🔧 Pasos de Implementación

### 1. Copiar Tiles al Proyecto

```powershell
# Desde PowerShell en el escritorio
Copy-Item "C:\Users\Nitropc\Desktop\tiny dungeons pack\Tiles\tile_0000.png" -Destination "C:\Users\Nitropc\Desktop\autochess\assets\sprites\arena\tiny_dungeons\Tiles\"
Copy-Item "C:\Users\Nitropc\Desktop\tiny dungeons pack\Tiles\tile_0001.png" -Destination "C:\Users\Nitropc\Desktop\autochess\assets\sprites\arena\tiny_dungeons\Tiles\"
Copy-Item "C:\Users\Nitropc\Desktop\tiny dungeons pack\Tiles\tile_0002.png" -Destination "C:\Users\Nitropc\Desktop\autochess\assets\sprites\arena\tiny_dungeons\Tiles\"
# ... copiar los tiles que necesites
```

O copiar todos:

```powershell
Copy-Item "C:\Users\Nitropc\Desktop\tiny dungeons pack\Tiles\*.png" -Destination "C:\Users\Nitropc\Desktop\autochess\assets\sprites\arena\tiny_dungeons\Tiles\" -Recurse
```

### 2. Crear Script Temporal

1. En Godot, crear nuevo script: `generate_arena.gd`
2. Copiar el código de arriba
3. Ajustar rutas si es necesario

### 3. Ejecutar Script

- **Opción A:** Agregar como nodo temporal en una escena y ejecutar
- **Opción B:** Ejecutar desde consola de Godot

### 4. Verificar Resultado

- Revisar que se crearon `arena_ally.png` y `arena_enemy.png`
- Verificar que tienen 700×500px
- Eliminar script temporal

### 5. Usar las Arenas

- Seguir la guía `GUIA_ARENA_VISUAL.md` para implementar
- O usar el código de `IMPLEMENTACION_ARENA_PASO_A_PASO.md`

---

## 🎨 Personalización

### Cambiar Tiles Usados

Editar estas líneas en el script:

```gdscript
var floor_tiles = [
    "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0000.png",
    "res://assets/sprites/arena/tiny_dungeons/Tiles/tile_XXXX.png",  # Cambiar número
    # ... agregar más tiles
]
```

### Cambiar Patrón

**Patrón uniforme (mismo tile):**
```gdscript
var tile_index = 0  # Siempre el primer tile
```

**Patrón de ajedrez:**
```gdscript
var tile_index = (col + row) % tile_images.size()
```

**Patrón aleatorio (con seed):**
```gdscript
var rng = RandomNumberGenerator.new()
rng.seed = hash(Vector2i(col, row))
var tile_index = rng.randi_range(0, tile_images.size() - 1)
```

---

## ⚠️ Notas Importantes

- **Rutas:** Asegúrate de que las rutas a los tiles sean correctas
- **Tamaño:** Los tiles se escalan de 16×16px a 100×100px
- **Formato:** Se guarda como PNG con transparencia
- **Eliminar:** Elimina el script después de generar las arenas

---

**¡Listo para generar!** 🚀


