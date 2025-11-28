extends Node2D
class_name GridEnemy

## Grid del tablero enemigo (7×5 celdas)
## Visualización y gestión del grid superior

const CELL_SIZE = 100
const COLUMNS = 7
const ROWS = 5

# Referencia al contenedor de celdas (se crean dinámicamente)
var cells_container: Node2D
var background: Node2D  # Puede ser Sprite2D o Polygon2D

var cells: Array[Polygon2D] = []

# Sistema de unidades enemigas
var units: Dictionary = {}  # Key: Vector2i(grid_position), Value: Unit
var units_container: Node2D

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
	"""Crea el grid visual de 7×5 celdas con arena"""
	# Crear fondo de arena con sprite (o fallback a Polygon2D)
	if not background:
		var arena_path = "res://assets/sprites/arena/arena_enemy.png"
		var arena_texture = null
		
		# Intentar cargar la textura
		if ResourceLoader.exists(arena_path):
			var resource = ResourceLoader.load(arena_path)
			if resource != null and resource is Texture2D:
				arena_texture = resource
		
		if arena_texture != null:
			# Usar Sprite2D con la arena generada
			var sprite = Sprite2D.new()
			sprite.name = "Background"
			sprite.texture = arena_texture
			sprite.centered = true
			
			# Escalar si es necesario (debe ser 700×500px)
			var grid_width = float(COLUMNS * CELL_SIZE)  # 700px
			var grid_height = float(ROWS * CELL_SIZE)    # 500px
			var tex_width = arena_texture.get_width()
			var tex_height = arena_texture.get_height()
			
			if tex_width > 0 and tex_height > 0:
				sprite.scale = Vector2(
					grid_width / tex_width,
					grid_height / tex_height
				)
			
			sprite.z_index = -1  # Detrás de las unidades
			background = sprite
			print("✓ Arena enemiga cargada desde sprite")
		else:
			# Fallback: usar Polygon2D temporal
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
			print("⚠ Arena enemiga no encontrada, usando fallback. Ejecuta generate_arena.gd para generar las arenas.")
		
		add_child(background)
	
	# Crear contenedor de celdas si no existe
	if not cells_container:
		cells_container = Node2D.new()
		cells_container.name = "CellsContainer"
		add_child(cells_container)
	
	# Crear cada celda del grid
	for row in range(ROWS):
		for col in range(COLUMNS):
			create_cell(col, row)

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
