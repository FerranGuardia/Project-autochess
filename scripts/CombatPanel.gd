extends Control
class_name CombatPanel

## Panel de información de combate
## Muestra: Oro, Ronda, Vidas, Fase, Temporizador
## Posicionado 200px arriba del tablero, centrado

# Constantes de alineación
const HORIZONTAL_ALIGNMENT_LEFT = 0
const HORIZONTAL_ALIGNMENT_CENTER = 1
const HORIZONTAL_ALIGNMENT_RIGHT = 2

# Referencias
var game_manager: GameManager = null

# Nodos de UI
var combat_panel: Panel = null
var round_label: Label = null
var lives_label: Label = null
var phase_label: Label = null
var timer_label: Label = null
var start_combat_button: Button = null

# Constantes de UI
const PANEL_WIDTH = 600
const PANEL_HEIGHT = 100
# Posición: 200px arriba del tablero, centrado
# Grid enemigo centro está en Y = -250 (coordenadas mundo)
# En viewport (Control): centro Y = 540, grid enemigo se renderiza en Y = 290
# 200px arriba: Y = 90 (en viewport)
# Centrado horizontalmente: X = (1920 - 800) / 2 = 560

# Márgenes del panel
const PANEL_MARGIN = 10

func _ready():
	# Esperar un frame para que Board esté listo
	await get_tree().process_frame
	if not game_manager:
		setup_references()
	
	# Esperar otro frame para asegurar que game_manager esté completamente inicializado
	await get_tree().process_frame
	
	if game_manager and not combat_panel:  # Solo crear UI si no existe y game_manager está disponible
		connect_signals()
		create_ui()
		# Actualizar UI con valores iniciales después de crear
		# Esperar un frame adicional para asegurar que la UI esté completamente creada
		await get_tree().process_frame
		update_all_displays()
	elif game_manager and combat_panel:
		# Si ya existe, solo conectar señales y actualizar
		connect_signals()
		await get_tree().process_frame
		update_all_displays()

func setup_references():
	"""Obtiene referencias automáticamente"""
	var board = get_node_or_null("/root/Board") as Board
	if not board:
		board = get_node_or_null("../../Board") as Board
	
	if board:
		game_manager = board.game_manager
		if game_manager:
			connect_signals()
			create_ui()

func connect_signals():
	"""Conecta todas las señales necesarias"""
	if game_manager:
		if not game_manager.round_changed.is_connected(_on_round_changed):
			game_manager.round_changed.connect(_on_round_changed)
		if not game_manager.lives_changed.is_connected(_on_lives_changed):
			game_manager.lives_changed.connect(_on_lives_changed)
		if not game_manager.phase_changed.is_connected(_on_phase_changed):
			game_manager.phase_changed.connect(_on_phase_changed)
		if not game_manager.preparation_time_changed.is_connected(_on_preparation_time_changed):
			game_manager.preparation_time_changed.connect(_on_preparation_time_changed)
		if not game_manager.combat_time_changed.is_connected(_on_combat_time_changed):
			game_manager.combat_time_changed.connect(_on_combat_time_changed)
		if not game_manager.interface_time_changed.is_connected(_on_interface_time_changed):
			game_manager.interface_time_changed.connect(_on_interface_time_changed)

func create_ui():
	"""Crea el panel de combate"""
	# Evitar crear UI dos veces
	if combat_panel:
		return
	
	# Panel principal
	combat_panel = Panel.new()
	combat_panel.name = "CombatPanel"
	combat_panel.custom_minimum_size = Vector2(PANEL_WIDTH, PANEL_HEIGHT)
	# Centrar horizontalmente: X = (1920 - 600) / 2 = 660 en píxeles de pantalla
	# Y: 200px arriba del tablero (grid enemigo centro en -250, así que -250 - 200 = -450)
	# Pero en coordenadas de Control, Y = 0 es arriba, así que necesitamos convertir
	# Viewport: Y va de 0 (arriba) a 1080 (abajo)
	# Mundo: Y va de -540 (arriba) a +540 (abajo)
	# Grid enemigo centro: Y = -250 en mundo = 540 - 250 = 290 en viewport
	# 200px arriba: 290 - 200 = 90 en viewport
	combat_panel.position = Vector2(660, 90)  # Centrado X, 200px arriba del grid
	add_child(combat_panel)
	
	# Contenedor principal horizontal para distribuir elementos
	var main_container = HBoxContainer.new()
	main_container.name = "MainContainer"
	main_container.set_anchors_preset(Control.PRESET_FULL_RECT)
	main_container.add_theme_constant_override("separation", 20)
	combat_panel.add_child(main_container)
	
	# ========== CENTRO: Ronda, Vidas, Fase ==========
	var center_container = VBoxContainer.new()
	center_container.name = "CenterContainer"
	center_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	center_container.add_theme_constant_override("separation", 5)
	main_container.add_child(center_container)
	
	round_label = Label.new()
	round_label.name = "RoundLabel"
	round_label.text = "Preparación"  # Valor inicial, se actualizará según la fase
	round_label.add_theme_font_size_override("font_size", 20)
	round_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	center_container.add_child(round_label)
	
	lives_label = Label.new()
	lives_label.name = "LivesLabel"
	lives_label.text = "Vidas: 5"
	lives_label.add_theme_font_size_override("font_size", 20)
	lives_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	center_container.add_child(lives_label)
	
	# Eliminar phase_label - no se mostrará "Fase: Preparación" cuando la ronda ya ha empezado
	# phase_label ya no se usa, se mantiene solo para compatibilidad pero se oculta
	phase_label = Label.new()
	phase_label.name = "PhaseLabel"
	phase_label.text = ""
	phase_label.visible = false  # Ocultar el label de fase
	center_container.add_child(phase_label)
	
	# ========== DERECHA: Temporizador y Botón ==========
	var right_container = VBoxContainer.new()
	right_container.name = "RightContainer"
	right_container.custom_minimum_size = Vector2(200, 0)
	right_container.add_theme_constant_override("separation", 5)
	main_container.add_child(right_container)
	
	timer_label = Label.new()
	timer_label.name = "TimerLabel"
	timer_label.text = "60.0s"
	timer_label.add_theme_font_size_override("font_size", 20)
	timer_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	right_container.add_child(timer_label)
	
	start_combat_button = Button.new()
	start_combat_button.name = "StartCombatButton"
	start_combat_button.text = "Iniciar Combate"
	start_combat_button.custom_minimum_size = Vector2(180, 35)
	start_combat_button.modulate = Color(0.8, 1.0, 0.8)  # Verde claro
	start_combat_button.pressed.connect(_on_start_combat_pressed)
	right_container.add_child(start_combat_button)
	
	# Actualizar UI inicial después de crear todos los elementos
	# Esperar un frame adicional para asegurar que game_manager esté completamente inicializado
	await get_tree().process_frame
	update_all_displays()

func update_all_displays():
	"""Actualiza todos los displays"""
	update_round_display()
	update_lives_display()
	update_phase_display()
	update_timer_display()

func update_round_display():
	"""Actualiza el display de ronda según la fase actual"""
	if not round_label:
		return
	
	if not game_manager:
		round_label.text = "Preparación"  # Valor por defecto
		return
	
	# Mostrar texto según la fase actual
	if game_manager.is_preparation_phase():
		# Fase de preparación inicial (técnicamente interfase 1, pero se llama preparación)
		round_label.text = "Preparación"
	elif game_manager.is_combat_phase():
		# Fase de combate - mostrar "Ronda: X"
		var current_round = game_manager.get_current_round()
		round_label.text = "Ronda: %d" % current_round
	elif game_manager.is_interface_phase():
		# Fase de interfase - mostrar "Interfase: X" donde X = ronda actual + 1
		# Por ejemplo: después de Ronda 1 viene Interfase 2
		var current_round = game_manager.get_current_round()
		var interface_number = current_round + 1
		round_label.text = "Interfase: %d" % interface_number
	else:
		round_label.text = "Preparación"  # Fallback

func update_lives_display():
	"""Actualiza el display de vidas"""
	if lives_label and game_manager:
		lives_label.text = "Vidas: %d" % game_manager.get_lives()

func update_phase_display():
	"""Actualiza el display de fase - ahora solo controla el botón, no muestra texto"""
	if game_manager:
		if game_manager.is_preparation_phase():
			if start_combat_button:
				start_combat_button.disabled = false
		elif game_manager.is_interface_phase():
			if start_combat_button:
				start_combat_button.disabled = true
		else:  # Combate
			if start_combat_button:
				start_combat_button.disabled = true

func update_timer_display():
	"""Actualiza el display del temporizador - muestra tiempo de preparación o combate"""
	if timer_label and game_manager:
		var time_remaining = game_manager.get_current_round_time_remaining()
		timer_label.text = "%.1fs" % time_remaining
		timer_label.visible = true

func _on_round_changed(_new_round: int):
	"""Se llama cuando cambia la ronda"""
	update_round_display()

func _on_lives_changed(_new_lives: int):
	"""Se llama cuando cambian las vidas"""
	update_lives_display()

func _on_phase_changed(_new_phase: int):
	"""Se llama cuando cambia la fase"""
	update_phase_display()
	update_round_display()  # Actualizar el display de ronda cuando cambia la fase
	update_timer_display()

func _on_preparation_time_changed(time_remaining: float):
	"""Se llama cuando cambia el tiempo de preparación"""
	update_timer_display()

func _on_combat_time_changed(time_remaining: float):
	"""Se llama cuando cambia el tiempo de combate"""
	update_timer_display()

func _on_interface_time_changed(time_remaining: float):
	"""Se llama cuando cambia el tiempo de interfase"""
	update_timer_display()
	# Asegurar que el display de ronda esté actualizado
	update_round_display()

func _on_start_combat_pressed():
	"""Se llama cuando se presiona el botón de iniciar combate"""
	if not game_manager:
		return
	
	if game_manager.is_preparation_phase():
		game_manager.start_combat()
		print("Combate iniciado desde CombatPanel")

