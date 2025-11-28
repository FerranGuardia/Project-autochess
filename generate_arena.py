#!/usr/bin/env python3
"""
Script para generar arenas desde tiles de Tiny Dungeons
Genera: arena_ally.png y arena_enemy.png (700×500px)
"""

from PIL import Image
import os

# Rutas
TILES_DIR = "assets/sprites/arena/tiny_dungeons/Tiles"
OUTPUT_DIR = "assets/sprites/arena"

# Tiles a usar
FLOOR_TILES_ALLY = [
    "tile_0000.png",  # Suelo básico
    "tile_0001.png",  # Variación
    "tile_0002.png",  # Otra variación
]

FLOOR_TILES_ENEMY = [
    "tile_0000.png",  # Mismo que aliado por ahora
    "tile_0001.png",
    "tile_0002.png",
]

# Dimensiones
TILE_SIZE_ORIGINAL = 16  # Tamaño original de los tiles
TILE_SIZE_SCALED = 100    # Tamaño escalado para la arena
GRID_COLUMNS = 7
GRID_ROWS = 5
ARENA_WIDTH = GRID_COLUMNS * TILE_SIZE_SCALED  # 700px
ARENA_HEIGHT = GRID_ROWS * TILE_SIZE_SCALED    # 500px

def generate_arena(tiles_list, output_filename, arena_name):
    """Genera una arena desde una lista de tiles"""
    print(f"Generando {arena_name}...")
    
    # Crear directorio de salida si no existe
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    # Cargar y escalar tiles
    tile_images = []
    for tile_name in tiles_list:
        tile_path = os.path.join(TILES_DIR, tile_name)
        if os.path.exists(tile_path):
            try:
                tile_img = Image.open(tile_path)
                # Escalar de 16×16 a 100×100 usando NEAREST (pixel art)
                tile_scaled = tile_img.resize((TILE_SIZE_SCALED, TILE_SIZE_SCALED), Image.NEAREST)
                tile_images.append(tile_scaled)
                print(f"  [OK] Cargado: {tile_name}")
            except Exception as e:
                print(f"  [WARN] Error al cargar {tile_name}: {e}")
        else:
            print(f"  [WARN] No existe: {tile_path}")
    
    if not tile_images:
        print(f"  [ERROR] No se pudieron cargar tiles para {arena_name}")
        return False
    
    # Crear imagen final
    arena_image = Image.new('RGBA', (ARENA_WIDTH, ARENA_HEIGHT), (0, 0, 0, 0))
    
    # Llenar con tiles (7×5 celdas)
    for row in range(GRID_ROWS):
        for col in range(GRID_COLUMNS):
            # Patrón de ajedrez
            tile_index = (col + row) % len(tile_images)
            # O todo el mismo tile: tile_index = 0
            
            tile_img = tile_images[tile_index]
            x = col * TILE_SIZE_SCALED
            y = row * TILE_SIZE_SCALED
            
            # Pegar tile en la posición
            arena_image.paste(tile_img, (x, y))
    
    # Guardar
    output_path = os.path.join(OUTPUT_DIR, output_filename)
    arena_image.save(output_path)
    print(f"  [OK] {arena_name} generada: {output_path}")
    print(f"    Tamaño: {ARENA_WIDTH}x{ARENA_HEIGHT}px")
    return True

def main():
    print("=" * 50)
    print("Generando arenas desde Tiny Dungeons...")
    print("=" * 50)
    
    # Verificar que existe la carpeta de tiles
    if not os.path.exists(TILES_DIR):
        print(f"[ERROR] No se encuentra la carpeta de tiles: {TILES_DIR}")
        print("   Asegurate de que los tiles esten en esa ubicacion.")
        return
    
    # Generar arenas
    success_ally = generate_arena(FLOOR_TILES_ALLY, "arena_ally.png", "Arena Aliada")
    success_enemy = generate_arena(FLOOR_TILES_ENEMY, "arena_enemy.png", "Arena Enemiga")
    
    print("=" * 50)
    if success_ally and success_enemy:
        print("!Arenas generadas exitosamente!")
        print(f"Revisa: {OUTPUT_DIR}/")
    else:
        print("Error: Algunas arenas no se pudieron generar")
    print("=" * 50)

if __name__ == "__main__":
    try:
        main()
    except ImportError:
        print("[ERROR] Se requiere la libreria PIL (Pillow)")
        print("   Instala con: pip install Pillow")
    except Exception as e:
        print(f"[ERROR] Error inesperado: {e}")

