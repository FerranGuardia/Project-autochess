extends Node2D
class_name Unit

## Unidad básica del juego
## Representación visual con sprite

# Señales
signal drag_started(unit: Unit)
signal drag_ended(unit: Unit, drop_position: Vector2)

# Tipo de unidad
var unit_type: UnitData.UnitType
var unit_name: String

# Posición en el grid
var grid_position: Vector2i = Vector2i(-1, -1)  # -1 significa no colocado

# Referencias
var sprite: Sprite2D
var area: Area2D
var collision_shape: CollisionShape2D

# Estado de drag
var is_dragging: bool = false
var original_position: Vector2
var drag_offset: Vector2

func _ready():
	# El sprite se crea cuando se establece el tipo
	pass

func initialize(type: UnitData.UnitType):
	"""Inicializa la unidad con un tipo específico"""
	unit_type = type
	unit_name = UnitData.get_unit_name(type)
	
	# Crear sprite
	create_sprite()

func create_sprite():
	"""Crea el sprite visual de la unidad"""
	if sprite:
		sprite.queue_free()
	if area:
		area.queue_free()
	
	sprite = Sprite2D.new()
	sprite.name = "Sprite"
	
	# Cargar la textura del sprite
	var sprite_path = UnitData.get_unit_sprite_path(unit_type)
	var texture = load(sprite_path)
	
	if texture:
		sprite.texture = texture
		# Centrar el sprite
		sprite.centered = true
		
		# Escalar el sprite para que quepa en una celda (100x100px)
		var cell_size = 100.0
		var sprite_size = max(texture.get_width(), texture.get_height())
		var scale_factor = cell_size / sprite_size
		# Reducir un poco más para que no toque los bordes (80% del tamaño de celda)
		scale_factor *= 0.8
		sprite.scale = Vector2(scale_factor, scale_factor)
		
		# Crear Area2D para hacer clickeable toda el área del sprite
		create_clickable_area(texture, scale_factor)
	else:
		# Si no se encuentra el sprite, crear un placeholder
		print("Warning: No se encontró el sprite en: ", sprite_path)
		create_placeholder()
	
	add_child(sprite)

func create_clickable_area(texture: Texture2D, scale_factor: float):
	"""Crea un Area2D para hacer clickeable toda el área del sprite"""
	area = Area2D.new()
	area.name = "ClickableArea"
	area.input_pickable = true  # Habilitar detección de input
	
	# Crear CollisionShape2D con el tamaño del sprite
	collision_shape = CollisionShape2D.new()
	var rectangle_shape = RectangleShape2D.new()
	
	# Calcular el tamaño del sprite escalado
	var sprite_width = texture.get_width() * scale_factor
	var sprite_height = texture.get_height() * scale_factor
	rectangle_shape.size = Vector2(sprite_width, sprite_height)
	
	collision_shape.shape = rectangle_shape
	area.add_child(collision_shape)
	
	# Conectar señales de input
	area.input_event.connect(_on_area_input_event)
	area.mouse_entered.connect(_on_mouse_entered)
	area.mouse_exited.connect(_on_mouse_exited)
	
	add_child(area)

func create_placeholder():
	"""Crea un placeholder visual si no hay sprite"""
	# Crear un ColorRect como fallback temporal
	var placeholder = ColorRect.new()
	placeholder.name = "Placeholder"
	placeholder.color = UnitData.get_unit_color(unit_type)
	placeholder.size = Vector2(80, 80)
	placeholder.position = Vector2(-40, -40)  # Centrado
	add_child(placeholder)

func set_grid_position(col: int, row: int):
	"""Establece la posición de la unidad en el grid"""
	grid_position = Vector2i(col, row)

func get_grid_position() -> Vector2i:
	"""Obtiene la posición de la unidad en el grid"""
	return grid_position

func is_placed() -> bool:
	"""Verifica si la unidad está colocada en el tablero o en el banquillo"""
	# Si está en el grid: x >= 0 y y >= 0
	# Si está en el bench: x >= 0 y y == -1
	return grid_position.x >= 0

# ========== Sistema de Drag and Drop ==========

func _on_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	"""Maneja los eventos de input en el área clickeable"""
	if not is_placed():
		return
	
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		
		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			if mouse_event.pressed:
				# Iniciar drag
				start_drag(get_global_mouse_position())
			else:
				# Terminar drag
				if is_dragging:
					end_drag(get_global_mouse_position())

func _on_mouse_entered():
	"""Cuando el mouse entra en el área"""
	# Feedback visual opcional (implementar en el futuro si es necesario)
	pass

func _on_mouse_exited():
	"""Cuando el mouse sale del área"""
	# Remover feedback visual (implementar en el futuro si es necesario)
	pass

func start_drag(mouse_pos: Vector2):
	"""Inicia el arrastre de la unidad"""
	if is_dragging:
		return
	
	is_dragging = true
	original_position = global_position
	drag_offset = global_position - mouse_pos
	
	# Elevar la unidad visualmente (z_index)
	z_index = 10
	
	# Emitir señal
	drag_started.emit(self)
	
	# Habilitar procesamiento de input
	set_process_input(true)

func _input(event: InputEvent):
	"""Maneja el input global durante el drag"""
	if is_dragging:
		if event is InputEventMouseMotion:
			var mouse_event = event as InputEventMouseMotion
			# Mover la unidad siguiendo el mouse
			global_position = get_global_mouse_position() + drag_offset
		elif event is InputEventMouseButton:
			var mouse_event = event as InputEventMouseButton
			if mouse_event.button_index == MOUSE_BUTTON_LEFT and not mouse_event.pressed:
				# Si se suelta el botón durante el drag, terminar el drag
				if is_dragging:
					end_drag(get_global_mouse_position())

func end_drag(mouse_pos: Vector2):
	"""Termina el arrastre de la unidad"""
	if not is_dragging:
		return
	
	is_dragging = false
	z_index = 0
	set_process_input(false)
	
	# Emitir señal con la posición final
	drag_ended.emit(self, mouse_pos)
