extends Node2D
class_name Board

## Tablero principal del juego AutoChess
## Contiene: Grid Enemigo, Grid Aliado, Banquillo y plan de espacio para UI

# Constantes de configuración
const CELL_SIZE = 100  # Tamaño de cada celda en píxeles
const GRID_COLUMNS = 7  # Columnas del grid
const GRID_ROWS = 5     # Filas del grid
const BENCH_SLOTS = 10  # Slots del banquillo

# Dimensiones del viewport (1920x1080)
const VIEWPORT_WIDTH = 1920
const VIEWPORT_HEIGHT = 1080

# Referencias a los componentes
var grid_enemy: GridEnemy
var grid_ally: GridAlly
var bench: Bench
var camera: Camera2D

# Sistema de drag global
var global_dragged_unit: Unit = null

# Sistema de juego
var game_manager: GameManager
var shop: Shop
var enemy_ai: EnemyAI
var combat_system: CombatSystem

func _ready():
	# Obtener referencias a los componentes
	grid_enemy = $GridEnemy
	grid_ally = $GridAlly
	bench = $Bench
	camera = $Camera2D
	
	# Configurar cámara en el centro del viewport
	setup_camera()
	
	# Configurar posiciones de los componentes basadas en la cámara
	setup_board_layout()
	
	# Configurar sistema de drag and drop entre bench y grid
	setup_drag_drop_coordination()
	
	# Inicializar sistemas de juego
	setup_game_systems()
	
	# Prueba: Colocar una unidad de ejemplo (opcional, comentar si no se necesita)
	# test_place_unit()
	
	# Ejecutar todos los tests unitarios (bench, grid y drag and drop)
	# run_all_tests()
	
	# Ejecutar tests de integración
	# run_integration_tests()
	
	# Ejecutar tests del sistema de oro y tienda
	# run_shop_tests()  # Deshabilitado - Todos los tests pasan ✅ (ver docs/guides/GUIA_TESTS_TIENDA.md)
	
	# Ejecutar tests del sistema de enemigos
	run_enemy_tests()  # ACTIVADO para probar enemigos

func setup_drag_drop_coordination():
	"""Coordina el drag and drop entre bench y grid"""
	# Las señales se conectan automáticamente cuando se colocan unidades
	# No se requiere configuración adicional aquí
	pass

func _process(_delta):
	"""Actualiza el feedback visual en ambos componentes durante el drag"""
	if global_dragged_unit:
		# Actualizar feedback en grid y bench
		if grid_ally:
			grid_ally.update_drag_feedback_external(global_dragged_unit)
		if bench:
			bench.update_drag_feedback_external(global_dragged_unit)

func on_unit_drag_started(unit: Unit):
	"""Se llama cuando cualquier unidad inicia un drag"""
	global_dragged_unit = unit

func on_unit_drag_ended(_unit: Unit, _drop_position: Vector2):
	"""Se llama cuando cualquier unidad termina un drag"""
	global_dragged_unit = null
	# Limpiar highlights en ambos componentes
	if grid_ally:
		grid_ally.remove_highlight_cell()
	if bench:
		bench.remove_highlight_slot()

func handle_unit_drop(unit: Unit, drop_position: Vector2) -> bool:
	"""Maneja el drop de una unidad, intentando colocarla en grid o banquillo"""
	# Guardar información de la posición original para restaurar si falla
	var was_in_grid = false
	var was_in_bench = false
	var original_grid_pos = Vector2i(-1, -1)
	var original_bench_slot = -1
	
	# Verificar posición original
	if grid_ally:
		var grid_pos = unit.get_grid_position()
		if grid_pos.x >= 0 and grid_pos.y >= 0:
			was_in_grid = true
			original_grid_pos = grid_pos
	
	if bench:
		for slot_index in bench.units.keys():
			if bench.units[slot_index] == unit:
				was_in_bench = true
				original_bench_slot = slot_index
				break
	
	# Primero verificar si el drop está sobre el grid aliado
	if grid_ally:
		# Verificar si la posición está dentro del área del grid
		var grid_local_pos = grid_ally.to_local(drop_position)
		var grid_width = float(grid_ally.COLUMNS * grid_ally.CELL_SIZE)
		var grid_height = float(grid_ally.ROWS * grid_ally.CELL_SIZE)
		
		# Verificar si está dentro del área del grid
		if abs(grid_local_pos.x) <= grid_width / 2.0 and abs(grid_local_pos.y) <= grid_height / 2.0:
			var grid_pos = grid_ally.get_grid_position(drop_position)
			var col = grid_pos.x
			var row = grid_pos.y
			
			if col >= 0 and col < grid_ally.COLUMNS and row >= 0 and row < grid_ally.ROWS:
				var existing_unit = grid_ally.get_unit_at(col, row)
				if not existing_unit or existing_unit == unit:
					# Remover de posición anterior antes de colocar
					remove_unit_from_previous_position(unit)
					if grid_ally.place_unit(unit, col, row):
						return true
	
	# Si no funcionó en el grid, intentar en el banquillo
	if bench:
		# Verificar si la posición está dentro del área del banquillo
		var bench_local_pos = bench.to_local(drop_position)
		var bench_width = float(bench.SLOT_COUNT * bench.SLOT_SIZE)
		var bench_height = float(bench.SLOT_SIZE)
		
		# Verificar si está dentro del área del banquillo
		if abs(bench_local_pos.x) <= bench_width / 2.0 and abs(bench_local_pos.y) <= bench_height / 2.0:
			var slot_index = bench.get_slot_index(drop_position)
			if slot_index >= 0 and slot_index < bench.SLOT_COUNT:
				var existing_unit = bench.get_unit_at(slot_index)
				if not existing_unit or existing_unit == unit:
					# Remover de posición anterior antes de colocar
					remove_unit_from_previous_position(unit)
					if bench.place_unit(unit, slot_index):
						return true
	
	# Si llegamos aquí, el drop falló - restaurar posición original
	if was_in_grid and original_grid_pos.x >= 0 and original_grid_pos.y >= 0:
		grid_ally.place_unit(unit, original_grid_pos.x, original_grid_pos.y)
	elif was_in_bench and original_bench_slot >= 0:
		bench.place_unit(unit, original_bench_slot)
	
	return false

func remove_unit_from_previous_position(unit: Unit):
	"""Remueve una unidad de su posición anterior (bench o grid) antes de moverla"""
	# Verificar si está en el grid
	if grid_ally:
		var grid_pos = unit.get_grid_position()
		if grid_pos.x >= 0 and grid_pos.y >= 0:
			# Está en el grid, removerla
			grid_ally.remove_unit(unit)
	
	# Verificar si está en el bench
	if bench:
		# Buscar en todos los slots del bench
		for slot_index in bench.units.keys():
			if bench.units[slot_index] == unit:
				# Está en el bench, removerla
				bench.remove_unit(unit)
				break

func setup_camera():
	"""Configura la cámara en el centro del viewport"""
	if camera:
		# La cámara se posiciona en (0, 0) que es el centro del viewport
		camera.position = Vector2(0, 0)
		camera.enabled = true

func setup_board_layout():
	"""Configura el layout completo del tablero basado en la cámara"""
	# Con la cámara en (0, 0), el centro de la pantalla es (0, 0)
	# Viewport: 1920x1080, así que el rango visible es:
	# X: -960 a +960, Y: -540 a +540
	
	# Grid Enemigo: Arriba del centro
	# Altura del grid: 500px (5 filas × 100px)
	# Posición: Centro del grid en Y = -250 (arriba del centro de pantalla)
	if grid_enemy:
		grid_enemy.position = Vector2(0, -250)
	
	# Grid Aliado: Abajo del centro, tocando el grid enemigo
	# Posición: Centro del grid en Y = +250 (abajo del centro de pantalla)
	if grid_ally:
		grid_ally.position = Vector2(0, 250)
	
	# Banquillo: Más abajo, separado del grid aliado
	# Altura del banquillo: 100px
	# Separación: ~2 celdas (200px) entre grid aliado y banquillo
	# Posición: Centro del banquillo en Y = +610 (2 celdas más abajo que antes)
	if bench:
		bench.position = Vector2(0, 610)

func test_place_unit():
	"""Función de prueba: Coloca una unidad en el grid aliado"""
	if not grid_ally:
		return
	
	# Crear una unidad de prueba (Mago)
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.MAGO)
	
	# Colocar en el centro del grid (columna 3, fila 2)
	var success = grid_ally.place_unit(unit, 3, 2)
	
	if success:
		print("Unidad colocada exitosamente en (3, 2)")
	else:
		print("Error al colocar unidad")

func run_all_tests():
	"""Ejecuta todos los tests unitarios (bench, grid y drag and drop)"""
	var tests = Tests.new()
	add_child(tests)

func run_integration_tests():
	"""Ejecuta todos los tests de integración"""
	var integration_tests = IntegrationTests.new()
	add_child(integration_tests)

func run_shop_tests():
	"""Ejecuta todos los tests del sistema de oro y tienda"""
	var shop_tests = ShopTests.new()
	add_child(shop_tests)

func run_enemy_tests():
	"""Ejecuta todos los tests del sistema de enemigos"""
	var enemy_tests = EnemyTests.new()
	add_child(enemy_tests)

func setup_game_systems():
	"""Inicializa GameManager y Shop"""
	# Crear GameManager
	game_manager = GameManager.new()
	game_manager.name = "GameManager"
	add_child(game_manager)
	
	# Conectar GridEnemy con GameManager para otorgar loot
	if grid_enemy:
		grid_enemy.set_game_manager(game_manager)
	
	# Crear Shop
	shop = Shop.new()
	shop.name = "Shop"
	add_child(shop)
	
	# Inicializar Shop con referencias
	shop.initialize(game_manager, bench)
	
	# Conectar señales del GameManager (para UI futura)
	game_manager.gold_changed.connect(_on_gold_changed)
	game_manager.round_changed.connect(_on_round_changed)
	game_manager.lives_changed.connect(_on_lives_changed)
	game_manager.game_over.connect(_on_game_over)
	game_manager.combat_started.connect(_on_combat_started)
	
	# Crear sistema de IA de enemigos
	enemy_ai = EnemyAI.new()
	enemy_ai.name = "EnemyAI"
	add_child(enemy_ai)
	enemy_ai.initialize(grid_enemy, self)
	
	# Crear sistema de combate
	combat_system = CombatSystem.new()
	combat_system.name = "CombatSystem"
	add_child(combat_system)
	combat_system.initialize(grid_ally, grid_enemy, game_manager)
	
	# Conectar señales de combate
	game_manager.combat_started.connect(_on_combat_started_system)
	game_manager.combat_ended.connect(_on_combat_ended_system)
	
	# Crear UI de tienda
	create_shop_ui()
	
	print("Sistemas de juego inicializados")
	print("Oro inicial: ", game_manager.get_gold())
	print("Ofertas de tienda: ", shop.get_offers_display())

func _on_gold_changed(_new_amount: int):
	"""Se llama cuando cambia el oro"""
	print("Oro actualizado: ", game_manager.get_gold())

func _on_round_changed(new_round: int):
	"""Se llama cuando cambia la ronda"""
	print("Ronda actualizada: ", new_round)

func _on_lives_changed(new_lives: int):
	"""Se llama cuando cambian las vidas"""
	print("Vidas actualizadas: ", new_lives)

func _on_game_over():
	"""Se llama cuando el juego termina"""
	print("¡GAME OVER!")

func _on_combat_started():
	"""Se llama cuando inicia el combate - colocar enemigos y guardar posiciones"""
	# Guardar posiciones iniciales de unidades aliadas
	if grid_ally:
		grid_ally.save_initial_positions()
	
	# Colocar enemigos
	if enemy_ai and grid_enemy:
		var current_round = game_manager.get_current_round()
		enemy_ai.spawn_enemies_for_round(current_round)
		print("Combate iniciado - Ronda ", current_round)

func _on_combat_started_system():
	"""Se llama cuando inicia el combate - iniciar sistema de combate"""
	if combat_system:
		combat_system.start_combat()

func _on_combat_ended_system(_victory: bool):
	"""Se llama cuando termina el combate - detener sistema de combate y revivir unidades"""
	# Nota: stop_combat() ya se llama en end_combat(), no es necesario llamarlo aquí
	# El CombatSystem ya detuvo el combate cuando llamó a end_combat()
	
	# Revivir todas las unidades aliadas y restaurar posiciones
	if grid_ally:
		grid_ally.resurrect_all_units()

func purchase_unit_from_shop(offer_index: int) -> bool:
	"""Intenta comprar una unidad de la tienda"""
	if not shop:
		return false
	return shop.purchase_unit(offer_index)

func create_shop_ui():
	"""Crea la UI de la tienda"""
	# Crear CanvasLayer para la UI (por encima de todo)
	var canvas_layer = CanvasLayer.new()
	canvas_layer.name = "UILayer"
	add_child(canvas_layer)
	
	# Crear nodo ShopUI
	var shop_ui = ShopUI.new()
	shop_ui.name = "ShopUI"
	canvas_layer.add_child(shop_ui)
	
	# Configurar ShopUI con referencias
	shop_ui.board = self
	shop_ui.shop = shop
	shop_ui.game_manager = game_manager
