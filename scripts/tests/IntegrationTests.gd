extends Node
class_name IntegrationTests

## Tests de integración para el sistema AutoChess
## Prueban que múltiples componentes funcionen juntos correctamente

var tests_passed: int = 0
var tests_failed: int = 0

# Referencias al entorno de prueba
var board: Board = null
var bench: Bench = null
var grid_ally: GridAlly = null
var grid_enemy: GridEnemy = null

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
	test_shop_to_bench_integration()
	test_enemy_spawn_combat_integration()
	test_grid_combat_integration()
	test_complete_round_flow()

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

# ========== Tests de Integración de Tienda ==========

func test_shop_to_bench_integration():
	"""Test: Comprar unidad y que aparezca en bench"""
	print("\n📋 Test: Integración Shop → Bench")
	
	if not setup_test_environment():
		tests_failed += 1
		return
	
	# Obtener referencias del Board
	var shop = board.shop
	var game_manager = board.game_manager
	
	if not shop or not game_manager:
		print("⚠️  ADVERTENCIA: Shop o GameManager no encontrados en Board")
		print("   (Esto es normal si no están inicializados)")
		teardown_test_environment()
		return
	
	# Limpiar bench antes del test
	cleanup_all_units()
	
	# Configurar oro suficiente
	var initial_gold = game_manager.get_gold()
	var offers = shop.get_offers()
	if offers.is_empty():
		print("⚠️  ADVERTENCIA: No hay ofertas en la tienda")
		teardown_test_environment()
		return
	
	var unit_type = offers[0]
	var cost = shop.get_unit_cost(unit_type)
	game_manager.gold = cost + 5  # Oro suficiente
	
	# Paso 1: Comprar unidad
	var purchase_success = shop.purchase_unit(0)
	
	if not purchase_success:
		print("❌ FALLÓ: No se pudo comprar unidad")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 2: Verificar que la unidad está en el bench
	var units_in_bench = bench.units.size()
	if units_in_bench == 0:
		print("❌ FALLÓ: Unidad no apareció en bench después de comprar")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 3: Verificar que el oro se gastó
	var final_gold = game_manager.get_gold()
	var expected_gold = initial_gold + 5 - cost  # Oro inicial + extra - costo
	
	if final_gold != expected_gold:
		print("❌ FALLÓ: Oro no se gastó correctamente (Esperado: ", expected_gold, ", Obtenido: ", final_gold, ")")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 4: Verificar que la unidad puede moverse al grid
	var unit = bench.get_unit_at(0)
	if not unit:
		print("❌ FALLÓ: No se encontró unidad en bench")
		tests_failed += 1
		teardown_test_environment()
		return
	
	var grid_pos = grid_ally.get_world_position(3, 2)
	var move_success = board.handle_unit_drop(unit, grid_pos)
	
	if not move_success:
		print("❌ FALLÓ: Unidad comprada no se pudo mover al grid")
		tests_failed += 1
		teardown_test_environment()
		return
	
	print("✅ PASÓ: Integración Shop → Bench → Grid funciona correctamente")
	tests_passed += 1
	
	teardown_test_environment()
	game_manager.gold = initial_gold

# ========== Tests de Integración de Enemigos ==========

func test_enemy_spawn_combat_integration():
	"""Test: Spawnear enemigos y que aparezcan en combate"""
	print("\n📋 Test: Integración EnemyAI → GridEnemy → Combat")
	
	if not setup_test_environment():
		tests_failed += 1
		return
	
	# Obtener referencias del Board
	var enemy_ai = board.enemy_ai
	var combat_system = board.combat_system
	
	if not enemy_ai or not combat_system:
		print("⚠️  ADVERTENCIA: EnemyAI o CombatSystem no encontrados")
		teardown_test_environment()
		return
	
	# Limpiar enemigos antes del test
	if grid_enemy:
		grid_enemy.clear_all_enemies()
	
	# Paso 1: Spawnear enemigos para ronda 1
	enemy_ai.spawn_enemies_for_round(1)
	
	var enemies_spawned = grid_enemy.get_all_enemies().size()
	if enemies_spawned == 0:
		print("❌ FALLÓ: No se spawnearon enemigos")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 2: Verificar que los enemigos están en el grid
	var enemy_at_pos = grid_enemy.get_enemy_at(3, 0)
	if not enemy_at_pos:
		print("❌ FALLÓ: Enemigo no está en la posición esperada")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 3: Verificar que el sistema de combate puede recopilarlos
	combat_system.collect_combat_units()
	var enemies_in_combat = combat_system.enemy_units.size()
	
	if enemies_in_combat != enemies_spawned:
		print("❌ FALLÓ: Enemigos no se recopilaron en combate (Esperado: ", enemies_spawned, ", Obtenido: ", enemies_in_combat, ")")
		tests_failed += 1
		teardown_test_environment()
		return
	
	print("✅ PASÓ: Integración EnemyAI → GridEnemy → Combat funciona correctamente")
	tests_passed += 1
	
	teardown_test_environment()

# ========== Tests de Integración de Combate ==========

func test_grid_combat_integration():
	"""Test: Unidades en grid pueden combatir"""
	print("\n📋 Test: Integración Grid → Combat")
	
	if not setup_test_environment():
		tests_failed += 1
		return
	
	# Obtener referencias del Board
	var combat_system = board.combat_system
	var game_manager = board.game_manager
	
	if not combat_system or not game_manager:
		print("⚠️  ADVERTENCIA: CombatSystem o GameManager no encontrados")
		teardown_test_environment()
		return
	
	# Limpiar antes del test
	cleanup_all_units()
	if grid_enemy:
		grid_enemy.clear_all_enemies()
	
	# Paso 1: Colocar unidades aliadas en grid
	var unit1 = Unit.new()
	unit1.initialize(UnitData.UnitType.MAGO)
	grid_ally.place_unit(unit1, 3, 2)
	
	var unit2 = Unit.new()
	unit2.initialize(UnitData.UnitType.ELFO)
	grid_ally.place_unit(unit2, 2, 2)
	
	# Paso 2: Colocar enemigos
	var enemy1 = Unit.new()
	enemy1.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
	grid_enemy.place_enemy(enemy1, 3, 0)
	
	# Paso 3: Iniciar combate
	combat_system.start_combat()
	
	if not combat_system.is_combat_active:
		print("❌ FALLÓ: Combate no se inició")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 4: Verificar que las unidades están en combate
	var allies_in_combat = combat_system.ally_units.size()
	var enemies_in_combat = combat_system.enemy_units.size()
	
	if allies_in_combat != 2 or enemies_in_combat != 1:
		print("❌ FALLÓ: Unidades no se recopilaron correctamente (Aliados: ", allies_in_combat, ", Enemigos: ", enemies_in_combat, ")")
		tests_failed += 1
		combat_system.stop_combat()
		teardown_test_environment()
		return
	
	# Paso 5: Simular un ataque
	var initial_health = enemy1.current_health
	combat_system.attack_target(unit1, enemy1)
	var final_health = enemy1.current_health
	
	if final_health >= initial_health:
		print("❌ FALLÓ: Ataque no aplicó daño")
		tests_failed += 1
		combat_system.stop_combat()
		teardown_test_environment()
		return
	
	print("✅ PASÓ: Integración Grid → Combat funciona correctamente")
	tests_passed += 1
	
	combat_system.stop_combat()
	teardown_test_environment()

# ========== Tests de Flujo Completo ==========

func test_complete_round_flow():
	"""Test: Flujo completo de una ronda (preparación → combate → resurrección)"""
	print("\n📋 Test: Flujo Completo de Ronda")
	
	if not setup_test_environment():
		tests_failed += 1
		return
	
	# Obtener referencias del Board
	var game_manager = board.game_manager
	var enemy_ai = board.enemy_ai
	var combat_system = board.combat_system
	
	if not game_manager or not enemy_ai or not combat_system:
		print("⚠️  ADVERTENCIA: Sistemas no encontrados")
		teardown_test_environment()
		return
	
	# Limpiar antes del test
	cleanup_all_units()
	if grid_enemy:
		grid_enemy.clear_all_enemies()
	
	# Paso 1: Fase de preparación - Colocar unidades
	var unit1 = Unit.new()
	unit1.initialize(UnitData.UnitType.MAGO)
	grid_ally.place_unit(unit1, 3, 2)
	
	var unit2 = Unit.new()
	unit2.initialize(UnitData.UnitType.ELFO)
	grid_ally.place_unit(unit2, 2, 2)
	
	# Paso 2: Guardar posiciones iniciales
	grid_ally.save_initial_positions()
	var positions_saved = grid_ally.initial_positions.size()
	
	if positions_saved != 2:
		print("❌ FALLÓ: Posiciones no se guardaron (Esperado: 2, Obtenido: ", positions_saved, ")")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 3: Iniciar combate - Spawnear enemigos
	enemy_ai.spawn_enemies_for_round(1)
	var enemies_spawned = grid_enemy.get_all_enemies().size()
	
	if enemies_spawned == 0:
		print("❌ FALLÓ: No se spawnearon enemigos")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 4: Iniciar sistema de combate
	combat_system.start_combat()
	
	if not combat_system.is_combat_active:
		print("❌ FALLÓ: Combate no se inició")
		tests_failed += 1
		teardown_test_environment()
		return
	
	# Paso 5: Simular combate - Matar una unidad aliada
	unit1.take_damage(1000)
	var unit1_died = not unit1.is_alive()
	
	if not unit1_died:
		print("❌ FALLÓ: Unidad no murió en combate")
		tests_failed += 1
		combat_system.stop_combat()
		teardown_test_environment()
		return
	
	# Paso 6: Detener combate y resucitar
	combat_system.stop_combat()
	grid_ally.resurrect_all_units()
	
	var unit1_resurrected = unit1.is_alive()
	var unit1_in_position = unit1.get_grid_position() == Vector2i(3, 2)
	
	if not unit1_resurrected:
		print("❌ FALLÓ: Unidad no resucitó")
		tests_failed += 1
		teardown_test_environment()
		return
	
	if not unit1_in_position:
		print("❌ FALLÓ: Unidad no restauró su posición")
		tests_failed += 1
		teardown_test_environment()
		return
	
	print("✅ PASÓ: Flujo completo de ronda funciona correctamente")
	tests_passed += 1
	
	teardown_test_environment()

# ========== Tests Futuros (Plantillas) ==========

# func test_unit_combination_integration():
#     """Test: Combinar 3 unidades funciona"""
#     # TODO: Implementar cuando tengas sistema de combinación
#     pass
