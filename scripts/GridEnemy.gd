extends Node2D
class_name GridEnemy

## Grid del tablero enemigo (7×5 celdas)
## Visualización y gestión del grid superior

const BoardTileHelper = preload("res://scripts/BoardTileHelper.gd")

const CELL_SIZE = 100
const COLUMNS = 7
const ROWS = 5

# Referencia al contenedor de celdas (se crean dinámicamente)
var cells_container: Node2D = null
var tiles_container: Node2D = null  # Contenedor para los tiles individuales del grid
var background: Node2D = null  # Fallback Polygon2D si no hay tiles

var cells: Array[Polygon2D] = []
var tiles: Array[Sprite2D] = []  # Array de sprites de tiles del grid

# Sistema de unidades enemigas
var units: Dictionary = {}  # Key: Vector2i(grid_position), Value: Unit
var units_container: Node2D = null

# Referencia al GameManager para otorgar loot
var game_manager: GameManager = null

func _ready():
	create_grid()
	setup_units_container()

func setup_units_container():
	"""Crea el contenedor para las unidades enemigas"""
	if not units_container:
		units_container = Node2D.new()
		units_container.name = "UnitsContainer"
		add_child(units_container)

func create_grid():
	"""Crea el grid visual de 7×5 celdas con tiles individuales"""
	# Crear contenedor para tiles del grid si no existe
	if not tiles_container:
		tiles_container = Node2D.new()
		tiles_container.name = "TilesContainer"
		add_child(tiles_container)
		tiles_container.z_index = -1  # Detrás de las unidades
	
	# Cargar y colocar tiles individuales del grid
	load_and_place_tiles()
	
	# Si no hay tiles, usar fallback
	if tiles.is_empty():
		create_fallback_background()
	
	# Crear contenedor de celdas si no existe
	if not cells_container:
		cells_container = Node2D.new()
		cells_container.name = "CellsContainer"
		add_child(cells_container)
	
	# Crear cada celda del grid
	for row in range(ROWS):
		for col in range(COLUMNS):
			create_cell(col, row)

func load_and_place_tiles():
	"""Carga tiles individuales y los coloca uno a uno en cada celda"""
	tiles.clear()
	
	# Limpiar tiles anteriores
	for child in tiles_container.get_children():
		child.queue_free()
	
	var tiles_loaded = 0
	# Cargando tiles del grid enemigo...
	
	# Colocar tiles en cada celda del grid (7×5 = 35 tiles)
	for row in range(ROWS):
		for col in range(COLUMNS):
			var tile_sprite = load_tile_for_cell(col, row)
			if tile_sprite:
				# Calcular posición de la celda desde la esquina superior izquierda
				# Para alinearse con los tiles del borde que usan esquina superior izquierda
				var cell_center = get_world_position(col, row)
				# Convertir centro de celda a esquina superior izquierda (centered = false)
				var cell_top_left = cell_center - Vector2(CELL_SIZE / 2.0, CELL_SIZE / 2.0)
				tile_sprite.position = to_local(cell_top_left)
				tile_sprite.z_index = -1
				
				tiles_container.add_child(tile_sprite)
				tiles.append(tile_sprite)
				tiles_loaded += 1
	
	if tiles_loaded > 0:
		print("✓ Tiles cargados para arena enemiga: ", tiles_loaded, " de ", COLUMNS * ROWS)
	else:
		print("⚠ No se encontraron tiles para arena enemiga. Usando fallback.")

func load_tile_for_cell(col: int, row: int) -> Sprite2D:
	"""Intenta cargar un tile específico para una celda del tablero completo"""
	# Calcular índice del tile del tablero completo (1-108)
	# Grid enemigo está en las filas 1-5 del tablero completo
	var tile_index = BoardTileHelper.get_enemy_tile_index(col, row)
	
	# Intentar cargar tile específico del tablero completo
	var tile_path = BoardTileHelper.get_tile_path(tile_index)
	if ResourceLoader.exists(tile_path):
		var texture = load(tile_path) as Texture2D
		if texture:
			var sprite = Sprite2D.new()
			sprite.texture = texture
			sprite.centered = false
			sprite.name = "Tile_%d_%d" % [col, row]
			# Tile cargado correctamente
			return sprite
	
	# No usar fallback genérico - solo cargar el tile específico
	# Si no existe, retornar null (se usará fallback de fondo)
	return null

func create_fallback_background():
	"""Crea un fondo temporal si no hay tiles disponibles"""
	if background:
		return
	
	var polygon = Polygon2D.new()
	polygon.name = "Background"
	polygon.color = Color(1.0, 0.2, 0.2, 0.25)  # Rojo semitransparente
	var width = float(COLUMNS * CELL_SIZE)
	var height = float(ROWS * CELL_SIZE)
	polygon.polygon = PackedVector2Array([
		Vector2(-width / 2.0, -height / 2.0),
		Vector2(width / 2.0, -height / 2.0),
		Vector2(width / 2.0, height / 2.0),
		Vector2(-width / 2.0, height / 2.0)
	])
	background = polygon
	add_child(background)
	print("⚠ Usando fondo temporal. Crea tiles en assets/sprites/arena/tiles/board/")

func create_cell(col: int, row: int):
	"""Crea una celda individual en la posición (col, row)"""
	var cell = Polygon2D.new()
	cell.name = "Cell_%d_%d" % [col, row]
	
	# Tamaño y posición de la celda
	var x = (float(col) - float(COLUMNS) / 2.0 + 0.5) * float(CELL_SIZE)
	var y = (float(row) - float(ROWS) / 2.0 + 0.5) * float(CELL_SIZE)
	var pos = Vector2(x - float(CELL_SIZE) / 2.0, y - float(CELL_SIZE) / 2.0)
	
	# Crear polígono rectangular para la celda (invisible, solo para lógica)
	cell.color = Color(1.0, 1.0, 1.0, 0.0)  # Completamente invisible
	var cell_size_float = float(CELL_SIZE)
	cell.polygon = PackedVector2Array([
		pos,
		pos + Vector2(cell_size_float, 0),
		pos + Vector2(cell_size_float, cell_size_float),
		pos + Vector2(0, cell_size_float)
	])
	
	# NO crear bordes por defecto (solo aparecerán en highlight durante drag)
	# Los bordes se crean dinámicamente en update_highlight_cell() si es necesario
	
	cells_container.add_child(cell)
	cells.append(cell)

func create_cell_border(pos: Vector2, size: Vector2) -> Line2D:
	"""Crea el borde visual de una celda"""
	var border = Line2D.new()
	border.width = 2.0
	border.default_color = Color(1.0, 0.5, 0.5, 0.5)  # Rojo claro semitransparente
	
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

func get_world_position(col: int, row: int) -> Vector2:
	"""Convierte coordenadas del grid (col, row) a posición mundial"""
	var x = (float(col) - float(COLUMNS) / 2.0 + 0.5) * float(CELL_SIZE)
	var y = (float(row) - float(ROWS) / 2.0 + 0.5) * float(CELL_SIZE)
	return global_position + Vector2(x, y)

func get_grid_position(world_pos: Vector2) -> Vector2i:
	"""Convierte posición mundial a coordenadas del grid"""
	var local_pos = to_local(world_pos)
	var col = int((local_pos.x / float(CELL_SIZE)) + float(COLUMNS) / 2.0)
	var row = int((local_pos.y / float(CELL_SIZE)) + float(ROWS) / 2.0)
	return Vector2i(clamp(col, 0, COLUMNS - 1), clamp(row, 0, ROWS - 1))

# ========== Sistema de Unidades Enemigas ==========

func place_enemy(enemy: Unit, col: int, row: int) -> bool:
	"""Coloca un enemigo en la celda especificada"""
	# Validar posición
	if col < 0 or col >= COLUMNS or row < 0 or row >= ROWS:
		print("Error: Posición fuera de rango: (", col, ", ", row, ")")
		return false
	
	var grid_pos = Vector2i(col, row)
	
	# Verificar si la celda está ocupada
	if is_cell_occupied(col, row):
		print("Error: Celda (", col, ", ", row, ") ya está ocupada")
		return false
	
	# Establecer posición de la unidad
	enemy.set_grid_position(col, row)
	
	# Calcular posición mundial
	var world_pos = get_world_position(col, row)
	enemy.position = to_local(world_pos)
	
	# Agregar unidad al contenedor si no está ya
	if enemy.get_parent() != units_container:
		# Si tiene otro padre, removerlo primero
		if enemy.get_parent():
			enemy.get_parent().remove_child(enemy)
		units_container.add_child(enemy)
	
	# Registrar unidad en el diccionario
	units[grid_pos] = enemy
	
	return true

func remove_enemy(enemy: Unit, grant_loot: bool = false):
	"""Remueve un enemigo del grid
	@param enemy: La unidad enemiga a remover
	@param grant_loot: Si es true, otorga oro al jugador por derrotar al enemigo
	"""
	if not enemy.is_placed():
		return
	
	# Otorgar loot si el enemigo fue derrotado en combate
	if grant_loot and enemy.is_enemy and game_manager:
		var enemy_type = enemy.enemy_type
		game_manager.reward_enemy_kill(enemy_type)
	
	var grid_pos = enemy.get_grid_position()
	# Buscar y remover del diccionario
	for pos in units.keys():
		if units[pos] == enemy:
			units.erase(pos)
			break
	
	enemy.set_grid_position(-1, -1)
	if enemy.get_parent() == units_container:
		units_container.remove_child(enemy)

func on_enemy_died(enemy: Unit):
	"""Se llama cuando un enemigo muere en combate - otorga loot y lo remueve"""
	if not enemy:
		return
	remove_enemy(enemy, true)  # Remover con loot

func set_game_manager(manager: GameManager):
	"""Establece la referencia al GameManager para otorgar loot"""
	game_manager = manager

func clear_all_enemies():
	"""Limpia todos los enemigos del grid"""
	for enemy in units.values():
		if is_instance_valid(enemy):
			enemy.queue_free()
	units.clear()

func is_cell_occupied(col: int, row: int) -> bool:
	"""Verifica si una celda está ocupada por un enemigo"""
	var grid_pos = Vector2i(col, row)
	return units.has(grid_pos)

func get_enemy_at(col: int, row: int) -> Unit:
	"""Obtiene el enemigo en la celda especificada, o null si está vacía"""
	var grid_pos = Vector2i(col, row)
	if units.has(grid_pos):
		return units[grid_pos]
	return null

func get_all_enemies() -> Array:
	"""Obtiene todos los enemigos en el grid"""
	return units.values()
