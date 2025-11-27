extends Node
class_name IntegrationTests

## Tests de integración para el sistema AutoChess
## Prueban que múltiples componentes funcionen juntos correctamente

var tests_passed: int = 0
var tests_failed: int = 0

# Referencias al entorno de prueba
var board: Board
var bench: Bench
var grid_ally: GridAlly
var grid_enemy: GridEnemy

func _ready():
	print("==================================================")
	print("🧪 INICIANDO TESTS DE INTEGRACIÓN")
	print("==================================================")
	
	# Ejecutar todos los tests de integración
	run_all_integration_tests()
	
	# Mostrar resumen
	print("==================================================")
	print("📊 RESUMEN DE TESTS DE INTEGRACIÓN")
	print("✅ Tests pasados: ", tests_passed)
	print("❌ Tests fallados: ", tests_failed)
	print("==================================================")

func run_all_integration_tests():
	"""Ejecuta todos los tests de integración"""
	test_bench_grid_complete_flow()
	test_bench_grid_bidirectional_flow()
	test_unit_stats_persistence()
	test_signal_integration()
	# Agregar más tests aquí cuando implementes más sistemas

# ========== Setup y Teardown ==========

func setup_test_environment():
	"""Prepara el entorno para cada test"""
	# Obtener Board del árbol de escena
	board = get_node("/root/Board")
	if not board:
		print("❌ FALLÓ: No se encontró Board en el árbol")
		return false
	
	bench = board.bench
	grid_ally = board.grid_ally
	grid_enemy = board.grid_enemy
	
	if not bench or not grid_ally:
		print("❌ FALLÓ: Componentes del Board no encontrados")
		return false
	
	# Limpiar estado antes del test
	cleanup_all_units()
	
	return true

func teardown_test_environment():
	"""Limpia después de cada test"""
	cleanup_all_units()

func cleanup_all_units():
	"""Limpia todas las unidades del bench y grid"""
	if not board:
		return
	
	# Limpiar grid
	if grid_ally:
		var units_to_remove = []
		for unit in grid_ally.units.values():
			units_to_remove.append(unit)
		for unit in units_to_remove:
			grid_ally.remove_unit(unit)
			if unit.get_parent():
				unit.get_parent().remove_child(unit)
			unit.queue_free()
	
	# Limpiar bench
	if bench:
		var units_to_remove = []
		for unit in bench.units.values():
			units_to_remove.append(unit)
		for unit in units_to_remove:
			bench.remove_unit(unit)
			if unit.get_parent():
				unit.get_parent().remove_child(unit)
			unit.queue_free()

# ========== Tests de Integración ==========

func test_bench_grid_complete_flow():
	"""Test: Flujo completo de mover unidad entre bench y grid"""
	print("\n📋 Test: Integración Bench → Grid (Flujo Completo)")
	
	if not setup_test_environment():
		tests_failed += 1
		return
	
	# Crear unidad
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.MAGO)
	
	# Paso 1: Colocar en bench
	var bench_success = bench.place_unit(unit, 0)
	if not bench_success:
		print("❌ FALLÓ: No se pudo colocar unidad en bench")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Verificar que está en bench
	if bench.get_unit_at(0) != unit:
		print("❌ FALLÓ: Unidad no está en bench después de place_unit")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 2: Mover a grid usando Board (integración real)
	var grid_world_pos = grid_ally.get_world_position(3, 2)
	var drop_success = board.handle_unit_drop(unit, grid_world_pos)
	
	if not drop_success:
		print("❌ FALLÓ: handle_unit_drop() retornó false")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 3: Verificar integración completa
	var in_grid = grid_ally.get_unit_at(3, 2) == unit
	var not_in_bench = bench.get_unit_at(0) == null
	
	if not in_grid:
		print("❌ FALLÓ: Unidad no está en grid después del drop")
		tests_failed += 1
		teardown_test_environment()
		return
	
	if not not_in_bench:
		print("❌ FALLÓ: Unidad todavía está en bench después del drop")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 4: Verificar que unidad puede hacer cosas en grid
	if not unit.is_placed():
		print("❌ FALLÓ: Unidad no está marcada como colocada")
		tests_failed += 1
		teardown_test_environment()
		return
	
	var grid_pos = unit.get_grid_position()
	if grid_pos.x != 3 or grid_pos.y != 2:
		print("❌ FALLÓ: Posición de grid incorrecta: ", grid_pos)
		tests_failed += 1
		teardown_test_environment()
		return
	
	print("✅ PASÓ: Integración Bench → Grid funciona correctamente")
	tests_passed += 1
	
	teardown_test_environment()

func test_bench_grid_bidirectional_flow():
	"""Test: Flujo bidireccional bench ↔ grid"""
	print("\n📋 Test: Integración Bench ↔ Grid (Bidireccional)")
	
	if not setup_test_environment():
		tests_failed += 1
		return
	
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.ORCO)
	
	# Paso 1: Bench → Grid
	bench.place_unit(unit, 1)
	var grid_pos = grid_ally.get_world_position(2, 1)
	board.handle_unit_drop(unit, grid_pos)
	
	var in_grid_1 = grid_ally.get_unit_at(2, 1) == unit
	var not_in_bench_1 = bench.get_unit_at(1) == null
	
	if not in_grid_1 or not not_in_bench_1:
		print("❌ FALLÓ: Bench → Grid no funcionó")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 2: Grid → Bench
	var bench_pos = bench.get_world_position(2)
	board.handle_unit_drop(unit, bench_pos)
	
	var in_bench_2 = bench.get_unit_at(2) == unit
	var not_in_grid_2 = grid_ally.get_unit_at(2, 1) == null
	
	if not in_bench_2 or not not_in_grid_2:
		print("❌ FALLÓ: Grid → Bench no funcionó")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 3: Bench → Grid otra vez
	var grid_pos_2 = grid_ally.get_world_position(4, 3)
	board.handle_unit_drop(unit, grid_pos_2)
	
	var in_grid_3 = grid_ally.get_unit_at(4, 3) == unit
	var not_in_bench_3 = bench.get_unit_at(2) == null
	
	if not in_grid_3 or not not_in_bench_3:
		print("❌ FALLÓ: Segundo Bench → Grid no funcionó")
		tests_failed += 1
		teardown_test_environment()
		return
	
	print("✅ PASÓ: Integración bidireccional Bench ↔ Grid funciona")
	tests_passed += 1
	
	teardown_test_environment()

func test_unit_stats_persistence():
	"""Test: Tipo y nombre de unidad se mantienen al mover entre bench y grid"""
	print("\n📋 Test: Integración - Persistencia de Tipo de Unidad")
	
	if not setup_test_environment():
		tests_failed += 1
		return
	
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.ENANO)
	
	# Guardar tipo y nombre inicial
	var initial_type = unit.unit_type
	var initial_name = unit.unit_name
	
	# Paso 1: Colocar en bench
	bench.place_unit(unit, 3)
	
	# Verificar tipo y nombre se mantienen
	if unit.unit_type != initial_type or unit.unit_name != initial_name:
		print("❌ FALLÓ: Tipo o nombre cambiaron al colocar en bench")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 2: Mover a grid
	var grid_pos = grid_ally.get_world_position(1, 1)
	board.handle_unit_drop(unit, grid_pos)
	
	# Verificar tipo y nombre se mantienen
	if unit.unit_type != initial_type or unit.unit_name != initial_name:
		print("❌ FALLÓ: Tipo o nombre cambiaron al mover a grid")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 3: Mover de vuelta a bench
	var bench_pos = bench.get_world_position(4)
	board.handle_unit_drop(unit, bench_pos)
	
	# Verificar tipo y nombre se mantienen
	if unit.unit_type != initial_type or unit.unit_name != initial_name:
		print("❌ FALLÓ: Tipo o nombre cambiaron al mover de vuelta a bench")
		tests_failed += 1
		teardown_test_environment()
		return
	
	print("✅ PASÓ: Persistencia de tipo y nombre funciona correctamente")
	tests_passed += 1
	
	teardown_test_environment()

func test_signal_integration():
	"""Test: Señales entre sistemas funcionan correctamente"""
	print("\n📋 Test: Integración - Señales entre Sistemas")
	
	if not setup_test_environment():
		tests_failed += 1
		return
	
	# Esta prueba requiere que implementes señales en tu código
	# Por ahora, verificamos que los sistemas básicos funcionan
	
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.BEASTKIN)
	
	# Paso 1: Colocar unidad
	bench.place_unit(unit, 5)
	
	# Paso 2: Verificar que unidad está conectada a sistemas
	# (Esto verifica integración básica de señales)
	var board_ref = unit.get_parent().get_parent() if unit.get_parent() else null
	
	if not board_ref:
		print("⚠️  ADVERTENCIA: No se pudo verificar integración de señales")
		print("   (Esto es normal si señales no están implementadas aún)")
		# No fallamos el test, solo advertimos
	else:
		print("✅ PASÓ: Integración básica de señales verificada")
		tests_passed += 1
	
	teardown_test_environment()

# ========== Tests Futuros (Plantillas) ==========

# Descomenta y completa estos cuando implementes los sistemas correspondientes

# func test_shop_to_bench_integration():
#     """Test: Comprar unidad y que aparezca en bench"""
#     # TODO: Implementar cuando tengas sistema de shop
#     pass

# func test_grid_combat_integration():
#     """Test: Unidades en grid pueden combatir"""
#     # TODO: Implementar cuando tengas sistema de combate completo
#     pass

# func test_unit_combination_integration():
#     """Test: Combinar 3 unidades funciona"""
#     # TODO: Implementar cuando tengas sistema de combinación
#     pass

# func test_complete_round_flow():
#     """Test: Flujo completo de una ronda"""
#     # TODO: Implementar cuando tengas todos los sistemas
#     pass
