extends Node2D
class_name GridAlly

## Grid del tablero aliado (7×5 celdas)
## Visualización y gestión del grid inferior

const CELL_SIZE = 100
const COLUMNS = 7
const ROWS = 5

# Referencia al contenedor de celdas (se crean dinámicamente)
var cells_container: Node2D
var tiles_container: Node2D  # Contenedor para los tiles individuales del grid
var decorative_tiles_container: Node2D  # Contenedor para tiles decorativos alrededor
var background: Node2D  # Fallback Polygon2D si no hay tiles

var cells: Array[Polygon2D] = []
var tiles: Array[Sprite2D] = []  # Array de sprites de tiles del grid
var decorative_tiles: Array[Sprite2D] = []  # Array de sprites de tiles decorativos

# Sistema de unidades
var units: Dictionary = {}  # Key: Vector2i(grid_position), Value: Unit
var units_container: Node2D

# Límite de unidades en el grid
const MAX_UNITS_ON_GRID: int = 10

# Sistema de drag and drop
var dragged_unit: Unit = null
var highlight_cell: Polygon2D = null

func _ready():
	create_grid()
	setup_units_container()
	setup_drag_drop()

func _process(_delta):
	# Actualizar feedback visual durante el drag
	if dragged_unit:
		update_drag_feedback()

func setup_drag_drop():
	"""Configura el sistema de drag and drop"""
	# Conectar señales de todas las unidades existentes
	for unit in units.values():
		connect_unit_signals(unit)

func connect_unit_signals(unit: Unit):
	"""Conecta las señales de una unidad"""
	if not unit.drag_started.is_connected(_on_unit_drag_started):
		unit.drag_started.connect(_on_unit_drag_started)
	if not unit.drag_ended.is_connected(_on_unit_drag_ended):
		unit.drag_ended.connect(_on_unit_drag_ended)
	
	# También conectar al Board para coordinación global
	var board = get_parent() as Board
	if board:
		if not unit.drag_started.is_connected(board.on_unit_drag_started):
			unit.drag_started.connect(board.on_unit_drag_started)
		if not unit.drag_ended.is_connected(board.on_unit_drag_ended):
			unit.drag_ended.connect(board.on_unit_drag_ended)

func setup_units_container():
	"""Crea el contenedor para las unidades"""
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
	
	# Crear contenedor para tiles decorativos si no existe
	if not decorative_tiles_container:
		decorative_tiles_container = Node2D.new()
		decorative_tiles_container.name = "DecorativeTilesContainer"
		add_child(decorative_tiles_container)
		decorative_tiles_container.z_index = -2  # Detrás de los tiles del grid
	
	# Cargar y colocar tiles individuales del grid
	load_and_place_tiles()
	
	# Cargar y colocar tiles decorativos alrededor
	load_and_place_decorative_tiles()
	
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
	
	# Colocar tiles en cada celda del grid (7×5 = 35 tiles)
	for row in range(ROWS):
		for col in range(COLUMNS):
			var tile_sprite = load_tile_for_cell(col, row)
			if tile_sprite:
				# Calcular posición de la celda
				var cell_pos = get_world_position(col, row)
				tile_sprite.position = to_local(cell_pos)
				tile_sprite.z_index = -1
				
				tiles_container.add_child(tile_sprite)
				tiles.append(tile_sprite)
				tiles_loaded += 1
	
	if tiles_loaded > 0:
		print("✓ Tiles cargados para arena aliada: ", tiles_loaded, " de ", COLUMNS * ROWS)
	else:
		print("⚠ No se encontraron tiles para arena aliada. Usando fallback.")

func load_tile_for_cell(col: int, row: int) -> Sprite2D:
	"""Intenta cargar un tile específico para una celda"""
	# Calcular índice del tile (0-34 para grid 7×5)
	var tile_index = row * COLUMNS + col
	
	# Intentar cargar tile específico primero
	var specific_tile_path = "res://assets/sprites/arena/tiles/ally/tile_ally_%02d.png" % tile_index
	if ResourceLoader.exists(specific_tile_path):
		var texture = load(specific_tile_path) as Texture2D
		if texture:
			var sprite = Sprite2D.new()
			sprite.texture = texture
			sprite.centered = false
			sprite.name = "Tile_%d_%d" % [col, row]
			return sprite
	
	# Si no existe tile específico, intentar cargar tiles genéricos en orden
	# Esto permite crear tiles gradualmente
	for i in range(10):  # Intentar hasta 10 tiles genéricos
		var generic_tile_path = "res://assets/sprites/arena/tiles/ally/tile_ally_%02d.png" % i
		if ResourceLoader.exists(generic_tile_path):
			var texture = load(generic_tile_path) as Texture2D
			if texture:
				var sprite = Sprite2D.new()
				sprite.texture = texture
				sprite.centered = false
				sprite.name = "Tile_%d_%d" % [col, row]
				return sprite
	
	# Si no hay tiles, retornar null (se usará fallback)
	return null

func load_and_place_decorative_tiles():
	"""Carga y coloca tiles decorativos alrededor del grid de combate"""
	decorative_tiles.clear()
	
	# Limpiar tiles decorativos anteriores
	for child in decorative_tiles_container.get_children():
		child.queue_free()
	
	var tiles_loaded = 0
	
	# Calcular dimensiones del grid
	var grid_width = float(COLUMNS * CELL_SIZE)  # 700px
	var grid_height = float(ROWS * CELL_SIZE)    # 500px
	
	# Calcular posiciones de los bordes
	var left_edge = -grid_width / 2.0
	var right_edge = grid_width / 2.0
	var top_edge = -grid_height / 2.0
	var bottom_edge = grid_height / 2.0
	
	# Colocar tiles decorativos alrededor del grid
	# Arriba: 7 tiles (una fila completa)
	for col in range(COLUMNS):
		var tile = load_decorative_tile("top", col)
		if tile:
			var x = (float(col) - float(COLUMNS) / 2.0 + 0.5) * float(CELL_SIZE)
			var y = top_edge - float(CELL_SIZE) / 2.0
			tile.position = Vector2(x, y)
			tile.z_index = -2
			decorative_tiles_container.add_child(tile)
			decorative_tiles.append(tile)
			tiles_loaded += 1
	
	# Abajo: 7 tiles (una fila completa)
	for col in range(COLUMNS):
		var tile = load_decorative_tile("bottom", col)
		if tile:
			var x = (float(col) - float(COLUMNS) / 2.0 + 0.5) * float(CELL_SIZE)
			var y = bottom_edge + float(CELL_SIZE) / 2.0
			tile.position = Vector2(x, y)
			tile.z_index = -2
			decorative_tiles_container.add_child(tile)
			decorative_tiles.append(tile)
			tiles_loaded += 1
	
	# Izquierda: 5 tiles (una columna completa, sin esquinas)
	for row in range(ROWS):
		var tile = load_decorative_tile("left", row)
		if tile:
			var x = left_edge - float(CELL_SIZE) / 2.0
			var y = (float(row) - float(ROWS) / 2.0 + 0.5) * float(CELL_SIZE)
			tile.position = Vector2(x, y)
			tile.z_index = -2
			decorative_tiles_container.add_child(tile)
			decorative_tiles.append(tile)
			tiles_loaded += 1
	
	# Derecha: 5 tiles (una columna completa, sin esquinas)
	for row in range(ROWS):
		var tile = load_decorative_tile("right", row)
		if tile:
			var x = right_edge + float(CELL_SIZE) / 2.0
			var y = (float(row) - float(ROWS) / 2.0 + 0.5) * float(CELL_SIZE)
			tile.position = Vector2(x, y)
			tile.z_index = -2
			decorative_tiles_container.add_child(tile)
			decorative_tiles.append(tile)
			tiles_loaded += 1
	
	# Esquinas: 4 tiles
	var corner_positions = [
		{"side": "top_left", "pos": Vector2(left_edge - float(CELL_SIZE) / 2.0, top_edge - float(CELL_SIZE) / 2.0)},
		{"side": "top_right", "pos": Vector2(right_edge + float(CELL_SIZE) / 2.0, top_edge - float(CELL_SIZE) / 2.0)},
		{"side": "bottom_left", "pos": Vector2(left_edge - float(CELL_SIZE) / 2.0, bottom_edge + float(CELL_SIZE) / 2.0)},
		{"side": "bottom_right", "pos": Vector2(right_edge + float(CELL_SIZE) / 2.0, bottom_edge + float(CELL_SIZE) / 2.0)}
	]
	
	for corner in corner_positions:
		var tile = load_decorative_tile(corner.side, 0)
		if tile:
			tile.position = corner.pos
			tile.z_index = -2
			decorative_tiles_container.add_child(tile)
			decorative_tiles.append(tile)
			tiles_loaded += 1
	
	if tiles_loaded > 0:
		print("✓ Tiles decorativos cargados para arena aliada: ", tiles_loaded)
	else:
		print("⚠ No se encontraron tiles decorativos para arena aliada")

func load_decorative_tile(side: String, index: int) -> Sprite2D:
	"""Carga un tile decorativo específico para un lado o esquina"""
	# Intentar cargar tile específico: decorative_ally_top_00.png, etc.
	var specific_path = "res://assets/sprites/arena/decorative/ally/decorative_ally_%s_%02d.png" % [side, index]
	if ResourceLoader.exists(specific_path):
		var texture = load(specific_path) as Texture2D
		if texture:
			var sprite = Sprite2D.new()
			sprite.texture = texture
			sprite.centered = false
			sprite.name = "Decorative_%s_%d" % [side, index]
			return sprite
	
	# Si no existe específico, intentar cargar genérico para ese lado
	var generic_path = "res://assets/sprites/arena/decorative/ally/decorative_ally_%s_00.png" % side
	if ResourceLoader.exists(generic_path):
		var texture = load(generic_path) as Texture2D
		if texture:
			var sprite = Sprite2D.new()
			sprite.texture = texture
			sprite.centered = false
			sprite.name = "Decorative_%s_%d" % [side, index]
			return sprite
	
	# Si no hay tiles, retornar null
	return null

func create_fallback_background():
	"""Crea un fondo temporal si no hay tiles disponibles"""
	if background:
		return
	
	var polygon = Polygon2D.new()
	polygon.name = "Background"
	polygon.color = Color(0.2, 0.2, 1.0, 0.25)  # Azul semitransparente
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
	print("⚠ Usando fondo temporal. Crea tiles en assets/sprites/arena/tiles/ally/")

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
	# Los bordes se crean dinámicamente en update_highlight_cell()
	
	cells_container.add_child(cell)
	cells.append(cell)

func create_cell_border(pos: Vector2, size: Vector2) -> Line2D:
	"""Crea el borde visual de una celda"""
	var border = Line2D.new()
	border.width = 2.0
	border.default_color = Color(0.5, 0.5, 1.0, 0.5)  # Azul claro semitransparente
	
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

# ========== Sistema de Unidades ==========

func place_unit(unit: Unit, col: int, row: int) -> bool:
	"""Coloca una unidad en la celda especificada"""
	# Validar posición
	if col < 0 or col >= COLUMNS or row < 0 or row >= ROWS:
		print("Error: Posición fuera de rango: (", col, ", ", row, ")")
		return false
	
	var grid_pos = Vector2i(col, row)
	
	# Verificar límite de unidades (solo si la unidad no está ya en el grid)
	var current_pos = unit.get_grid_position()
	var is_already_on_grid = current_pos.x >= 0 and current_pos.y >= 0
	
	if not is_already_on_grid:
		# Contar unidades en el grid (solo las que están en el grid, no en el banquillo)
		var units_on_grid = 0
		for pos in units.keys():
			if pos.y >= 0:  # Solo contar unidades en el grid (y >= 0)
				units_on_grid += 1
		
		if units_on_grid >= MAX_UNITS_ON_GRID:
			print("Error: Máximo de ", MAX_UNITS_ON_GRID, " unidades permitidas en el grid. Actual: ", units_on_grid)
			return false
	
	# Verificar si la celda está ocupada (excepto si es la misma unidad moviéndose)
	var existing_unit = get_unit_at(col, row)
	if existing_unit and existing_unit != unit:
		print("Error: Celda (", col, ", ", row, ") ya está ocupada")
		return false
	
	# Remover unidad de su posición anterior si tiene una
	if unit.is_placed():
		var old_pos = unit.get_grid_position()
		if units.has(old_pos):
			units.erase(old_pos)
		# Remover del contenedor si está aquí
		if unit.get_parent() == units_container:
			units_container.remove_child(unit)
	
	# Establecer posición de la unidad
	unit.set_grid_position(col, row)
	
	# Calcular posición mundial
	var world_pos = get_world_position(col, row)
	unit.position = to_local(world_pos)
	
	# Agregar unidad al contenedor si no está ya
	if unit.get_parent() != units_container:
		# Si tiene otro padre, removerlo primero
		if unit.get_parent():
			unit.get_parent().remove_child(unit)
		units_container.add_child(unit)
		# Conectar señales si es nueva
		connect_unit_signals(unit)
	
	# Registrar unidad en el diccionario
	units[grid_pos] = unit
	
	return true

func remove_unit(unit: Unit):
	"""Remueve una unidad del grid"""
	if not unit.is_placed():
		return
	
	var grid_pos = unit.get_grid_position()
	# Buscar y remover del diccionario (por si acaso la posición cambió)
	for pos in units.keys():
		if units[pos] == unit:
			units.erase(pos)
			break
	
	unit.set_grid_position(-1, -1)
	if unit.get_parent() == units_container:
		units_container.remove_child(unit)

func is_cell_occupied(col: int, row: int) -> bool:
	"""Verifica si una celda está ocupada por una unidad"""
	var grid_pos = Vector2i(col, row)
	return units.has(grid_pos)

func get_unit_at(col: int, row: int) -> Unit:
	"""Obtiene la unidad en la celda especificada, o null si está vacía"""
	var grid_pos = Vector2i(col, row)
	if units.has(grid_pos):
		return units[grid_pos]
	return null

func get_all_units() -> Array:
	"""Obtiene todas las unidades en el grid"""
	return units.values()

func get_units_count_on_grid() -> int:
	"""Obtiene el número de unidades en el grid (excluyendo banquillo)"""
	var count = 0
	for pos in units.keys():
		if pos.y >= 0:  # Solo contar unidades en el grid (y >= 0)
			count += 1
	return count

# ========== Sistema de Resurrección ==========

var initial_positions: Dictionary = {}  # Key: Unit, Value: Vector2i (posición inicial)

func save_initial_positions():
	"""Guarda las posiciones iniciales de todas las unidades antes del combate"""
	initial_positions.clear()
	for unit in units.values():
		if unit and unit.get_grid_position().y >= 0:  # Solo unidades en el grid
			initial_positions[unit] = unit.get_grid_position()
	print("Posiciones iniciales guardadas: ", initial_positions.size(), " unidades")

func resurrect_all_units():
	"""Revive todas las unidades aliadas y las restaura a sus posiciones iniciales"""
	var resurrected_count = 0
	
	# Primero, remover todas las unidades del diccionario para evitar conflictos
	var units_to_restore = []
	for unit in initial_positions.keys():
		if not is_instance_valid(unit):
			continue
		
		# Remover de la posición actual del diccionario
		var current_pos = unit.get_grid_position()
		if current_pos.x >= 0 and current_pos.y >= 0:
			# Remover del diccionario si está registrada
			if units.has(current_pos) and units[current_pos] == unit:
				units.erase(current_pos)
		
		# Guardar información para restaurar
		var initial_pos = initial_positions[unit]
		units_to_restore.append({"unit": unit, "pos": initial_pos})
	
	# Ahora restaurar todas las unidades
	var healed_count = 0
	for data in units_to_restore:
		var unit = data["unit"]
		var initial_pos = data["pos"]
		
		if not is_instance_valid(unit):
			continue
		
		# Curar completamente todas las unidades (vivas o muertas)
		var was_dead = not unit.is_alive()
		var had_damage = unit.current_health < unit.max_health
		
		# Restaurar salud completa
		unit.current_health = unit.max_health
		unit.update_health_bar()
		
		# Contar unidades que necesitaban curación
		if was_dead:
			resurrected_count += 1
			print("Unidad ", unit.unit_name, " revivida")
		elif had_damage:
			healed_count += 1
			print("Unidad ", unit.unit_name, " curada completamente")
		
		# Restaurar posición inicial
		if initial_pos.x >= 0 and initial_pos.y >= 0:
			# Establecer posición de la unidad
			unit.set_grid_position(initial_pos.x, initial_pos.y)
			
			# Calcular posición mundial
			var world_pos = get_world_position(initial_pos.x, initial_pos.y)
			unit.position = to_local(world_pos)
			
			# Asegurar que la unidad esté en el contenedor
			if unit.get_parent() != units_container:
				if unit.get_parent():
					unit.get_parent().remove_child(unit)
				units_container.add_child(unit)
				connect_unit_signals(unit)
			
			# Registrar en el diccionario
			var grid_pos = Vector2i(initial_pos.x, initial_pos.y)
			units[grid_pos] = unit
	
	print("Unidades revividas: ", resurrected_count, ", Unidades curadas: ", healed_count)
	
	# Limpiar posiciones iniciales después de resucitar
	initial_positions.clear()

# ========== Sistema de Drag and Drop ==========

func _on_unit_drag_started(unit: Unit):
	"""Se llama cuando se inicia el drag de una unidad"""
	if dragged_unit == unit:
		return
	
	dragged_unit = unit
	create_highlight_cell()

func _on_unit_drag_ended(unit: Unit, drop_position: Vector2):
	"""Se llama cuando se termina el drag de una unidad"""
	# Guardar si la unidad estaba originalmente en el grid
	var was_in_grid = false
	var original_col = -1
	var original_row = -1
	var original_pos = unit.get_grid_position()
	if original_pos.x >= 0 and original_pos.y >= 0:
		was_in_grid = true
		original_col = original_pos.x
		original_row = original_pos.y
	
	# Limpiar estado de drag local
	if dragged_unit == unit:
		dragged_unit = null
		remove_highlight_cell()
	
	# Siempre delegar al Board para manejar el drop
	# El Board decidirá si va al grid o al bench
	var board = get_parent() as Board
	if board:
		var valid_drop = board.handle_unit_drop(unit, drop_position)
		
		# Si no fue un drop válido, restaurar posición original
		if not valid_drop:
			if was_in_grid and original_col >= 0 and original_row >= 0:
				# Restaurar en el grid
				var world_pos = get_world_position(original_col, original_row)
				unit.position = to_local(world_pos)
			else:
				# Si venía del bench, el bench manejará la restauración
				pass

func update_drag_feedback():
	"""Actualiza el feedback visual durante el drag (para unidades de este grid)"""
	if not dragged_unit:
		return
	update_drag_feedback_external(dragged_unit)

func update_drag_feedback_external(unit: Unit):
	"""Actualiza el feedback visual durante el drag (para cualquier unidad)"""
	if not unit:
		return
	
	# Obtener posición del mouse en coordenadas del grid
	var mouse_pos = get_global_mouse_position()
	var grid_pos = get_grid_position(mouse_pos)
	var col = grid_pos.x
	var row = grid_pos.y
	
	# Actualizar highlight solo si el mouse está sobre este grid
	if col >= 0 and col < COLUMNS and row >= 0 and row < ROWS:
		# Verificar que el mouse esté realmente sobre el área del grid
		var local_mouse = to_local(mouse_pos)
		var grid_width = float(COLUMNS * CELL_SIZE)
		var grid_height = float(ROWS * CELL_SIZE)
		if abs(local_mouse.x) <= grid_width / 2.0 and abs(local_mouse.y) <= grid_height / 2.0:
			update_highlight_cell(col, row)
		else:
			remove_highlight_cell()
	else:
		remove_highlight_cell()

func create_highlight_cell():
	"""Crea el indicador visual de celda"""
	if highlight_cell:
		return
	
	highlight_cell = Polygon2D.new()
	highlight_cell.name = "HighlightCell"
	cells_container.add_child(highlight_cell)
	highlight_cell.z_index = 5  # Por encima de las celdas normales

func update_highlight_cell(col: int, row: int):
	"""Actualiza la posición y color del highlight"""
	if not highlight_cell:
		create_highlight_cell()
	
	# Calcular posición de la celda
	var x = (float(col) - float(COLUMNS) / 2.0 + 0.5) * float(CELL_SIZE)
	var y = (float(row) - float(ROWS) / 2.0 + 0.5) * float(CELL_SIZE)
	var pos = Vector2(x - float(CELL_SIZE) / 2.0, y - float(CELL_SIZE) / 2.0)
	
	# Crear polígono para el highlight
	var cell_size_float = float(CELL_SIZE)
	highlight_cell.polygon = PackedVector2Array([
		pos,
		pos + Vector2(cell_size_float, 0),
		pos + Vector2(cell_size_float, cell_size_float),
		pos + Vector2(0, cell_size_float)
	])
	
	# Color según si la celda está ocupada
	var existing_unit = get_unit_at(col, row)
	if existing_unit and existing_unit != dragged_unit:
		# Rojo si está ocupada
		highlight_cell.color = Color(1.0, 0.2, 0.2, 0.5)
	else:
		# Verde si está libre
		highlight_cell.color = Color(0.2, 1.0, 0.2, 0.5)

func remove_highlight_cell():
	"""Remueve el indicador visual"""
	if highlight_cell:
		highlight_cell.queue_free()
		highlight_cell = null
