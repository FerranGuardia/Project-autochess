extends Node2D
class_name Bench

## Banquillo aliado con 10 slots horizontales
## Para almacenar unidades antes de colocarlas en el tablero

const SLOT_SIZE = 100
const SLOT_COUNT = 10

# Referencia al contenedor de slots (se crean dinámicamente)
var slots_container: Node2D = null
var background: Polygon2D = null

var slots: Array[Polygon2D] = []

# Sistema de unidades
var units: Dictionary = {}  # Key: int(slot_index), Value: Unit
var units_container: Node2D = null

# Sistema de drag and drop
var dragged_unit: Unit = null
var highlight_slot: Polygon2D = null

func _ready():
	create_bench()
	setup_units_container()
	setup_drag_drop()

func _process(_delta):
	# Actualizar feedback visual durante el drag
	if dragged_unit:
		update_drag_feedback()

func setup_units_container():
	"""Crea el contenedor para las unidades"""
	if not units_container:
		units_container = Node2D.new()
		units_container.name = "UnitsContainer"
		add_child(units_container)

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

func create_bench():
	"""Crea el banquillo con 10 slots horizontales"""
	# Crear fondo del banquillo
	if not background:
		background = Polygon2D.new()
		background.name = "Background"
		background.color = Color(0.3, 0.3, 0.3, 0.3)  # Gris semitransparente
		var width = float(SLOT_COUNT * SLOT_SIZE)
		var height = float(SLOT_SIZE)
		background.polygon = PackedVector2Array([
			Vector2(-width / 2.0, -height / 2.0),
			Vector2(width / 2.0, -height / 2.0),
			Vector2(width / 2.0, height / 2.0),
			Vector2(-width / 2.0, height / 2.0)
		])
		add_child(background)
	
	# Crear contenedor de slots si no existe
	if not slots_container:
		slots_container = Node2D.new()
		slots_container.name = "SlotsContainer"
		add_child(slots_container)
	
	# Crear cada slot del banquillo
	for i in range(SLOT_COUNT):
		create_slot(i)

func create_slot(index: int):
	"""Crea un slot individual en el banquillo"""
	var slot = Polygon2D.new()
	slot.name = "Slot_%d" % index
	
	# Tamaño y posición del slot
	var x = (float(index) - float(SLOT_COUNT) / 2.0 + 0.5) * float(SLOT_SIZE)
	var pos = Vector2(x - float(SLOT_SIZE) / 2.0, -float(SLOT_SIZE) / 2.0)
	
	# Crear polígono rectangular para el slot
	slot.color = Color(0.4, 0.4, 0.4, 0.2)  # Gris muy transparente
	var slot_size_float = float(SLOT_SIZE)
	slot.polygon = PackedVector2Array([
		pos,
		pos + Vector2(slot_size_float, 0),
		pos + Vector2(slot_size_float, slot_size_float),
		pos + Vector2(0, slot_size_float)
	])
	
	# Crear borde del slot
	var border = create_slot_border(pos, Vector2(slot_size_float, slot_size_float))
	slots_container.add_child(border)
	
	slots_container.add_child(slot)
	slots.append(slot)

func create_slot_border(pos: Vector2, size: Vector2) -> Line2D:
	"""Crea el borde visual de un slot"""
	var border = Line2D.new()
	border.width = 2.0
	border.default_color = Color(0.6, 0.6, 0.6, 0.6)  # Gris claro semitransparente
	
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

func get_world_position(slot_index: int) -> Vector2:
	"""Convierte índice de slot a posición mundial"""
	var x = (float(slot_index) - float(SLOT_COUNT) / 2.0 + 0.5) * float(SLOT_SIZE)
	return global_position + Vector2(x, 0)

func get_slot_index(world_pos: Vector2) -> int:
	"""Convierte posición mundial a índice de slot"""
	var local_pos = to_local(world_pos)
	var index = int((local_pos.x / float(SLOT_SIZE)) + float(SLOT_COUNT) / 2.0)
	return clamp(index, 0, SLOT_COUNT - 1)

# ========== Sistema de Unidades ==========

func place_unit(unit: Unit, slot_index: int) -> bool:
	"""Coloca una unidad en el slot especificado"""
	# Validar índice
	if slot_index < 0 or slot_index >= SLOT_COUNT:
		print("Error: Slot fuera de rango: ", slot_index)
		return false
	
	# Verificar si el slot está ocupado (excepto si es la misma unidad moviéndose)
	var existing_unit = get_unit_at(slot_index)
	if existing_unit and existing_unit != unit:
		print("Error: Slot ", slot_index, " ya está ocupado")
		return false
	
	# Remover unidad de su slot anterior si tiene uno
	if unit.is_placed():
		# Buscar y remover del diccionario
		for old_slot in units.keys():
			if units[old_slot] == unit:
				units.erase(old_slot)
				break
		# Remover del contenedor si está aquí
		if unit.get_parent() == units_container:
			units_container.remove_child(unit)
	
	# Establecer posición de la unidad (no usa grid_position, usa slot_index)
	# Para el banquillo, usamos slot_index en lugar de grid_position
	unit.set_grid_position(slot_index, -1)  # -1 en Y indica que está en el banquillo
	
	# Calcular posición mundial
	var world_pos = get_world_position(slot_index)
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
	units[slot_index] = unit
	
	return true

func remove_unit(unit: Unit):
	"""Remueve una unidad del banquillo"""
	# Buscar el slot de la unidad y removerlo
	for slot_index in units.keys():
		if units[slot_index] == unit:
			units.erase(slot_index)
			break
	
	unit.set_grid_position(-1, -1)
	if unit.get_parent() == units_container:
		units_container.remove_child(unit)

func is_slot_occupied(slot_index: int) -> bool:
	"""Verifica si un slot está ocupado por una unidad"""
	return units.has(slot_index)

func get_unit_at(slot_index: int) -> Unit:
	"""Obtiene la unidad en el slot especificado, o null si está vacío"""
	if units.has(slot_index):
		return units[slot_index]
	return null

func is_bench_full() -> bool:
	"""Verifica si el banquillo está lleno"""
	return units.size() >= SLOT_COUNT

# ========== Sistema de Drag and Drop ==========

func _on_unit_drag_started(unit: Unit):
	"""Se llama cuando se inicia el drag de una unidad"""
	if dragged_unit == unit:
		return
	
	dragged_unit = unit
	create_highlight_slot()

func _on_unit_drag_ended(unit: Unit, drop_position: Vector2):
	"""Se llama cuando se termina el drag de una unidad"""
	# Guardar si la unidad estaba originalmente en el bench
	var was_in_bench = false
	var original_slot = -1
	for slot in units.keys():
		if units[slot] == unit:
			was_in_bench = true
			original_slot = slot
			break
	
	# Limpiar estado de drag local
	if dragged_unit == unit:
		dragged_unit = null
		remove_highlight_slot()
	
	# Siempre delegar al Board para manejar el drop
	# El Board decidirá si va al grid o al bench
	var board = get_parent() as Board
	if board:
		var valid_drop = board.handle_unit_drop(unit, drop_position)
		
		# Si no fue un drop válido, restaurar posición original
		if not valid_drop:
			if was_in_bench and original_slot >= 0:
				# Restaurar en el bench
				var world_pos = get_world_position(original_slot)
				unit.position = to_local(world_pos)
			else:
				# Si venía del grid, el grid manejará la restauración
				pass

func update_drag_feedback():
	"""Actualiza el feedback visual durante el drag (para unidades de este bench)"""
	if not dragged_unit:
		return
	update_drag_feedback_external(dragged_unit)

func update_drag_feedback_external(unit: Unit):
	"""Actualiza el feedback visual durante el drag (para cualquier unidad)"""
	if not unit:
		remove_highlight_slot()
		return
	
	# Obtener posición del mouse en coordenadas globales
	var mouse_pos = get_global_mouse_position()
	
	# Convertir a coordenadas locales del banquillo
	var local_mouse = to_local(mouse_pos)
	
	# Verificar que el mouse esté sobre el área del banquillo
	var bench_width = float(SLOT_COUNT * SLOT_SIZE)
	var bench_height = float(SLOT_SIZE)
	
	# Verificar si está dentro del área del banquillo
	if abs(local_mouse.x) <= bench_width / 2.0 and abs(local_mouse.y) <= bench_height / 2.0:
		# Calcular índice de slot
		var slot_index = get_slot_index(mouse_pos)
		if slot_index >= 0 and slot_index < SLOT_COUNT:
			update_highlight_slot(slot_index)
		else:
			remove_highlight_slot()
	else:
		remove_highlight_slot()

func create_highlight_slot():
	"""Crea el indicador visual de slot"""
	if highlight_slot:
		return
	
	highlight_slot = Polygon2D.new()
	highlight_slot.name = "HighlightSlot"
	slots_container.add_child(highlight_slot)
	highlight_slot.z_index = 5  # Por encima de los slots normales

func update_highlight_slot(slot_index: int):
	"""Actualiza la posición y color del highlight"""
	if not highlight_slot:
		create_highlight_slot()
	
	# Calcular posición del slot
	var x = (float(slot_index) - float(SLOT_COUNT) / 2.0 + 0.5) * float(SLOT_SIZE)
	var pos = Vector2(x - float(SLOT_SIZE) / 2.0, -float(SLOT_SIZE) / 2.0)
	
	# Crear polígono para el highlight
	var slot_size_float = float(SLOT_SIZE)
	highlight_slot.polygon = PackedVector2Array([
		pos,
		pos + Vector2(slot_size_float, 0),
		pos + Vector2(slot_size_float, slot_size_float),
		pos + Vector2(0, slot_size_float)
	])
	
	# Color según si el slot está ocupado
	var existing_unit = get_unit_at(slot_index)
	if existing_unit and existing_unit != dragged_unit:
		# Rojo si está ocupado
		highlight_slot.color = Color(1.0, 0.2, 0.2, 0.5)
	else:
		# Verde si está libre
		highlight_slot.color = Color(0.2, 1.0, 0.2, 0.5)

func remove_highlight_slot():
	"""Remueve el indicador visual"""
	if highlight_slot:
		highlight_slot.queue_free()
		highlight_slot = null
