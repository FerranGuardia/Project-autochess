# 🎨 Guía: Usar Tiny Dungeons Pack para la Arena

**Pack:** Tiny Dungeon (Kenney)  
**Tiles:** 16×16px (necesitan escalarse a 100×100px)  
**Total:** 132 tiles individuales

---

## 📋 Análisis del Pack

### Estructura
- **Tiles individuales:** `Tiles/tile_XXXX.png` (16×16px cada uno)
- **Tilesheet completo:** `Tilemap/tilemap.png` (todos los tiles en una imagen)
- **Preview:** `Preview.png` y `Sample.png` (ejemplos de uso)

### Características
- ✅ Tiles de suelo variados (piedra, hierba, agua, etc.)
- ✅ Bordes y esquinas para crear patrones
- ✅ Compatible con CC0 (uso libre)
- ⚠️ Tamaño original: 16×16px (necesita escalado)

---

## 🎯 Plan de Implementación

### Opción 1: Usar TileMap de Godot (RECOMENDADA)
**Ventajas:**
- ✅ Optimizado para rendimiento
- ✅ Fácil de variar tiles por celda
- ✅ Sistema nativo de Godot

**Pasos:**
1. Crear TileSet en Godot usando `tilemap.png`
2. Crear TileMap con 7×5 celdas
3. Asignar tiles de suelo a cada celda
4. Escalar TileMap a 100×100px por celda

### Opción 2: Crear Sprites Individuales Escalados
**Ventajas:**
- ✅ Control total sobre cada celda
- ✅ Fácil de personalizar

**Pasos:**
1. Escalar tiles de 16×16px a 100×100px
2. Crear sprites individuales para cada celda
3. Usar diferentes tiles para variación

### Opción 3: Crear Imagen de Arena Compuesta
**Ventajas:**
- ✅ Un solo sprite grande (mejor rendimiento)
- ✅ Fácil de implementar

**Pasos:**
1. Seleccionar tiles de suelo apropiados
2. Componer imagen de 700×500px (7×5 celdas de 100×100px)
3. Usar como sprite de fondo

---

## 🛠️ Implementación Recomendada: TileMap

### Paso 1: Copiar Assets al Proyecto

```
autochess/
  assets/
    sprites/
      arena/
        tiny_dungeons/
          tilemap.png          # Copiar desde Desktop
          tile_0000.png        # Copiar tiles que necesites
          tile_0001.png
          ... (solo los que uses)
```

### Paso 2: Crear TileSet en Godot

1. **Abrir Godot**
2. **Crear nuevo TileSet:**
   - Click derecho en `assets/sprites/arena/`
   - "Nuevo Recurso" → "TileSet"
   - Guardar como `arena_tileset.tres`

3. **Configurar TileSet:**
   - Abrir `arena_tileset.tres`
   - Agregar nueva fuente de tiles
   - Seleccionar `tilemap.png`
   - Configurar:
     - **Tile Size:** 16×16px
     - **Separation:** 1px
     - **Columns:** 12
     - **Rows:** 11

4. **Seleccionar tiles de suelo:**
   - Identificar tiles de suelo (generalmente primeros tiles)
   - Marcar como tiles válidos en el TileSet

### Paso 3: Crear TileMap en GridAlly

**Modificar `GridAlly.gd`:**

```gdscript
extends Node2D
class_name GridAlly

const CELL_SIZE = 100
const COLUMNS = 7
const ROWS = 5

# TileMap para la arena
var arena_tilemap: TileMap
var tileset: TileSet

func _ready():
    create_arena_tilemap()
    setup_units_container()
    setup_drag_drop()

func create_arena_tilemap():
    """Crea el TileMap de la arena"""
    # Cargar TileSet
    tileset = load("res://assets/sprites/arena/tiny_dungeons/arena_tileset.tres")
    if not tileset:
        print("Error: No se encontró el TileSet de arena")
        return
    
    # Crear TileMap
    arena_tilemap = TileMap.new()
    arena_tilemap.name = "ArenaTileMap"
    arena_tilemap.tile_set = tileset
    
    # Configurar escala: tiles de 16px → 100px (6.25x)
    arena_tilemap.scale = Vector2(CELL_SIZE / 16.0, CELL_SIZE / 16.0)
    
    # Crear grid de 7×5 celdas
    for row in range(ROWS):
        for col in range(COLUMNS):
            # Usar tile de suelo (ejemplo: tile 0, 1, o 2)
            # Puedes variar para crear patrones
            var tile_id = get_floor_tile_id(col, row)
            var source_id = 0  # ID de la fuente de tiles
            var atlas_coords = Vector2i(tile_id % 12, tile_id / 12)
            
            arena_tilemap.set_cell(0, Vector2i(col, row), source_id, atlas_coords)
    
    add_child(arena_tilemap)
    arena_tilemap.z_index = -1  # Detrás de las unidades

func get_floor_tile_id(col: int, row: int) -> int:
    """Determina qué tile usar para cada celda (puedes variar para patrones)"""
    # Opción 1: Todo el mismo tile
    return 0  # Tile de suelo básico
    
    # Opción 2: Patrón de ajedrez
    # if (col + row) % 2 == 0:
    #     return 0
    # else:
    #     return 1
    
    # Opción 3: Variación aleatoria (usar seed para consistencia)
    # var rng = RandomNumberGenerator.new()
    # rng.seed = hash(Vector2i(col, row))
    # return rng.randi_range(0, 5)  # Tiles 0-5 son suelos
```

### Paso 4: Ajustar Posicionamiento

El TileMap necesita estar centrado como el grid anterior:

```gdscript
func create_arena_tilemap():
    # ... código anterior ...
    
    # Centrar el TileMap
    var grid_width = float(COLUMNS * CELL_SIZE)
    var grid_height = float(ROWS * CELL_SIZE)
    arena_tilemap.position = Vector2(-grid_width / 2.0, -grid_height / 2.0)
    
    add_child(arena_tilemap)
```

---

## 🎨 Opción Alternativa: Crear Sprite Compuesto

Si prefieres un sprite grande en lugar de TileMap:

### Paso 1: Seleccionar Tiles de Suelo

Revisar `Preview.png` o `Sample.png` para ver qué tiles son suelos.

Tiles típicos de suelo:
- `tile_0000.png` - Suelo básico
- `tile_0001.png` - Suelo alternativo
- `tile_0002.png` - Suelo con variación
- etc.

### Paso 2: Componer Imagen de Arena

**Usando herramienta externa (GIMP, Photoshop, etc.):**

1. Crear imagen nueva: 700×500px
2. Escalar tiles de 16×16px a 100×100px
3. Colocar 7×5 tiles para crear la arena
4. Guardar como `arena_ally.png`

**O usar script de Godot para generar:**

```gdscript
# Script temporal para generar arena (ejecutar una vez)
func generate_arena_sprite():
    var tile_texture = load("res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0000.png")
    var image = Image.create(700, 500, false, Image.FORMAT_RGBA8)
    
    # Escalar tile de 16×16 a 100×100
    var scaled_tile = tile_texture.get_image()
    scaled_tile.resize(100, 100, Image.INTERPOLATE_NEAREST)
    
    # Colocar tiles en grid 7×5
    for row in range(5):
        for col in range(7):
            var x = col * 100
            var y = row * 100
            image.blit_rect(scaled_tile, Rect2i(0, 0, 100, 100), Vector2i(x, y))
    
    # Guardar
    image.save_png("res://assets/sprites/arena/arena_ally.png")
    print("Arena generada!")
```

### Paso 3: Usar el Sprite

Usar el código de la guía anterior (`GUIA_ARENA_VISUAL.md`) para cargar el sprite.

---

## 📐 Escalado de Tiles

### Problema
- Tiles originales: 16×16px
- Necesitamos: 100×100px por celda
- Factor de escalado: 100/16 = 6.25x

### Soluciones

**Opción A: Escalar en Godot (automático)**
- TileMap escala automáticamente
- Usar `scale = Vector2(6.25, 6.25)`

**Opción B: Escalar imágenes externamente**
- Usar GIMP/Photoshop para escalar tiles
- Guardar como 100×100px
- Importar a Godot

**Opción C: Escalar en tiempo de ejecución**
- Cargar tile de 16×16px
- Escalar con `Image.resize()`
- Más lento pero flexible

---

## 🎯 Tiles Recomendados para Arena

Basado en packs similares de Kenney, estos tiles suelen ser suelos:

- **Suelo básico:** `tile_0000.png`, `tile_0001.png`
- **Suelo con detalles:** `tile_0002.png`, `tile_0003.png`
- **Bordes:** Tiles más altos en el tilesheet
- **Esquinas:** Tiles específicos para esquinas

**Recomendación:** Revisar `Preview.png` o `Sample.png` para identificar visualmente qué tiles son suelos.

---

## ✅ Checklist de Implementación

### Para TileMap:
- [ ] Copiar `tilemap.png` al proyecto
- [ ] Crear TileSet en Godot
- [ ] Configurar TileSet (16×16px, 12×11 tiles)
- [ ] Modificar `GridAlly.gd` para usar TileMap
- [ ] Modificar `GridEnemy.gd` para usar TileMap
- [ ] Ajustar escala (6.25x)
- [ ] Probar drag & drop
- [ ] Seleccionar tiles de suelo apropiados

### Para Sprite Compuesto:
- [ ] Seleccionar tiles de suelo
- [ ] Escalar tiles a 100×100px
- [ ] Componer imagen de 700×500px
- [ ] Guardar como `arena_ally.png` y `arena_enemy.png`
- [ ] Copiar al proyecto
- [ ] Modificar `GridAlly.gd` y `GridEnemy.gd`
- [ ] Probar

---

## 🚀 Próximos Pasos

1. **Decidir método:** TileMap o Sprite compuesto
2. **Copiar assets** al proyecto
3. **Implementar** según método elegido
4. **Probar** que todo funciona
5. **Ajustar** tiles y patrones según gusto

---

## 📝 Notas

- **Licencia:** CC0 (uso libre, no requiere atribución)
- **Crédito opcional:** Kenney (www.kenney.nl)
- **Tamaño original:** 16×16px (muy pequeño, necesita escalado)
- **Variación:** Puedes usar diferentes tiles para crear patrones interesantes

---

**¡Listo para implementar!** 🎨


