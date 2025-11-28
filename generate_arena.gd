extends Node

## Script temporal para generar arenas desde Tiny Dungeons
## Ejecutar una vez desde Godot, luego eliminar este archivo
##
## Genera:
## - assets/sprites/arena/arena_ally.png (700×500px)
## - assets/sprites/arena/arena_enemy.png (700×500px)

func _ready():
	print("==================================================")
	print("Generando arenas desde Tiny Dungeons...")
	print("==================================================")
	
	# Crear carpeta de destino si no existe
	ensure_arena_directory()
	
	# Generar arenas
	var success_ally = generate_arena_ally()
	var success_enemy = generate_arena_enemy()
	
	if success_ally and success_enemy:
		print("==================================================")
		print("¡Arenas generadas exitosamente!")
		print("Revisa: assets/sprites/arena/")
		print("==================================================")
	else:
		print("==================================================")
		print("Error: Algunas arenas no se pudieron generar")
		print("==================================================")
	
	# Auto-eliminar después de 2 segundos
	await get_tree().create_timer(2.0).timeout
	queue_free()

func ensure_arena_directory():
	"""Asegura que existe la carpeta de destino"""
	var dir = DirAccess.open("res://")
	if dir:
		dir.make_dir_recursive("assets/sprites/arena")

func generate_arena_ally() -> bool:
	"""Genera arena_ally.png desde tiles de Tiny Dungeons"""
	var output_path = "res://assets/sprites/arena/arena_ally.png"
	
	# Tiles de suelo a usar (puedes cambiar estos números según qué tiles prefieras)
	var floor_tiles = [
		"res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0000.png",  # Suelo básico
		"res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0001.png",  # Variación
		"res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0002.png",  # Otra variación
	]
	
	# Intentar cargar tiles
	var tile_images = []
	for tile_path in floor_tiles:
		if ResourceLoader.exists(tile_path):
			var texture = load(tile_path)
			if texture:
				var img = texture.get_image()
				if img:
					# Escalar de 16×16 a 100×100 usando interpolación nearest (pixel art)
					img.resize(100, 100, Image.INTERPOLATE_NEAREST)
					tile_images.append(img)
					print("✓ Cargado: ", tile_path)
				else:
					print("⚠ No se pudo obtener imagen de: ", tile_path)
			else:
				print("⚠ No se pudo cargar textura: ", tile_path)
		else:
			print("⚠ No existe: ", tile_path)
	
	if tile_images.is_empty():
		print("❌ Error: No se pudieron cargar tiles para arena aliada")
		print("   Verifica que los tiles estén en: assets/sprites/arena/tiny_dungeons/Tiles/")
		return false
	
	print("✓ Tiles cargados para arena aliada: ", tile_images.size())
	
	# Crear imagen final 700×500px (7 columnas × 5 filas × 100px cada celda)
	var arena_image = Image.create(700, 500, false, Image.FORMAT_RGBA8)
	
	# Llenar con tiles (7×5 celdas)
	for row in range(5):
		for col in range(7):
			# Seleccionar tile (puedes variar para crear patrones)
			# Opción 1: Patrón de ajedrez
			var tile_index = (col + row) % tile_images.size()
			
			# Opción 2: Todo el mismo tile (descomenta para usar)
			# var tile_index = 0
			
			# Opción 3: Patrón aleatorio con seed (descomenta para usar)
			# var rng = RandomNumberGenerator.new()
			# rng.seed = hash(Vector2i(col, row))
			# var tile_index = rng.randi_range(0, tile_images.size() - 1)
			
			var tile_img = tile_images[tile_index]
			var x = col * 100
			var y = row * 100
			
			# Copiar tile a la posición
			arena_image.blit_rect(tile_img, Rect2i(0, 0, 100, 100), Vector2i(x, y))
	
	# Guardar
	var error = arena_image.save_png(output_path)
	if error != OK:
		print("❌ Error al guardar arena aliada: ", error)
		return false
	
	print("✓ Arena aliada generada: ", output_path)
	return true

func generate_arena_enemy() -> bool:
	"""Genera arena_enemy.png desde tiles (puede usar tiles diferentes)"""
	var output_path = "res://assets/sprites/arena/arena_enemy.png"
	
	# Tiles de suelo para enemigo (pueden ser diferentes para diferenciar)
	var floor_tiles = [
		"res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0000.png",  # Mismo que aliado por ahora
		"res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0001.png",
		"res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0002.png",
	]
	
	# Si quieres usar tiles diferentes para enemigo, descomenta y ajusta:
	# var floor_tiles = [
	# 	"res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0003.png",
	# 	"res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0004.png",
	# 	"res://assets/sprites/arena/tiny_dungeons/Tiles/tile_0005.png",
	# ]
	
	# Cargar tiles
	var tile_images = []
	for tile_path in floor_tiles:
		if ResourceLoader.exists(tile_path):
			var texture = load(tile_path)
			if texture:
				var img = texture.get_image()
				if img:
					img.resize(100, 100, Image.INTERPOLATE_NEAREST)
					tile_images.append(img)
					print("✓ Cargado: ", tile_path)
	
	if tile_images.is_empty():
		print("❌ Error: No se pudieron cargar tiles para arena enemiga")
		return false
	
	print("✓ Tiles cargados para arena enemiga: ", tile_images.size())
	
	# Crear imagen final
	var arena_image = Image.create(700, 500, false, Image.FORMAT_RGBA8)
	
	# Llenar con tiles
	for row in range(5):
		for col in range(7):
			# Mismo patrón que arena aliada (puedes cambiarlo)
			var tile_index = (col + row) % tile_images.size()
			# var tile_index = 0  # Todo el mismo tile
			
			var tile_img = tile_images[tile_index]
			var x = col * 100
			var y = row * 100
			arena_image.blit_rect(tile_img, Rect2i(0, 0, 100, 100), Vector2i(x, y))
	
	# Guardar
	var error = arena_image.save_png(output_path)
	if error != OK:
		print("❌ Error al guardar arena enemiga: ", error)
		return false
	
	print("✓ Arena enemiga generada: ", output_path)
	return true

