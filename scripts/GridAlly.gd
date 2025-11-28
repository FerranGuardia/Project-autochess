extends Node2D
class_name GridAlly

## Grid del tablero aliado (7×5 celdas)
## Visualización y gestión del grid inferior

const CELL_SIZE = 100
const COLUMNS = 7
const ROWS = 5

# Referencia al contenedor de celdas (se crean dinámicamente)
var cells_container: Node2D
var background: Polygon2D

var cells: Array[Polygon2D] = []

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
	"""Crea el grid visual de 7×5 celdas"""
	# Crear fondo del grid
	if not background:
		background = Polygon2D.new()
		background.name = "Background"
		background.color = Color(0.2, 0.2, 1.0, 0.25)  # Azul semitransparente
		var width = float(COLUMNS * CELL_SIZE)
		var height = float(ROWS * CELL_SIZE)
		background.polygon = PackedVector2Array([
			Vector2(-width / 2.0, -height / 2.0),
			Vector2(width / 2.0, -height / 2.0),
			Vector2(width / 2.0, height / 2.0),
			Vector2(-width / 2.0, height / 2.0)
		])
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
	
	# Crear polígono rectangular para la celda
	cell.color = Color(0.3, 0.3, 1.0, 0.1)  # Azul muy transparente
	var cell_size_float = float(CELL_SIZE)
	cell.polygon = PackedVector2Array([
		pos,
		pos + Vector2(cell_size_float, 0),
		pos + Vector2(cell_size_float, cell_size_float),
		pos + Vector2(0, cell_size_float)
	])
	
	# Crear borde de la celda
	var border = create_cell_border(pos, Vector2(cell_size_float, cell_size_float))
	cells_container.add_child(border)
	
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
	
	# Revivir todas las unidades que estaban en el grid inicialmente
	for unit in initial_positions.keys():
		if not is_instance_valid(unit):
			continue
		
		# Revivir la unidad si está muerta
		if not unit.is_alive():
			# Restaurar salud completa
			unit.current_health = unit.max_health
			unit.update_health_bar()
			resurrected_count += 1
			print("Unidad ", unit.unit_name, " revivida")
		
		# Restaurar posición inicial
		var initial_pos = initial_positions[unit]
		if initial_pos.x >= 0 and initial_pos.y >= 0:
			# Remover de posición actual si está en otra
			var current_pos = unit.get_grid_position()
			if current_pos != initial_pos:
				remove_unit(unit)
				place_unit(unit, initial_pos.x, initial_pos.y)
			else:
				# Solo actualizar posición visual si ya está en la posición correcta
				var world_pos = get_world_position(initial_pos.x, initial_pos.y)
				unit.position = to_local(world_pos)
	
	print("Unidades revividas: ", resurrected_count)
	
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
