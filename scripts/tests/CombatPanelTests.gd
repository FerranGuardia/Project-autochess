extends Node
class_name CombatPanelTests

## Tests unitarios para el panel de combate
## Verifica: posicionamiento, actualización de displays, señales, y colisiones con ShopUI

var tests_passed: int = 0
var tests_failed: int = 0

# Referencias para los tests
var board: Board = null
var game_manager: GameManager = null
var combat_panel: CombatPanel = null
var shop_ui: ShopUI = null

func _ready():
	print("==================================================")
	print("🧪 INICIANDO TESTS DEL PANEL DE COMBATE")
	print("==================================================")
	
	# Crear componentes necesarios para los tests
	setup_test_environment()
	
	# Ejecutar todos los tests
	run_all_combat_panel_tests()
	run_all_ui_collision_tests()
	
	# Limpiar después de los tests
	cleanup_test_environment()
	
	# Mostrar resumen
	print("==================================================")
	print("📊 RESUMEN DE TESTS")
	print("✅ Tests pasados: ", tests_passed)
	print("❌ Tests fallados: ", tests_failed)
	print("==================================================")

func setup_test_environment():
	"""Configura el entorno de testing"""
	# Crear Board
	board = Board.new()
	board.name = "TestBoard"
	add_child(board)
	
	# Esperar a que Board inicialice
	await get_tree().process_frame
	await get_tree().process_frame
	
	# Obtener referencias
	game_manager = board.game_manager
	
	# Buscar CombatPanel y ShopUI en la escena
	combat_panel = board.get_node_or_null("UILayer/CombatPanel") as CombatPanel
	shop_ui = board.get_node_or_null("UILayer/ShopUI") as ShopUI
	
	if not combat_panel:
		print("⚠️  ADVERTENCIA: CombatPanel no encontrado")
	if not shop_ui:
		print("⚠️  ADVERTENCIA: ShopUI no encontrado")

func cleanup_test_environment():
	"""Limpia el entorno de testing"""
	if board:
		board.queue_free()

func run_all_combat_panel_tests():
	"""Ejecuta todos los tests del panel de combate"""
	print("\n⚔️ TESTS DEL PANEL DE COMBATE\n")
	
	test_combat_panel_exists()
	test_combat_panel_position()
	test_combat_panel_size()
	test_combat_panel_labels_exist()
	test_combat_panel_button_exists()
	test_combat_panel_signals_connected()
	test_combat_panel_updates_round()
	test_combat_panel_updates_lives()
	test_combat_panel_updates_phase()
	test_combat_panel_updates_timer()
	test_combat_panel_button_functionality()
	# Tests específicos para el display según la lógica de fases
	test_display_shows_preparation_phase()
	test_display_shows_combat_round()
	test_display_shows_interface_phase()
	test_display_flow_preparation_to_combat()
	test_display_flow_combat_to_interface()
	test_display_flow_interface_to_next_round()

func run_all_ui_collision_tests():
	"""Ejecuta todos los tests de colisiones entre UIs"""
	print("\n🔍 TESTS DE COLISIONES DE UI\n")
	
	test_no_ui_overlap()
	test_combat_panel_above_board()
	test_shop_ui_separate()
	test_panel_positions_correct()

# ========== Tests del Panel de Combate ==========

func test_combat_panel_exists():
	"""Test: Verificar que el panel de combate existe"""
	print("📋 Test: Panel de combate existe")
	
	if combat_panel:
		pass_test("CombatPanel existe en la escena")
	else:
		fail_test("CombatPanel no existe en la escena")

func test_combat_panel_position():
	"""Test: Verificar que el panel está posicionado correctamente"""
	print("📋 Test: Posición del panel de combate")
	
	if not combat_panel:
		fail_test("CombatPanel no existe")
		return
	
	var panel = combat_panel.get_node_or_null("CombatPanel") as Panel
	if not panel:
		fail_test("Panel interno no encontrado")
		return
	
	# Verificar posición Y (200px arriba del tablero)
	# Grid enemigo está en Y = -250, así que 200px arriba = -450 en mundo
	# En viewport: Y = 90 (540 - 250 - 200 = 90)
	var expected_y = 90
	var tolerance = 5  # Tolerancia de 5px
	
	if abs(panel.position.y - expected_y) <= tolerance:
		pass_test("Panel está a 200px arriba del tablero (Y = " + str(panel.position.y) + ")")
	else:
		fail_test("Panel en posición Y incorrecta. Esperado: ~" + str(expected_y) + ", Obtenido: " + str(panel.position.y))
	
	# Verificar que está centrado horizontalmente
	# Panel width = 600, viewport width = 1920
	# Centro esperado: X = (1920 - 600) / 2 = 660
	var expected_x = 660
	if abs(panel.position.x - expected_x) <= tolerance:
		pass_test("Panel está centrado horizontalmente (X = " + str(panel.position.x) + ")")
	else:
		fail_test("Panel no está centrado. Esperado: ~" + str(expected_x) + ", Obtenido: " + str(panel.position.x))

func test_combat_panel_size():
	"""Test: Verificar que el panel tiene el tamaño correcto"""
	print("📋 Test: Tamaño del panel de combate")
	
	if not combat_panel:
		fail_test("CombatPanel no existe")
		return
	
	var panel = combat_panel.get_node_or_null("CombatPanel") as Panel
	if not panel:
		fail_test("Panel interno no encontrado")
		return
	
	var expected_width = 600
	var expected_height = 100
	var tolerance = 5
	
	if abs(panel.custom_minimum_size.x - expected_width) <= tolerance:
		pass_test("Ancho del panel correcto (" + str(panel.custom_minimum_size.x) + "px)")
	else:
		fail_test("Ancho incorrecto. Esperado: ~" + str(expected_width) + ", Obtenido: " + str(panel.custom_minimum_size.x))
	
	if abs(panel.custom_minimum_size.y - expected_height) <= tolerance:
		pass_test("Alto del panel correcto (" + str(panel.custom_minimum_size.y) + "px)")
	else:
		fail_test("Alto incorrecto. Esperado: ~" + str(expected_height) + ", Obtenido: " + str(panel.custom_minimum_size.y))

func test_combat_panel_labels_exist():
	"""Test: Verificar que todos los labels existen"""
	print("📋 Test: Labels del panel de combate")
	
	if not combat_panel:
		fail_test("CombatPanel no existe")
		return
	
	var round_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/CenterContainer/RoundLabel") as Label
	var lives_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/CenterContainer/LivesLabel") as Label
	var phase_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/CenterContainer/PhaseLabel") as Label
	var timer_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/RightContainer/TimerLabel") as Label
	
	if round_label:
		pass_test("RoundLabel existe")
	else:
		fail_test("RoundLabel no existe")
	
	if lives_label:
		pass_test("LivesLabel existe")
	else:
		fail_test("LivesLabel no existe")
	
	if phase_label:
		pass_test("PhaseLabel existe")
	else:
		fail_test("PhaseLabel no existe")
	
	if timer_label:
		pass_test("TimerLabel existe")
	else:
		fail_test("TimerLabel no existe")

func test_combat_panel_button_exists():
	"""Test: Verificar que el botón de iniciar combate existe"""
	print("📋 Test: Botón de iniciar combate")
	
	if not combat_panel:
		fail_test("CombatPanel no existe")
		return
	
	var button = combat_panel.get_node_or_null("CombatPanel/MainContainer/RightContainer/StartCombatButton") as Button
	
	if button:
		pass_test("Botón de iniciar combate existe")
		
		if button.text == "Iniciar Combate":
			pass_test("Botón tiene el texto correcto")
		else:
			fail_test("Botón tiene texto incorrecto: " + button.text)
	else:
		fail_test("Botón de iniciar combate no existe")

func test_combat_panel_signals_connected():
	"""Test: Verificar que las señales están conectadas"""
	print("📋 Test: Señales conectadas")
	
	if not combat_panel or not game_manager:
		fail_test("CombatPanel o GameManager no existe")
		return
	
	# Verificar conexiones de señales
	var round_connected = game_manager.round_changed.is_connected(combat_panel._on_round_changed)
	var lives_connected = game_manager.lives_changed.is_connected(combat_panel._on_lives_changed)
	var phase_connected = game_manager.phase_changed.is_connected(combat_panel._on_phase_changed)
	var timer_connected = game_manager.preparation_time_changed.is_connected(combat_panel._on_preparation_time_changed)
	
	if round_connected:
		pass_test("Señal round_changed conectada")
	else:
		fail_test("Señal round_changed NO conectada")
	
	if lives_connected:
		pass_test("Señal lives_changed conectada")
	else:
		fail_test("Señal lives_changed NO conectada")
	
	if phase_connected:
		pass_test("Señal phase_changed conectada")
	else:
		fail_test("Señal phase_changed NO conectada")
	
	if timer_connected:
		pass_test("Señal preparation_time_changed conectada")
	else:
		fail_test("Señal preparation_time_changed NO conectada")

func test_combat_panel_updates_round():
	"""Test: Verificar que el panel actualiza la ronda cuando cambia"""
	print("📋 Test: Actualización de ronda")
	
	if not combat_panel or not game_manager:
		fail_test("CombatPanel o GameManager no existe")
		return
	
	var round_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/CenterContainer/RoundLabel") as Label
	if not round_label:
		fail_test("RoundLabel no existe")
		return
	
	# Cambiar ronda y verificar actualización
	var initial_round = game_manager.get_current_round()
	game_manager.start_new_round()
	await get_tree().process_frame
	
	var new_round = game_manager.get_current_round()
	var new_expected_text = "Ronda: " + str(new_round)
	
	if round_label.text == new_expected_text:
		pass_test("Ronda actualizada correctamente: " + round_label.text)
	else:
		fail_test("Ronda no se actualizó. Esperado: " + new_expected_text + ", Obtenido: " + round_label.text)

func test_combat_panel_updates_lives():
	"""Test: Verificar que el panel actualiza las vidas"""
	print("📋 Test: Actualización de vidas")
	
	if not combat_panel or not game_manager:
		fail_test("CombatPanel o GameManager no existe")
		return
	
	var lives_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/CenterContainer/LivesLabel") as Label
	if not lives_label:
		fail_test("LivesLabel no existe")
		return
	
	var initial_lives = game_manager.get_lives()
	var expected_text = "Vidas: " + str(initial_lives)
	
	if lives_label.text == expected_text:
		pass_test("Vidas iniciales correctas: " + lives_label.text)
	else:
		fail_test("Vidas iniciales incorrectas. Esperado: " + expected_text + ", Obtenido: " + lives_label.text)
	
	# Perder una vida y verificar actualización
	game_manager.lose_life()
	await get_tree().process_frame
	
	var new_lives = game_manager.get_lives()
	var new_expected_text = "Vidas: " + str(new_lives)
	
	if lives_label.text == new_expected_text:
		pass_test("Vidas actualizadas correctamente: " + lives_label.text)
	else:
		fail_test("Vidas no se actualizaron. Esperado: " + new_expected_text + ", Obtenido: " + lives_label.text)

func test_combat_panel_updates_phase():
	"""Test: Verificar que el panel actualiza el botón según la fase (phase_label está oculto ahora)"""
	print("📋 Test: Actualización de fase (botón)")
	
	if not combat_panel or not game_manager:
		fail_test("CombatPanel o GameManager no existe")
		return
	
	var button = combat_panel.get_node_or_null("CombatPanel/MainContainer/RightContainer/StartCombatButton") as Button
	if not button:
		fail_test("StartCombatButton no existe")
		return
	
	# Verificar fase inicial (preparación) - botón debe estar habilitado
	if game_manager.is_preparation_phase():
		if not button.disabled:
			pass_test("Botón habilitado en fase de preparación")
		else:
			fail_test("Botón deshabilitado en fase de preparación (debería estar habilitado)")
	
	# Cambiar a fase de combate - botón debe estar deshabilitado
	game_manager.start_combat()
	await get_tree().process_frame
	
	if game_manager.is_combat_phase():
		if button.disabled:
			pass_test("Botón deshabilitado en fase de combate")
		else:
			fail_test("Botón habilitado en fase de combate (debería estar deshabilitado)")

func test_combat_panel_updates_timer():
	"""Test: Verificar que el panel actualiza el temporizador"""
	print("📋 Test: Actualización de temporizador")
	
	if not combat_panel or not game_manager:
		fail_test("CombatPanel o GameManager no existe")
		return
	
	var timer_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/RightContainer/TimerLabel") as Label
	if not timer_label:
		fail_test("TimerLabel no existe")
		return
	
	# Verificar que el temporizador es visible en fase de preparación
	if game_manager.is_preparation_phase():
		if timer_label.visible:
			pass_test("Temporizador visible en fase de preparación")
		else:
			fail_test("Temporizador NO visible en fase de preparación")
		
		# Verificar que muestra un tiempo válido
		var time_text = timer_label.text
		if time_text.length() > 0 and "s" in time_text:
			pass_test("Temporizador muestra tiempo válido: " + time_text)
		else:
			fail_test("Temporizador no muestra tiempo válido: " + time_text)

func test_combat_panel_button_functionality():
	"""Test: Verificar que el botón de iniciar combate funciona"""
	print("📋 Test: Funcionalidad del botón")
	
	if not combat_panel or not game_manager:
		fail_test("CombatPanel o GameManager no existe")
		return
	
	var button = combat_panel.get_node_or_null("CombatPanel/MainContainer/RightContainer/StartCombatButton") as Button
	if not button:
		fail_test("Botón no existe")
		return
	
	# Verificar que el botón está habilitado en fase de preparación
	if game_manager.is_preparation_phase():
		if not button.disabled:
			pass_test("Botón habilitado en fase de preparación")
		else:
			fail_test("Botón deshabilitado en fase de preparación (debería estar habilitado)")
	
	# Simular click (no podemos hacer click real, pero verificamos que está conectado)
	if button.pressed.is_connected(combat_panel._on_start_combat_pressed):
		pass_test("Botón conectado a función _on_start_combat_pressed")
	else:
		fail_test("Botón NO conectado a función _on_start_combat_pressed")

# ========== Tests Específicos para Display según Lógica de Fases ==========

func test_display_shows_preparation_phase():
	"""Test: Verificar que el display muestra 'Preparación' durante la fase de preparación inicial"""
	print("📋 Test: Display muestra 'Preparación' en fase inicial")
	
	if not combat_panel or not game_manager:
		fail_test("CombatPanel o GameManager no existe")
		return
	
	var round_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/CenterContainer/RoundLabel") as Label
	if not round_label:
		fail_test("RoundLabel no existe")
		return
	
	# Asegurar que estamos en fase de preparación
	if not game_manager.is_preparation_phase():
		# Resetear a preparación si no lo estamos
		game_manager.current_phase = GameManager.Phase.PREPARATION
		game_manager.phase_changed.emit(game_manager.current_phase)
		await get_tree().process_frame
	
	# Verificar que muestra "Preparación"
	if round_label.text == "Preparación":
		pass_test("Display muestra 'Preparación' correctamente en fase inicial")
	else:
		fail_test("Display incorrecto. Esperado: 'Preparación', Obtenido: " + round_label.text)

func test_display_shows_combat_round():
	"""Test: Verificar que el display muestra 'Ronda: X' durante el combate"""
	print("📋 Test: Display muestra 'Ronda: X' en fase de combate")
	
	if not combat_panel or not game_manager:
		fail_test("CombatPanel o GameManager no existe")
		return
	
	var round_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/CenterContainer/RoundLabel") as Label
	if not round_label:
		fail_test("RoundLabel no existe")
		return
	
	# Iniciar combate
	game_manager.start_combat()
	await get_tree().process_frame
	
	# Verificar que muestra "Ronda: X" donde X es el número de ronda actual
	var current_round = game_manager.get_current_round()
	var expected_text = "Ronda: %d" % current_round
	
	if round_label.text == expected_text:
		pass_test("Display muestra 'Ronda: " + str(current_round) + "' correctamente en fase de combate")
	else:
		fail_test("Display incorrecto. Esperado: '" + expected_text + "', Obtenido: " + round_label.text)

func test_display_shows_interface_phase():
	"""Test: Verificar que el display muestra 'Interfase: X' durante la interfase"""
	print("📋 Test: Display muestra 'Interfase: X' en fase de interfase")
	
	if not combat_panel or not game_manager:
		fail_test("CombatPanel o GameManager no existe")
		return
	
	var round_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/CenterContainer/RoundLabel") as Label
	if not round_label:
		fail_test("RoundLabel no existe")
		return
	
	# Simular que terminó un combate y pasamos a interfase
	# Primero necesitamos estar en combate
	game_manager.start_combat()
	await get_tree().process_frame
	
	# Simular fin de combate (victoria) para pasar a interfase
	game_manager.end_combat(true)
	await get_tree().process_frame
	
	# Verificar que estamos en interfase
	if not game_manager.is_interface_phase():
		fail_test("No se pudo cambiar a fase de interfase")
		return
	
	# Verificar que muestra "Interfase: X" donde X = current_round + 1
	var current_round = game_manager.get_current_round()
	var expected_interface_number = current_round + 1
	var expected_text = "Interfase: %d" % expected_interface_number
	
	if round_label.text == expected_text:
		pass_test("Display muestra 'Interfase: " + str(expected_interface_number) + "' correctamente")
	else:
		fail_test("Display incorrecto. Esperado: '" + expected_text + "', Obtenido: " + round_label.text)

func test_display_flow_preparation_to_combat():
	"""Test: Verificar el flujo completo de Preparación -> Combate"""
	print("📋 Test: Flujo Preparación -> Combate")
	
	if not combat_panel or not game_manager:
		fail_test("CombatPanel o GameManager no existe")
		return
	
	var round_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/CenterContainer/RoundLabel") as Label
	if not round_label:
		fail_test("RoundLabel no existe")
		return
	
	# Asegurar que estamos en preparación
	game_manager.current_phase = GameManager.Phase.PREPARATION
	game_manager.phase_changed.emit(game_manager.current_phase)
	await get_tree().process_frame
	
	# Verificar que muestra "Preparación"
	if round_label.text != "Preparación":
		fail_test("No muestra 'Preparación' inicialmente. Obtenido: " + round_label.text)
		return
	
	# Iniciar combate
	game_manager.start_combat()
	await get_tree().process_frame
	
	# Verificar que ahora muestra "Ronda: 1"
	var current_round = game_manager.get_current_round()
	var expected_text = "Ronda: %d" % current_round
	
	if round_label.text == expected_text:
		pass_test("Flujo Preparación -> Combate correcto: '" + round_label.text + "'")
	else:
		fail_test("Flujo incorrecto. Esperado: '" + expected_text + "', Obtenido: " + round_label.text)

func test_display_flow_combat_to_interface():
	"""Test: Verificar el flujo completo de Combate -> Interfase"""
	print("📋 Test: Flujo Combate -> Interfase")
	
	if not combat_panel or not game_manager:
		fail_test("CombatPanel o GameManager no existe")
		return
	
	var round_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/CenterContainer/RoundLabel") as Label
	if not round_label:
		fail_test("RoundLabel no existe")
		return
	
	# Iniciar combate
	game_manager.start_combat()
	await get_tree().process_frame
	
	# Verificar que muestra "Ronda: X"
	var current_round_before = game_manager.get_current_round()
	var expected_combat_text = "Ronda: %d" % current_round_before
	
	if round_label.text != expected_combat_text:
		fail_test("No muestra 'Ronda: X' en combate. Obtenido: " + round_label.text)
		return
	
	# Terminar combate (victoria) para pasar a interfase
	game_manager.end_combat(true)
	await get_tree().process_frame
	
	# Verificar que ahora muestra "Interfase: X"
	var current_round_after = game_manager.get_current_round()
	var expected_interface_number = current_round_after + 1
	var expected_interface_text = "Interfase: %d" % expected_interface_number
	
	if round_label.text == expected_interface_text:
		pass_test("Flujo Combate -> Interfase correcto: '" + round_label.text + "'")
	else:
		fail_test("Flujo incorrecto. Esperado: '" + expected_interface_text + "', Obtenido: " + round_label.text)

func test_display_flow_interface_to_next_round():
	"""Test: Verificar el flujo completo de Interfase -> Siguiente Ronda"""
	print("📋 Test: Flujo Interfase -> Siguiente Ronda")
	
	if not combat_panel or not game_manager:
		fail_test("CombatPanel o GameManager no existe")
		return
	
	var round_label = combat_panel.get_node_or_null("CombatPanel/MainContainer/CenterContainer/RoundLabel") as Label
	if not round_label:
		fail_test("RoundLabel no existe")
		return
	
	# Simular que terminó un combate y estamos en interfase
	game_manager.start_combat()
	await get_tree().process_frame
	game_manager.end_combat(true)
	await get_tree().process_frame
	
	# Verificar que estamos en interfase
	if not game_manager.is_interface_phase():
		fail_test("No se pudo cambiar a fase de interfase")
		return
	
	# Verificar que muestra "Interfase: X"
	var current_round_before = game_manager.get_current_round()
	var expected_interface_number = current_round_before + 1
	var expected_interface_text = "Interfase: %d" % expected_interface_number
	
	if round_label.text != expected_interface_text:
		fail_test("No muestra 'Interfase: X' correctamente. Obtenido: " + round_label.text)
		return
	
	# Simular que termina la interfase y pasa a la siguiente ronda
	# Esto normalmente lo hace el timer, pero lo simulamos manualmente
	game_manager._on_interface_timer_timeout()
	await get_tree().process_frame
	
	# Verificar que ahora muestra "Ronda: X" (ronda incrementada)
	var current_round_after = game_manager.get_current_round()
	var expected_combat_text = "Ronda: %d" % current_round_after
	
	if round_label.text == expected_combat_text:
		pass_test("Flujo Interfase -> Siguiente Ronda correcto: '" + round_label.text + "'")
	else:
		fail_test("Flujo incorrecto. Esperado: '" + expected_combat_text + "', Obtenido: " + round_label.text)

# ========== Tests de Colisiones de UI ==========

func test_no_ui_overlap():
	"""Test: Verificar que CombatPanel y ShopUI no se solapan"""
	print("📋 Test: Sin solapamiento de UIs")
	
	if not combat_panel or not shop_ui:
		fail_test("CombatPanel o ShopUI no existe")
		return
	
	var combat_panel_node = combat_panel.get_node_or_null("CombatPanel") as Panel
	var shop_panel = shop_ui.get_node_or_null("ShopPanel") as Panel
	
	if not combat_panel_node or not shop_panel:
		fail_test("Paneles internos no encontrados")
		return
	
	# Calcular áreas de los paneles
	var combat_rect = Rect2(combat_panel_node.position, combat_panel_node.custom_minimum_size)
	var shop_rect = Rect2(shop_panel.position, shop_panel.custom_minimum_size)
	
	# Verificar que no se solapan
	if not combat_rect.intersects(shop_rect):
		pass_test("CombatPanel y ShopUI no se solapan")
	else:
		fail_test("CombatPanel y ShopUI SE SOLAPAN")
		print("  CombatPanel: ", combat_rect)
		print("  ShopUI: ", shop_rect)

func test_combat_panel_above_board():
	"""Test: Verificar que el panel está arriba del tablero"""
	print("📋 Test: Panel arriba del tablero")
	
	if not combat_panel:
		fail_test("CombatPanel no existe")
		return
	
	var panel = combat_panel.get_node_or_null("CombatPanel") as Panel
	if not panel:
		fail_test("Panel interno no encontrado")
		return
	
	# El panel debe estar en Y < 200 (arriba del tablero)
	# Grid enemigo está en Y = -250 en mundo, que es Y = 290 en viewport
	# Panel debe estar en Y < 290 - 200 = 90
	if panel.position.y < 200:
		pass_test("Panel está arriba del tablero (Y = " + str(panel.position.y) + ")")
	else:
		fail_test("Panel NO está arriba del tablero (Y = " + str(panel.position.y) + ")")

func test_shop_ui_separate():
	"""Test: Verificar que ShopUI está separada del panel de combate"""
	print("📋 Test: ShopUI separada")
	
	if not shop_ui:
		fail_test("ShopUI no existe")
		return
	
	var shop_panel = shop_ui.get_node_or_null("ShopPanel") as Panel
	if not shop_panel:
		fail_test("ShopPanel no encontrado")
		return
	
	# ShopUI debe estar en la esquina superior izquierda
	# Posición esperada: X = 50, Y = 50
	var expected_x = 50
	var expected_y = 50
	var tolerance = 10
	
	if abs(shop_panel.position.x - expected_x) <= tolerance:
		pass_test("ShopUI en posición X correcta: " + str(shop_panel.position.x))
	else:
		fail_test("ShopUI en posición X incorrecta. Esperado: ~" + str(expected_x) + ", Obtenido: " + str(shop_panel.position.x))
	
	if abs(shop_panel.position.y - expected_y) <= tolerance:
		pass_test("ShopUI en posición Y correcta: " + str(shop_panel.position.y))
	else:
		fail_test("ShopUI en posición Y incorrecta. Esperado: ~" + str(expected_y) + ", Obtenido: " + str(shop_panel.position.y))

func test_panel_positions_correct():
	"""Test: Verificar que ambos paneles están en posiciones correctas"""
	print("📋 Test: Posiciones correctas de paneles")
	
	if not combat_panel or not shop_ui:
		fail_test("CombatPanel o ShopUI no existe")
		return
	
	var combat_panel_node = combat_panel.get_node_or_null("CombatPanel") as Panel
	var shop_panel = shop_ui.get_node_or_null("ShopPanel") as Panel
	
	if not combat_panel_node or not shop_panel:
		fail_test("Paneles internos no encontrados")
		return
	
	# CombatPanel: centrado, arriba (Y ~ 90)
	# ShopUI: esquina superior izquierda (X ~ 50, Y ~ 50)
	
	var combat_centered = abs(combat_panel_node.position.x - 660) < 50  # Centrado aproximadamente
	var combat_above = combat_panel_node.position.y < 200
	
	var shop_left = shop_panel.position.x < 100
	var shop_top = shop_panel.position.y < 100
	
	if combat_centered and combat_above:
		pass_test("CombatPanel en posición correcta (centrado, arriba)")
	else:
		fail_test("CombatPanel en posición incorrecta")
	
	if shop_left and shop_top:
		pass_test("ShopUI en posición correcta (esquina superior izquierda)")
	else:
		fail_test("ShopUI en posición incorrecta")

# ========== Utilidades ==========

func pass_test(test_name: String):
	"""Marca un test como pasado"""
	tests_passed += 1
	print("  ✅ PASÓ: ", test_name)

func fail_test(test_name: String):
	"""Marca un test como fallido"""
	tests_failed += 1
	print("  ❌ FALLÓ: ", test_name)

