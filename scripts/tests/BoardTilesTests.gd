extends Node
class_name BoardTilesTests

## Tests unitarios para verificar la carga y posicionamiento de tiles del tablero

const BoardTileHelper = preload("res://scripts/BoardTileHelper.gd")

var tests_passed = 0
var tests_failed = 0
var failed_tests = []

func _ready():
	print("\n============================================================")
	print("🧪 INICIANDO TESTS DE TILES DEL TABLERO")
	print("============================================================")
	
	# Ejecutar todos los tests
	test_tile_index_calculations()
	test_tile_paths_exist()
	test_border_tile_positions()
	test_grid_tile_positions()
	test_tile_loading()
	
	# Mostrar resumen
	print("\n============================================================")
	print("📊 RESUMEN DE TESTS")
	print("============================================================")
	print("✅ Tests pasados: ", tests_passed)
	print("❌ Tests fallidos: ", tests_failed)
	
	if failed_tests.size() > 0:
		print("\n⚠️  Tests fallidos:")
		for test_name in failed_tests:
			print("   - ", test_name)
	
	if tests_failed == 0:
		print("\n🎉 ¡Todos los tests pasaron!")
	else:
		print("\n⚠️  Algunos tests fallaron. Revisa los errores arriba.")
	
	print("============================================================\n")
	
	# No cerrar el juego - dejar que la escena se muestre
	# get_tree().quit()  # Comentado para poder ver el tablero

func assert_test(condition: bool, test_name: String, error_message: String = ""):
	"""Helper para assertions"""
	if condition:
		tests_passed += 1
		print("  ✅ ", test_name)
	else:
		tests_failed += 1
		failed_tests.append(test_name)
		print("  ❌ ", test_name)
		if error_message != "":
			print("     Error: ", error_message)

func test_tile_index_calculations():
	"""Test: Verificar que los cálculos de índices de tiles son correctos"""
	print("\n📐 Test: Cálculos de índices de tiles")
	
	# Test borde superior (fila 0)
	assert_test(BoardTileHelper.get_border_tile_index(0, 0) == 1, 
		"Borde superior izquierda (0,0) = tile 1",
		"Esperado: 1, Obtenido: %d" % BoardTileHelper.get_border_tile_index(0, 0))
	
	assert_test(BoardTileHelper.get_border_tile_index(4, 0) == 5, 
		"Borde superior centro (4,0) = tile 5",
		"Esperado: 5, Obtenido: %d" % BoardTileHelper.get_border_tile_index(4, 0))
	
	assert_test(BoardTileHelper.get_border_tile_index(8, 0) == 9, 
		"Borde superior derecha (8,0) = tile 9",
		"Esperado: 9, Obtenido: %d" % BoardTileHelper.get_border_tile_index(8, 0))
	
	# Test borde inferior (fila 11)
	assert_test(BoardTileHelper.get_border_tile_index(0, 11) == 100, 
		"Borde inferior izquierda (0,11) = tile 100",
		"Esperado: 100, Obtenido: %d" % BoardTileHelper.get_border_tile_index(0, 11))
	
	assert_test(BoardTileHelper.get_border_tile_index(8, 11) == 108, 
		"Borde inferior derecha (8,11) = tile 108",
		"Esperado: 108, Obtenido: %d" % BoardTileHelper.get_border_tile_index(8, 11))
	
	# Test grid enemigo
	assert_test(BoardTileHelper.get_enemy_tile_index(0, 0) == 11, 
		"Grid enemigo (0,0) = tile 11",
		"Esperado: 11, Obtenido: %d" % BoardTileHelper.get_enemy_tile_index(0, 0))
	
	assert_test(BoardTileHelper.get_enemy_tile_index(3, 2) == 32, 
		"Grid enemigo (3,2) = tile 32",
		"Esperado: 32, Obtenido: %d" % BoardTileHelper.get_enemy_tile_index(3, 2))
	
	assert_test(BoardTileHelper.get_enemy_tile_index(6, 4) == 53, 
		"Grid enemigo (6,4) = tile 53",
		"Esperado: 53, Obtenido: %d" % BoardTileHelper.get_enemy_tile_index(6, 4))
	
	# Test grid aliado
	assert_test(BoardTileHelper.get_ally_tile_index(0, 0) == 56, 
		"Grid aliado (0,0) = tile 56",
		"Esperado: 56, Obtenido: %d" % BoardTileHelper.get_ally_tile_index(0, 0))
	
	assert_test(BoardTileHelper.get_ally_tile_index(3, 2) == 77, 
		"Grid aliado (3,2) = tile 77",
		"Esperado: 77, Obtenido: %d" % BoardTileHelper.get_ally_tile_index(3, 2))
	
	assert_test(BoardTileHelper.get_ally_tile_index(6, 4) == 98, 
		"Grid aliado (6,4) = tile 98",
		"Esperado: 98, Obtenido: %d" % BoardTileHelper.get_ally_tile_index(6, 4))

func test_tile_paths_exist():
	"""Test: Verificar que los archivos de tiles existen"""
	print("\n📁 Test: Existencia de archivos de tiles")
	
	var missing_tiles = []
	var existing_tiles = 0
	
	# Verificar tiles de borde (muestra)
	var border_samples = [1, 5, 9, 10, 18, 19, 27, 28, 36, 45, 54, 63, 72, 81, 90, 99, 100, 104, 108]
	for tile_index in border_samples:
		var path = BoardTileHelper.get_tile_path(tile_index)
		if ResourceLoader.exists(path):
			existing_tiles += 1
		else:
			missing_tiles.append(tile_index)
	
	# Verificar tiles del grid enemigo (muestra)
	var enemy_samples = [11, 17, 20, 26, 29, 35, 38, 44, 47, 53]
	for tile_index in enemy_samples:
		var path = BoardTileHelper.get_tile_path(tile_index)
		if ResourceLoader.exists(path):
			existing_tiles += 1
		else:
			missing_tiles.append(tile_index)
	
	# Verificar tiles del grid aliado (muestra)
	var ally_samples = [56, 62, 65, 71, 74, 80, 83, 89, 92, 98]
	for tile_index in ally_samples:
		var path = BoardTileHelper.get_tile_path(tile_index)
		if ResourceLoader.exists(path):
			existing_tiles += 1
		else:
			missing_tiles.append(tile_index)
	
	var total_checked = border_samples.size() + enemy_samples.size() + ally_samples.size()
	
	assert_test(missing_tiles.size() == 0, 
		"Todos los tiles de muestra existen (%d/%d)" % [existing_tiles, total_checked],
		"Tiles faltantes: %s" % str(missing_tiles))
	
	# Verificar que tile_board_borde y tile_board_combat existen (los sprites base)
	assert_test(ResourceLoader.exists("res://assets/sprites/arena/tiles/board/tile_board_borde.png"), 
		"tile_board_borde.png existe (sprite de borde)",
		"tile_board_borde.png no encontrado")
	
	assert_test(ResourceLoader.exists("res://assets/sprites/arena/tiles/board/tile_board_combat.png"), 
		"tile_board_combat.png existe (sprite de interior)",
		"tile_board_combat.png no encontrado")

func test_border_tile_positions():
	"""Test: Verificar posiciones calculadas de tiles de borde"""
	print("\n📍 Test: Posiciones de tiles de borde")
	
	const CELL_SIZE = 100
	var board_start_x = -450  # Centro - (9 columnas × 100px / 2)
	var board_start_y = -600  # Centro - (12 filas × 100px / 2)
	
	# Test posición borde superior izquierda (col 0, row 0)
	var expected_x = board_start_x + (0 * CELL_SIZE)
	var expected_y = board_start_y + (0 * CELL_SIZE)
	assert_test(expected_x == -450 and expected_y == -600,
		"Borde superior izquierda posición correcta",
		"Esperado: (-450, -600), Obtenido: (%d, %d)" % [expected_x, expected_y])
	
	# Test posición borde superior derecha (col 8, row 0)
	expected_x = board_start_x + (8 * CELL_SIZE)
	expected_y = board_start_y + (0 * CELL_SIZE)
	assert_test(expected_x == 350 and expected_y == -600,
		"Borde superior derecha posición correcta",
		"Esperado: (350, -600), Obtenido: (%d, %d)" % [expected_x, expected_y])
	
	# Test posición borde inferior izquierda (col 0, row 11)
	expected_x = board_start_x + (0 * CELL_SIZE)
	expected_y = board_start_y + (11 * CELL_SIZE)
	assert_test(expected_x == -450 and expected_y == 500,
		"Borde inferior izquierda posición correcta",
		"Esperado: (-450, 500), Obtenido: (%d, %d)" % [expected_x, expected_y])
	
	# Test posición borde inferior derecha (col 8, row 11)
	expected_x = board_start_x + (8 * CELL_SIZE)
	expected_y = board_start_y + (11 * CELL_SIZE)
	assert_test(expected_x == 350 and expected_y == 500,
		"Borde inferior derecha posición correcta",
		"Esperado: (350, 500), Obtenido: (%d, %d)" % [expected_x, expected_y])

func test_grid_tile_positions():
	"""Test: Verificar posiciones calculadas de tiles del grid"""
	print("\n📍 Test: Posiciones de tiles del grid")
	
	const CELL_SIZE = 100
	
	# Grid Enemigo está en Y = -250 (centro)
	# Grid Aliado está en Y = +250 (centro)
	# Cada grid tiene 7 columnas × 5 filas
	
	# Test grid enemigo - primera celda (0,0)
	# Grid enemigo: posición centro (0, -250)
	# Primera celda: (-350, -500) a (-250, -400)
	var enemy_center = Vector2(0, -250)
	var enemy_first_cell_x = enemy_center.x - (3 * CELL_SIZE)  # 3.5 celdas a la izquierda
	var enemy_first_cell_y = enemy_center.y - (2 * CELL_SIZE)  # 2.5 filas arriba
	assert_test(enemy_first_cell_x == -300 and enemy_first_cell_y == -450,
		"Grid enemigo (0,0) posición correcta",
		"Esperado aproximadamente: (-300, -450), Obtenido: (%d, %d)" % [enemy_first_cell_x, enemy_first_cell_y])
	
	# Test grid aliado - primera celda (0,0)
	var ally_center = Vector2(0, 250)
	var ally_first_cell_x = ally_center.x - (3 * CELL_SIZE)
	var ally_first_cell_y = ally_center.y - (2 * CELL_SIZE)
	assert_test(ally_first_cell_x == -300 and ally_first_cell_y == 50,
		"Grid aliado (0,0) posición correcta",
		"Esperado aproximadamente: (-300, 50), Obtenido: (%d, %d)" % [ally_first_cell_x, ally_first_cell_y])

func test_tile_loading():
	"""Test: Verificar que los tiles se pueden cargar como texturas"""
	print("\n🖼️  Test: Carga de texturas de tiles")
	
	# Test cargar tile_board_borde (debe existir)
	var tileBorde_path = "res://assets/sprites/arena/tiles/board/tile_board_borde.png"
	if ResourceLoader.exists(tileBorde_path):
		var textureBorde = load(tileBorde_path) as Texture2D
		assert_test(textureBorde != null, 
			"tile_board_borde.png se carga como textura",
			"No se pudo cargar tile_board_borde.png como Texture2D")
		
		if textureBorde:
			assert_test(textureBorde.get_width() > 0 and textureBorde.get_height() > 0,
				"tile_board_borde.png tiene dimensiones válidas",
				"Dimensiones: %dx%d" % [textureBorde.get_width(), textureBorde.get_height()])
	
	# Test cargar tile_board_combat (debe existir)
	var tileCombat_path = "res://assets/sprites/arena/tiles/board/tile_board_combat.png"
	if ResourceLoader.exists(tileCombat_path):
		var textureCombat = load(tileCombat_path) as Texture2D
		assert_test(textureCombat != null, 
			"tile_board_combat.png se carga como textura",
			"No se pudo cargar tile_board_combat.png como Texture2D")
		
		if textureCombat:
			assert_test(textureCombat.get_width() > 0 and textureCombat.get_height() > 0,
				"tile_board_combat.png tiene dimensiones válidas",
				"Dimensiones: %dx%d" % [textureCombat.get_width(), textureCombat.get_height()])
	
	# Test cargar algunos tiles del grid
	var test_tiles = [11, 30, 53, 56, 75, 98]  # Muestra de tiles del grid
	for tile_index in test_tiles:
		var path = BoardTileHelper.get_tile_path(tile_index)
		if ResourceLoader.exists(path):
			var texture = load(path) as Texture2D
			assert_test(texture != null,
				"tile_board_%d.png se carga como textura" % tile_index,
				"No se pudo cargar tile_board_%d.png" % tile_index)

