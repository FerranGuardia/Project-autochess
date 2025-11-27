extends Control
class_name ShopUI

## UI de la tienda
## Muestra las ofertas y permite comprar unidades

# Referencias
var board: Board
var shop: Shop
var game_manager: GameManager

# Nodos de UI - TIENDA
var gold_label: Label
var round_label: Label
var lives_label: Label
var phase_label: Label
var shop_panel: Panel
var offers_container: VBoxContainer
var refresh_button: Button

# Nodos de UI - CONTROLES (separado de la tienda)
var control_panel: Panel
var start_combat_button: Button

# Constantes de UI - TIENDA
const SHOP_PANEL_WIDTH = 600
# Altura: 300px base + 200px adicionales = 500px total
# El panel se extiende hacia abajo manteniendo la posición superior
const SHOP_PANEL_HEIGHT = 500
const SHOP_POSITION_X = 50  # Esquina superior izquierda
const SHOP_POSITION_Y = 50

# Márgenes del panel (SIEMPRE se respetan)
const PANEL_MARGIN_LEFT = 10
const PANEL_MARGIN_RIGHT = 10
const PANEL_MARGIN_TOP = 10
const PANEL_MARGIN_BOTTOM = 10
const PANEL_MARGIN_BETWEEN = 5  # Margen entre elementos

# Dimensiones de elementos
const TITLE_HEIGHT = 30
const INFO_HEIGHT = 100
const OFFER_ROW_HEIGHT = 20  # Altura de cada fila de oferta
const MAX_OFFERS = 5  # Máximo número de ofertas
const OFFERS_HEIGHT = MAX_OFFERS * OFFER_ROW_HEIGHT  # 5 ofertas × 20px = 100px
const REFRESH_BUTTON_HEIGHT = 30

# Ancho disponible dentro del panel (respetando márgenes)
var available_width: int = SHOP_PANEL_WIDTH - PANEL_MARGIN_LEFT - PANEL_MARGIN_RIGHT

# Constantes de UI - CONTROLES
const CONTROL_PANEL_WIDTH = 320
const CONTROL_PANEL_HEIGHT = 60
const CONTROL_POSITION_X = 900  # Esquina superior derecha (1280 - 320 - 60 de margen)
const CONTROL_POSITION_Y = 50

func _ready():
	# Esperar un frame para que Board esté listo
	await get_tree().process_frame
	if not shop or not game_manager:
		setup_ui()
	else:
		create_ui()

func setup_ui():
	"""Configura la UI de la tienda"""
	# Si las referencias ya están establecidas (desde Board), usarlas
	if not board:
		# Intentar obtener referencias automáticamente
		var board_node = get_tree().get_first_node_in_group("board")
		if not board_node:
			# Buscar Board en la escena
			board = get_node_or_null("/root/Board") as Board
			if not board:
				board = get_node_or_null("../../Board") as Board
	
	if board:
		if not shop:
			shop = board.shop
		if not game_manager:
			game_manager = board.game_manager
		
		# Conectar señales
		if game_manager:
			if not game_manager.gold_changed.is_connected(_on_gold_changed):
				game_manager.gold_changed.connect(_on_gold_changed)
			if not game_manager.round_changed.is_connected(_on_round_changed):
				game_manager.round_changed.connect(_on_round_changed)
			if not game_manager.lives_changed.is_connected(_on_lives_changed):
				game_manager.lives_changed.connect(_on_lives_changed)
			if not game_manager.phase_changed.is_connected(_on_phase_changed):
				game_manager.phase_changed.connect(_on_phase_changed)
		if shop:
			if not shop.unit_purchased.is_connected(_on_unit_purchased):
				shop.unit_purchased.connect(_on_unit_purchased)
	
	# Crear UI
	create_ui()

func create_ui():
	"""Crea los elementos de la UI"""
	# ========== PANEL DE TIENDA (ÁREA SEPARADA) ==========
	create_shop_panel()
	
	# ========== PANEL DE CONTROLES (ÁREA SEPARADA) ==========
	create_control_panel()

func create_shop_panel():
	"""Crea el panel de la tienda usando contenedores para evitar overlaps"""
	# ========== PANEL PRINCIPAL ==========
	shop_panel = Panel.new()
	shop_panel.name = "ShopPanel"
	shop_panel.custom_minimum_size = Vector2(SHOP_PANEL_WIDTH, SHOP_PANEL_HEIGHT)
	shop_panel.position = Vector2(SHOP_POSITION_X, SHOP_POSITION_Y)
	add_child(shop_panel)
	
	# ========== MARGIN CONTAINER (para márgenes del panel) ==========
	var margin_container = MarginContainer.new()
	margin_container.name = "MarginContainer"
	margin_container.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin_container.add_theme_constant_override("margin_left", PANEL_MARGIN_LEFT)
	margin_container.add_theme_constant_override("margin_right", PANEL_MARGIN_RIGHT)
	margin_container.add_theme_constant_override("margin_top", PANEL_MARGIN_TOP)
	margin_container.add_theme_constant_override("margin_bottom", PANEL_MARGIN_BOTTOM)
	shop_panel.add_child(margin_container)
	
	# ========== VBOX CONTAINER PRINCIPAL (organiza todo verticalmente) ==========
	var main_vbox = VBoxContainer.new()
	main_vbox.name = "MainVBox"
	main_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	main_vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	margin_container.add_child(main_vbox)
	
	# ========== TÍTULO ==========
	var title = Label.new()
	title.name = "Title"
	title.text = "TIENDA"
	title.add_theme_font_size_override("font_size", 24)
	title.custom_minimum_size = Vector2(0, TITLE_HEIGHT)
	title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	main_vbox.add_child(title)
	
	# Separador visual (espacio)
	var separator1 = Control.new()
	separator1.custom_minimum_size = Vector2(0, PANEL_MARGIN_BETWEEN)
	main_vbox.add_child(separator1)
	
	# ========== INFORMACIÓN DEL JUEGO ==========
	var info_container = VBoxContainer.new()
	info_container.name = "InfoContainer"
	info_container.custom_minimum_size = Vector2(0, INFO_HEIGHT)
	info_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	main_vbox.add_child(info_container)
	
	# Label de oro
	gold_label = Label.new()
	gold_label.name = "GoldLabel"
	gold_label.text = "Oro: 10"
	gold_label.add_theme_font_size_override("font_size", 18)
	info_container.add_child(gold_label)
	
	# Label de ronda
	round_label = Label.new()
	round_label.name = "RoundLabel"
	round_label.text = "Ronda: 1"
	round_label.add_theme_font_size_override("font_size", 18)
	info_container.add_child(round_label)
	
	# Label de vidas
	lives_label = Label.new()
	lives_label.name = "LivesLabel"
	lives_label.text = "Vidas: 5"
	lives_label.add_theme_font_size_override("font_size", 18)
	info_container.add_child(lives_label)
	
	# Label de fase
	phase_label = Label.new()
	phase_label.name = "PhaseLabel"
	phase_label.text = "Fase: Preparación"
	phase_label.add_theme_font_size_override("font_size", 16)
	phase_label.modulate = Color(0.8, 0.8, 1.0)  # Azul claro
	info_container.add_child(phase_label)
	
	# Separador visual (espacio)
	var separator2 = Control.new()
	separator2.custom_minimum_size = Vector2(0, PANEL_MARGIN_BETWEEN)
	main_vbox.add_child(separator2)
	
	# ========== CONTENEDOR DE OFERTAS (sin scroll, altura fija) ==========
	offers_container = VBoxContainer.new()
	offers_container.name = "OffersContainer"
	offers_container.custom_minimum_size = Vector2(0, OFFERS_HEIGHT)
	offers_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	offers_container.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	main_vbox.add_child(offers_container)
	
	# Separador visual (espacio)
	var separator3 = Control.new()
	separator3.custom_minimum_size = Vector2(0, PANEL_MARGIN_BETWEEN)
	main_vbox.add_child(separator3)
	
	# ========== CONTENEDOR PARA CENTRAR EL BOTÓN ==========
	var button_container = HBoxContainer.new()
	button_container.name = "ButtonContainer"
	button_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	main_vbox.add_child(button_container)
	
	# Espaciador izquierdo (empuja el botón al centro)
	var spacer_left = Control.new()
	spacer_left.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button_container.add_child(spacer_left)
	
	# ========== BOTÓN REFRESCAR (centrado, debajo de las ofertas) ==========
	refresh_button = Button.new()
	refresh_button.name = "RefreshButton"
	refresh_button.text = "Refrescar Tienda"
	refresh_button.custom_minimum_size = Vector2(150, REFRESH_BUTTON_HEIGHT)
	refresh_button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	refresh_button.pressed.connect(_on_refresh_pressed)
	button_container.add_child(refresh_button)
	
	# Espaciador derecho (empuja el botón al centro)
	var spacer_right = Control.new()
	spacer_right.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button_container.add_child(spacer_right)
	
	# Calcular ancho disponible para uso en otras funciones
	available_width = SHOP_PANEL_WIDTH - PANEL_MARGIN_LEFT - PANEL_MARGIN_RIGHT

func get_position_within_panel(x: int, y: int) -> Vector2:
	"""Obtiene una posición dentro del panel respetando márgenes"""
	# Asegurar que X no sea menor que el margen izquierdo
	var safe_x = max(x, PANEL_MARGIN_LEFT)
	# Asegurar que Y no sea menor que el margen superior
	var safe_y = max(y, PANEL_MARGIN_TOP)
	return Vector2(safe_x, safe_y)

func validate_and_constrain_element(element: Control, parent_panel: Panel):
	"""Valida y ajusta un elemento para que siempre esté dentro del panel"""
	if not element or not parent_panel:
		return
	
	var panel_size = parent_panel.custom_minimum_size
	var element_pos = element.position
	var element_size = element.custom_minimum_size
	
	# Validar y ajustar posición X
	if element_pos.x < PANEL_MARGIN_LEFT:
		element_pos.x = PANEL_MARGIN_LEFT
	elif element_pos.x + element_size.x > panel_size.x - PANEL_MARGIN_RIGHT:
		element_pos.x = panel_size.x - PANEL_MARGIN_RIGHT - element_size.x
	
	# Validar y ajustar posición Y
	if element_pos.y < PANEL_MARGIN_TOP:
		element_pos.y = PANEL_MARGIN_TOP
	elif element_pos.y + element_size.y > panel_size.y - PANEL_MARGIN_BOTTOM:
		element_pos.y = panel_size.y - PANEL_MARGIN_BOTTOM - element_size.y
	
	# Validar y ajustar tamaño
	var max_width = panel_size.x - PANEL_MARGIN_LEFT - PANEL_MARGIN_RIGHT
	var max_height = panel_size.y - PANEL_MARGIN_TOP - PANEL_MARGIN_BOTTOM
	
	if element_size.x > max_width:
		element_size.x = max_width
	if element_size.y > max_height:
		element_size.y = max_height
	
	# Aplicar ajustes
	element.position = element_pos
	element.custom_minimum_size = element_size
	
	# Verificar que después del ajuste sigue dentro
	if element_pos.x + element_size.x > panel_size.x - PANEL_MARGIN_RIGHT:
		element_size.x = panel_size.x - PANEL_MARGIN_RIGHT - element_pos.x
		element.custom_minimum_size = element_size
	
	if element_pos.y + element_size.y > panel_size.y - PANEL_MARGIN_BOTTOM:
		element_size.y = panel_size.y - PANEL_MARGIN_BOTTOM - element_pos.y
		element.custom_minimum_size = element_size

func ensure_all_elements_inside_panel():
	"""Asegura que todos los elementos estén dentro del panel - SIEMPRE"""
	if not shop_panel:
		return
	
	var panel_size = shop_panel.custom_minimum_size
	
	# Recalcular ancho disponible
	available_width = panel_size.x - PANEL_MARGIN_LEFT - PANEL_MARGIN_RIGHT
	
	# Validar todos los hijos del panel
	for child in shop_panel.get_children():
		if child is Control:
			var control = child as Control
			validate_and_constrain_element(control, shop_panel)
			
			# Si es un contenedor, validar también sus hijos
			if control is Container:
				validate_container_children(control, shop_panel)

func validate_container_children(container: Container, parent_panel: Panel):
	"""Valida que los hijos de un contenedor también estén dentro"""
	if not container or not parent_panel:
		return
	
	var panel_size = parent_panel.custom_minimum_size
	var container_pos = container.position
	var container_size = container.custom_minimum_size
	
	# Validar cada hijo del contenedor
	for child in container.get_children():
		if child is Control:
			var control = child as Control
			var child_pos = control.position
			var child_size = control.custom_minimum_size
			
			# Posición absoluta del hijo (relativa al panel)
			var absolute_x = container_pos.x + child_pos.x
			var absolute_y = container_pos.y + child_pos.y
			
			# Validar que no se salga por la derecha
			if absolute_x + child_size.x > panel_size.x - PANEL_MARGIN_RIGHT:
				child_size.x = panel_size.x - PANEL_MARGIN_RIGHT - absolute_x
				control.custom_minimum_size = child_size
			
			# Validar que no se salga por abajo
			if absolute_y + child_size.y > panel_size.y - PANEL_MARGIN_BOTTOM:
				child_size.y = panel_size.y - PANEL_MARGIN_BOTTOM - absolute_y
				control.custom_minimum_size = child_size
			
			# Validar ancho máximo
			var max_child_width = panel_size.x - PANEL_MARGIN_LEFT - PANEL_MARGIN_RIGHT - container_pos.x
			if child_size.x > max_child_width:
				child_size.x = max_child_width
				control.custom_minimum_size = child_size

func create_control_panel():
	"""Crea el panel de controles (área completamente separada de la tienda)"""
	control_panel = Panel.new()
	control_panel.name = "ControlPanel"
	control_panel.custom_minimum_size = Vector2(CONTROL_PANEL_WIDTH, CONTROL_PANEL_HEIGHT)
	# Posición: Esquina superior derecha (completamente separada de la tienda)
	control_panel.position = Vector2(CONTROL_POSITION_X, CONTROL_POSITION_Y)
	add_child(control_panel)
	
	# Título del panel de control
	var control_title = Label.new()
	control_title.text = "CONTROLES"
	control_title.add_theme_font_size_override("font_size", 18)
	control_title.position = Vector2(10, 5)
	control_panel.add_child(control_title)
	
	# Botón de iniciar combate (ÚNICO botón en el panel de controles)
	start_combat_button = Button.new()
	start_combat_button.text = "Iniciar Combate"
	start_combat_button.custom_minimum_size = Vector2(150, 35)
	start_combat_button.position = Vector2(10, 25)
	start_combat_button.modulate = Color(0.8, 1.0, 0.8)  # Verde claro
	start_combat_button.pressed.connect(_on_start_combat_pressed)
	control_panel.add_child(start_combat_button)
	
	# Actualizar UI inicial
	update_offers_display()
	update_gold_display()
	update_round_display()
	update_lives_display()
	update_phase_display()
	
	# VALIDAR que todos los elementos estén dentro del panel
	ensure_all_elements_inside_panel()

func update_gold_display():
	"""Actualiza el display de oro"""
	if gold_label and game_manager:
		gold_label.text = "Oro: %d" % game_manager.get_gold()

func update_offers_display():
	"""Actualiza el display de ofertas"""
	if not offers_container or not shop:
		return
	
	# Limpiar ofertas anteriores
	for child in offers_container.get_children():
		child.queue_free()
	
	# Obtener ofertas actuales
	var offers = shop.get_offers()
	
	# Calcular ancho disponible (por si el panel cambió)
	if shop_panel:
		available_width = shop_panel.custom_minimum_size.x - PANEL_MARGIN_LEFT - PANEL_MARGIN_RIGHT
	
	# Crear botón para cada oferta
	for i in range(offers.size()):
		var unit_type = offers[i]
		var cost = shop.get_unit_cost(unit_type)
		var unit_name = UnitData.get_unit_name(unit_type)
		
		# Crear contenedor horizontal para cada oferta
		var offer_row = HBoxContainer.new()
		# Asegurar que el ancho no exceda el disponible
		var row_width = min(available_width, SHOP_PANEL_WIDTH - PANEL_MARGIN_LEFT - PANEL_MARGIN_RIGHT)
		offer_row.custom_minimum_size = Vector2(row_width, OFFER_ROW_HEIGHT)
		
		# Label con nombre y costo
		var offer_label = Label.new()
		offer_label.text = "%s - %d oro" % [unit_name, cost]
		# El label ocupa el espacio disponible menos el botón
		var label_width = max(200, row_width - 110)  # 100px botón + 10px margen
		offer_label.custom_minimum_size = Vector2(label_width, OFFER_ROW_HEIGHT)
		offer_row.add_child(offer_label)
		
		# Botón de compra
		var buy_button = Button.new()
		buy_button.text = "Comprar"
		buy_button.custom_minimum_size = Vector2(100, OFFER_ROW_HEIGHT)
		
		# Verificar si hay suficiente oro
		if game_manager and not game_manager.has_enough_gold(cost):
			buy_button.disabled = true
			buy_button.modulate = Color(0.5, 0.5, 0.5)  # Gris si no hay suficiente oro
		
		# Conectar señal de compra
		var offer_index = i  # Capturar índice para la lambda
		buy_button.pressed.connect(func(): _on_buy_pressed(offer_index))
		
		offer_row.add_child(buy_button)
		offers_container.add_child(offer_row)
	
	# Validar que todas las ofertas estén dentro
	if shop_panel:
		ensure_all_elements_inside_panel()

func _on_buy_pressed(offer_index: int):
	"""Se llama cuando se presiona un botón de compra"""
	if not board:
		return
	
	var success = board.purchase_unit_from_shop(offer_index)
	if success:
		# Actualizar UI
		update_gold_display()
		update_offers_display()
		print("Compra exitosa!")
	else:
		print("Error al comprar unidad")

func _on_refresh_pressed():
	"""Se llama cuando se presiona el botón de refrescar"""
	if not shop:
		return
	
	# Refrescar tienda (en el futuro esto costará oro, por ahora es gratis)
	shop.refresh_shop()
	update_offers_display()
	print("Tienda refrescada")

func _on_gold_changed(_new_amount: int):
	"""Se llama cuando cambia el oro"""
	update_gold_display()
	# Actualizar botones de compra (habilitar/deshabilitar según oro)
	update_offers_display()

func _on_unit_purchased(unit_type: UnitData.UnitType, cost: int):
	"""Se llama cuando se compra una unidad"""
	print("Unidad comprada: ", UnitData.get_unit_name(unit_type), " por ", cost, " oro")

func update_round_display():
	"""Actualiza el display de ronda"""
	if round_label and game_manager:
		round_label.text = "Ronda: %d" % game_manager.get_current_round()

func update_lives_display():
	"""Actualiza el display de vidas"""
	if lives_label and game_manager:
		lives_label.text = "Vidas: %d" % game_manager.get_lives()

func update_phase_display():
	"""Actualiza el display de fase"""
	if phase_label and game_manager:
		if game_manager.is_preparation_phase():
			phase_label.text = "Fase: Preparación"
			phase_label.modulate = Color(0.8, 0.8, 1.0)  # Azul claro
			if start_combat_button:
				start_combat_button.disabled = false
		else:
			phase_label.text = "Fase: Combate"
			phase_label.modulate = Color(1.0, 0.8, 0.8)  # Rojo claro
			if start_combat_button:
				start_combat_button.disabled = true

func _on_round_changed(_new_round: int):
	"""Se llama cuando cambia la ronda"""
	update_round_display()

func _on_lives_changed(_new_lives: int):
	"""Se llama cuando cambian las vidas"""
	update_lives_display()

func _on_phase_changed(_new_phase: int):
	"""Se llama cuando cambia la fase"""
	update_phase_display()

func _on_start_combat_pressed():
	"""Se llama cuando se presiona el botón de iniciar combate"""
	if not game_manager:
		return
	
	if game_manager.is_preparation_phase():
		game_manager.start_combat()
		print("Combate iniciado desde UI")
func _on_panel_resized():
	"""Se llama cuando el panel cambia de tamaño - revalidar todo"""
	ensure_all_elements_inside_panel()
