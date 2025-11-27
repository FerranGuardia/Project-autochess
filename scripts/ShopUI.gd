extends Control
class_name ShopUI

## UI de la tienda
## Muestra las ofertas y permite comprar unidades

# Referencias
var board: Board
var shop: Shop
var game_manager: GameManager

# Nodos de UI
var gold_label: Label
var shop_panel: Panel
var offers_container: VBoxContainer
var refresh_button: Button

# Constantes de UI
const PANEL_WIDTH = 600
const PANEL_HEIGHT = 300
const BUTTON_WIDTH = 100
const BUTTON_HEIGHT = 80

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
		if shop:
			if not shop.unit_purchased.is_connected(_on_unit_purchased):
				shop.unit_purchased.connect(_on_unit_purchased)
	
	# Crear UI
	create_ui()

func create_ui():
	"""Crea los elementos de la UI"""
	# Panel principal de la tienda
	shop_panel = Panel.new()
	shop_panel.name = "ShopPanel"
	shop_panel.custom_minimum_size = Vector2(PANEL_WIDTH, PANEL_HEIGHT)
	shop_panel.position = Vector2(50, 50)  # Esquina superior izquierda
	add_child(shop_panel)
	
	# Título
	var title = Label.new()
	title.text = "TIENDA"
	title.add_theme_font_size_override("font_size", 24)
	title.position = Vector2(10, 10)
	shop_panel.add_child(title)
	
	# Label de oro
	gold_label = Label.new()
	gold_label.name = "GoldLabel"
	gold_label.text = "Oro: 10"
	gold_label.add_theme_font_size_override("font_size", 20)
	gold_label.position = Vector2(10, 50)
	shop_panel.add_child(gold_label)
	
	# Contenedor de ofertas
	offers_container = VBoxContainer.new()
	offers_container.name = "OffersContainer"
	offers_container.position = Vector2(10, 90)
	offers_container.custom_minimum_size = Vector2(PANEL_WIDTH - 20, 150)
	shop_panel.add_child(offers_container)
	
	# Botón de refrescar tienda
	refresh_button = Button.new()
	refresh_button.text = "Refrescar Tienda"
	refresh_button.position = Vector2(10, PANEL_HEIGHT - 40)
	refresh_button.custom_minimum_size = Vector2(150, 30)
	refresh_button.pressed.connect(_on_refresh_pressed)
	shop_panel.add_child(refresh_button)
	
	# Actualizar UI inicial
	update_offers_display()
	update_gold_display()

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
	
	# Crear botón para cada oferta
	for i in range(offers.size()):
		var unit_type = offers[i]
		var cost = shop.get_unit_cost(unit_type)
		var unit_name = UnitData.get_unit_name(unit_type)
		
		# Crear contenedor horizontal para cada oferta
		var offer_row = HBoxContainer.new()
		offer_row.custom_minimum_size = Vector2(PANEL_WIDTH - 40, 30)
		
		# Label con nombre y costo
		var offer_label = Label.new()
		offer_label.text = "%s - %d oro" % [unit_name, cost]
		offer_label.custom_minimum_size = Vector2(200, 30)
		offer_row.add_child(offer_label)
		
		# Botón de compra
		var buy_button = Button.new()
		buy_button.text = "Comprar"
		buy_button.custom_minimum_size = Vector2(100, 30)
		
		# Verificar si hay suficiente oro
		if game_manager and not game_manager.has_enough_gold(cost):
			buy_button.disabled = true
			buy_button.modulate = Color(0.5, 0.5, 0.5)  # Gris si no hay suficiente oro
		
		# Conectar señal de compra
		var offer_index = i  # Capturar índice para la lambda
		buy_button.pressed.connect(func(): _on_buy_pressed(offer_index))
		
		offer_row.add_child(buy_button)
		offers_container.add_child(offer_row)

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

