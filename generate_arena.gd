extends Node2D

# Script para testear la importación y visualización del tablero completo
# Muestra todos los 108 tiles del tablero (9 columnas × 12 filas)

const BoardTileHelper = preload("res://scripts/BoardTileHelper.gd")

func _ready():
	print("==================================================")
	print("🧪 TEST: Importación de Tiles del Tablero")
	print("==================================================")
	
	# Verificar que existen los sprites base
	test_base_tiles()
	
	# Cargar y mostrar el tablero completo
	load_full_board()
	
	print("==================================================")
	print("✅ Test completado. Revisa la visualización.")
	print("==================================================")

func test_base_tiles():
	"""Verifica que los sprites base existen y se pueden cargar"""
	print("\n📁 Verificando sprites base...")
	
	var tile_borde_path = "res://assets/sprites/arena/tiles/board/tile_board_borde.png"
	var tile_combat_path = "res://assets/sprites/arena/tiles/board/tile_board_combat.png"
	
	# Verificar tile_board_borde.png
	if ResourceLoader.exists(tile_borde_path):
		var texture = load(tile_borde_path) as Texture2D
		if texture:
			print("  ✅ tile_board_borde.png cargado correctamente")
			print("     Dimensiones: %dx%d" % [texture.get_width(), texture.get_height()])
		else:
			print("  ❌ No se pudo cargar tile_board_borde.png como textura")
	else:
		print("  ❌ No se encuentra tile_board_borde.png")
	
	# Verificar tile_board_combat.png
	if ResourceLoader.exists(tile_combat_path):
		var texture = load(tile_combat_path) as Texture2D
		if texture:
			print("  ✅ tile_board_combat.png cargado correctamente")
			print("     Dimensiones: %dx%d" % [texture.get_width(), texture.get_height()])
		else:
			print("  ❌ No se pudo cargar tile_board_combat.png como textura")
	else:
		print("  ❌ No se encuentra tile_board_combat.png")

func load_full_board():
	"""Carga y muestra el tablero completo (108 tiles)"""
	print("\n🎨 Cargando tablero completo (9×12 = 108 tiles)...")
	
	# El tablero es 9 columnas × 12 filas = 108 tiles
	# Cada tile es 100×100px
	# Centrado en (0, 0)
	var board_start_x = -450  # Centro - (9 columnas × 100px / 2)
	var board_start_y = -600  # Centro - (12 filas × 100px / 2)
	
	var tiles_loaded = 0
	var tiles_failed = 0
	
	# Crear contenedor para los tiles
	var tiles_container = Node2D.new()
	tiles_container.name = "BoardTiles"
	add_child(tiles_container)
	
	# Cargar todos los tiles
	for row in range(12):
		for col in range(9):
			var tile_index = BoardTileHelper.get_border_tile_index(col, row)
			var tile_path = BoardTileHelper.get_tile_path(tile_index)
			
			if ResourceLoader.exists(tile_path):
				var texture = load(tile_path) as Texture2D
				if texture:
					var sprite = Sprite2D.new()
					sprite.texture = texture
					sprite.centered = false
					
					# Posicionar el tile
					var x = board_start_x + (col * 100)
					var y = board_start_y + (row * 100)
					sprite.position = Vector2(x, y)
					sprite.z_index = -1
					sprite.name = "Tile_%d" % tile_index
					
					tiles_container.add_child(sprite)
					tiles_loaded += 1
				else:
					tiles_failed += 1
					print("  ⚠ No se pudo cargar textura: tile_%d" % tile_index)
			else:
				tiles_failed += 1
				print("  ⚠ No existe: %s" % tile_path)
	
	print("\n📊 Resumen:")
	print("  ✅ Tiles cargados: %d/108" % tiles_loaded)
	if tiles_failed > 0:
		print("  ❌ Tiles fallidos: %d" % tiles_failed)
	
	# Agregar cámara para ver el tablero
	var camera = Camera2D.new()
	camera.name = "Camera2D"
	camera.position = Vector2(0, 0)
	camera.zoom = Vector2(0.5, 0.5)  # Zoom out para ver todo el tablero
	add_child(camera)
	
	print("\n💡 El tablero debería ser visible ahora.")
	print("   Usa la cámara para navegar si es necesario.")
