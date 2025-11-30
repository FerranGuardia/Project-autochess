extends Node
class_name CombatTests

## Tests unitarios para el sistema de combate y resurrección
## Ejecutar desde el editor o desde código

var tests_passed: int = 0
var tests_failed: int = 0

# Referencias para los tests
var combat_system: CombatSystem = null
var grid_ally: GridAlly = null
var grid_enemy: GridEnemy = null
var game_manager: GameManager = null

func _ready():
	print("==================================================")
	print("🧪 INICIANDO TESTS DEL SISTEMA DE COMBATE")
	print("==================================================")
	
	# Crear componentes necesarios para los tests
	setup_test_environment()
	
	# Ejecutar todos los tests
	run_all_combat_system_tests()
	run_all_resurrection_tests()
	run_all_loot_tests()
	
	# Limpiar después de los tests
	cleanup_test_environment()
	
	# Mostrar resumen
	print("==================================================")
	print("📊 RESUMEN DE TESTS DE COMBATE")
	print("✅ Tests pasados: ", tests_passed)
	print("❌ Tests fallados: ", tests_failed)
	print("==================================================")

func setup_test_environment():
	"""Configura el entorno de testing"""
	# Crear GameManager
	game_manager = GameManager.new()
	game_manager.name = "TestGameManager"
	add_child(game_manager)
	
	# Crear GridAlly
	grid_ally = GridAlly.new()
	grid_ally.name = "TestGridAlly"
	grid_ally.position = Vector2(0, 2000)  # Fuera de vista
	add_child(grid_ally)
	
	# Crear GridEnemy
	grid_enemy = GridEnemy.new()
	grid_enemy.name = "TestGridEnemy"
	grid_enemy.position = Vector2(0, 2000)  # Fuera de vista
	add_child(grid_enemy)
	
	# Conectar GridEnemy con GameManager
	grid_enemy.set_game_manager(game_manager)
	
	# Crear CombatSystem
	combat_system = CombatSystem.new()
	combat_system.name = "TestCombatSystem"
	add_child(combat_system)
	combat_system.initialize(grid_ally, grid_enemy, game_manager)
	
	print("✅ Entorno de testing configurado")

func cleanup_test_environment():
	"""Limpia el entorno de testing"""
	# Limpiar unidades
	if grid_ally:
		# Remover todas las unidades
		var all_units = grid_ally.get_all_units()
		for unit in all_units:
			if is_instance_valid(unit):
				grid_ally.remove_unit(unit)
				unit.queue_free()
	
	if grid_enemy:
		grid_enemy.clear_all_enemies()
	
	# Detener combate si está activo
	if combat_system and combat_system.is_combat_active:
		combat_system.stop_combat()

# ========== Tests del Sistema de Combate ==========

func run_all_combat_system_tests():
	"""Ejecuta todos los tests del sistema de combate"""
	print("\n⚔️ TESTS DEL SISTEMA DE COMBATE\n")
	
	test_combat_system_initialization()
	test_start_combat()
	test_stop_combat()
	test_collect_combat_units()
	test_find_nearest_target()
	test_get_unit_attack_range()
	test_get_unit_attack()
	test_get_unit_defense()
	test_attack_target()
	test_check_combat_end()

func test_combat_system_initialization():
	"""Test: CombatSystem se inicializa correctamente"""
	print("📋 Test: Inicialización del sistema de combate")
	
	if combat_system and grid_ally and grid_enemy and game_manager:
		print("  ✅ PASÓ: CombatSystem inicializado correctamente")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: CombatSystem no se inicializó correctamente")
		tests_failed += 1

func test_start_combat():
	"""Test: Iniciar combate funciona correctamente"""
	print("📋 Test: Iniciar combate")
	
	# Colocar algunas unidades
	var unit1 = Unit.new()
	unit1.initialize(UnitData.UnitType.MAGO)
	grid_ally.place_unit(unit1, 3, 2)
	
	var enemy1 = Unit.new()
	enemy1.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
	grid_enemy.place_enemy(enemy1, 3, 0)
	
	# Iniciar combate
	combat_system.start_combat()
	
	if combat_system.is_combat_active:
		print("  ✅ PASÓ: Combate iniciado correctamente")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Combate no se inició")
		tests_failed += 1
	
	# Detener combate
	combat_system.stop_combat()
	
	# Limpiar
	grid_ally.remove_unit(unit1)
	grid_enemy.remove_enemy(enemy1, false)
	unit1.queue_free()
	enemy1.queue_free()

func test_stop_combat():
	"""Test: Detener combate funciona correctamente"""
	print("📋 Test: Detener combate")
	
	# Iniciar combate primero
	combat_system.start_combat()
	
	# Detener combate
	combat_system.stop_combat()
	
	if not combat_system.is_combat_active:
		print("  ✅ PASÓ: Combate detenido correctamente")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Combate no se detuvo")
		tests_failed += 1

func test_collect_combat_units():
	"""Test: Recopilar unidades de combate funciona correctamente"""
	print("📋 Test: Recopilar unidades de combate")
	
	# Colocar unidades aliadas
	var unit1 = Unit.new()
	unit1.initialize(UnitData.UnitType.MAGO)
	grid_ally.place_unit(unit1, 3, 2)
	
	var unit2 = Unit.new()
	unit2.initialize(UnitData.UnitType.ELFO)
	grid_ally.place_unit(unit2, 2, 2)
	
	# Colocar enemigos
	var enemy1 = Unit.new()
	enemy1.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
	grid_enemy.place_enemy(enemy1, 3, 0)
	
	# Recopilar unidades
	combat_system.collect_combat_units()
	
	var ally_count = combat_system.ally_units.size()
	var enemy_count = combat_system.enemy_units.size()
	
	if ally_count == 2 and enemy_count == 1:
		print("  ✅ PASÓ: Unidades recopiladas correctamente (Aliados: ", ally_count, ", Enemigos: ", enemy_count, ")")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Unidades no recopiladas correctamente (Aliados: ", ally_count, ", Enemigos: ", enemy_count, ")")
		tests_failed += 1
	
	# Limpiar
	grid_ally.remove_unit(unit1)
	grid_ally.remove_unit(unit2)
	grid_enemy.remove_enemy(enemy1, false)
	unit1.queue_free()
	unit2.queue_free()
	enemy1.queue_free()

func test_find_nearest_target():
	"""Test: Encontrar objetivo más cercano funciona correctamente"""
	print("📋 Test: Encontrar objetivo más cercano")
	
	# Colocar unidad aliada
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.MAGO)
	grid_ally.place_unit(unit, 3, 2)
	unit.global_position = Vector2(350, 250)  # Posición específica
	
	# Colocar enemigos en diferentes posiciones
	var enemy1 = Unit.new()
	enemy1.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
	grid_enemy.place_enemy(enemy1, 3, 0)
	enemy1.global_position = Vector2(350, 50)  # Más cercano
	
	var enemy2 = Unit.new()
	enemy2.initialize_enemy(EnemyData.EnemyType.GOBLIN_DAGGER)
	grid_enemy.place_enemy(enemy2, 0, 0)
	enemy2.global_position = Vector2(50, 50)  # Más lejano
	
	# Recopilar unidades
	combat_system.collect_combat_units()
	
	# Encontrar objetivo más cercano
	var targets: Array[Unit] = combat_system.enemy_units
	var nearest = combat_system.find_nearest_target(unit, targets)
	
	if nearest == enemy1:
		print("  ✅ PASÓ: Objetivo más cercano encontrado correctamente")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Objetivo más cercano incorrecto")
		tests_failed += 1
	
	# Limpiar
	grid_ally.remove_unit(unit)
	grid_enemy.remove_enemy(enemy1, false)
	grid_enemy.remove_enemy(enemy2, false)
	unit.queue_free()
	enemy1.queue_free()
	enemy2.queue_free()

func test_get_unit_attack_range():
	"""Test: Obtener rango de ataque funciona correctamente"""
	print("📋 Test: Obtener rango de ataque")
	
	# Test con unidad aliada
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.MAGO)
	var range_ally = combat_system.get_unit_attack_range(unit)
	
	# Test con enemigo
	var enemy = Unit.new()
	enemy.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
	var range_enemy = combat_system.get_unit_attack_range(enemy)
	
	# Mago tiene rango 3 = 300px, Goblin_BOW tiene rango 3 = 300px
	if range_ally == 300.0 and range_enemy == 300.0:
		print("  ✅ PASÓ: Rangos de ataque correctos (Aliado: ", range_ally, ", Enemigo: ", range_enemy, ")")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Rangos de ataque incorrectos (Aliado: ", range_ally, ", Enemigo: ", range_enemy, ")")
		tests_failed += 1
	
	unit.queue_free()
	enemy.queue_free()

func test_get_unit_attack():
	"""Test: Obtener ataque de unidad funciona correctamente"""
	print("📋 Test: Obtener ataque de unidad")
	
	# Test con unidad aliada
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.MAGO)
	var attack_ally = combat_system.get_unit_attack(unit)
	
	# Test con enemigo
	var enemy = Unit.new()
	enemy.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
	var attack_enemy = combat_system.get_unit_attack(enemy)
	
	# Mago tiene ataque 20, Goblin_BOW tiene ataque 15
	if attack_ally == 20 and attack_enemy == 15:
		print("  ✅ PASÓ: Ataques correctos (Aliado: ", attack_ally, ", Enemigo: ", attack_enemy, ")")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Ataques incorrectos (Aliado: ", attack_ally, ", Enemigo: ", attack_enemy, ")")
		tests_failed += 1
	
	unit.queue_free()
	enemy.queue_free()

func test_get_unit_defense():
	"""Test: Obtener defensa de unidad funciona correctamente"""
	print("📋 Test: Obtener defensa de unidad")
	
	# Test con unidad aliada
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.ORCO)
	var defense_ally = combat_system.get_unit_defense(unit)
	
	# Test con enemigo
	var enemy = Unit.new()
	enemy.initialize_enemy(EnemyData.EnemyType.GOBLIN_SHIELD)
	var defense_enemy = combat_system.get_unit_defense(enemy)
	
	# Orco tiene defensa 10, Goblin_SHIELD tiene defensa 10
	if defense_ally == 10 and defense_enemy == 10:
		print("  ✅ PASÓ: Defensas correctas (Aliado: ", defense_ally, ", Enemigo: ", defense_enemy, ")")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Defensas incorrectas (Aliado: ", defense_ally, ", Enemigo: ", defense_enemy, ")")
		tests_failed += 1
	
	unit.queue_free()
	enemy.queue_free()

func test_attack_target():
	"""Test: Atacar objetivo funciona correctamente"""
	print("📋 Test: Atacar objetivo")
	
	# Crear unidad atacante
	var attacker = Unit.new()
	attacker.initialize(UnitData.UnitType.MAGO)
	grid_ally.place_unit(attacker, 3, 2)
	
	# Crear unidad objetivo
	var target = Unit.new()
	target.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
	grid_enemy.place_enemy(target, 3, 0)
	
	var initial_health = target.current_health
	
	# Atacar
	combat_system.attack_target(attacker, target)
	
	var final_health = target.current_health
	
	# El daño debería ser: ataque (20) - defensa (5) = 15, mínimo 1
	# Entonces debería ser 15 de daño
	var expected_damage = max(1, 20 - 5)
	var actual_damage = initial_health - final_health
	
	if actual_damage == expected_damage:
		print("  ✅ PASÓ: Ataque aplicado correctamente (Daño: ", actual_damage, ")")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Ataque incorrecto (Esperado: ", expected_damage, ", Obtenido: ", actual_damage, ")")
		tests_failed += 1
	
	# Limpiar
	grid_ally.remove_unit(attacker)
	grid_enemy.remove_enemy(target, false)
	attacker.queue_free()
	target.queue_free()

func test_check_combat_end():
	"""Test: Verificar fin de combate funciona correctamente"""
	print("📋 Test: Verificar fin de combate")
	
	# Caso 1: Todas las unidades aliadas vivas, enemigos vivos
	var unit1 = Unit.new()
	unit1.initialize(UnitData.UnitType.MAGO)
	grid_ally.place_unit(unit1, 3, 2)
	
	var enemy1 = Unit.new()
	enemy1.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
	grid_enemy.place_enemy(enemy1, 3, 0)
	
	combat_system.collect_combat_units()
	var should_continue = combat_system.check_combat_end()
	
	if not should_continue:
		print("  ✅ PASÓ: Combate no termina cuando hay unidades vivas")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Combate terminó incorrectamente")
		tests_failed += 1
	
	# Caso 2: Todos los enemigos muertos (victoria)
	enemy1.take_damage(1000)  # Matar enemigo
	combat_system.collect_combat_units()
	should_continue = combat_system.check_combat_end()
	
	if should_continue:
		print("  ✅ PASÓ: Combate termina cuando todos los enemigos mueren")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Combate no terminó cuando todos los enemigos murieron")
		tests_failed += 1
	
	# Limpiar
	grid_ally.remove_unit(unit1)
	grid_enemy.remove_enemy(enemy1, false)
	unit1.queue_free()
	enemy1.queue_free()

# ========== Tests del Sistema de Resurrección ==========

func run_all_resurrection_tests():
	"""Ejecuta todos los tests del sistema de resurrección"""
	print("\n🔄 TESTS DEL SISTEMA DE RESURRECCIÓN\n")
	
	test_save_initial_positions()
	test_resurrect_all_units()
	test_resurrect_dead_units()
	test_restore_positions()
	test_resurrect_no_conflicts()

func test_save_initial_positions():
	"""Test: Guardar posiciones iniciales funciona correctamente"""
	print("📋 Test: Guardar posiciones iniciales")
	
	# Colocar unidades en el grid
	var unit1 = Unit.new()
	unit1.initialize(UnitData.UnitType.MAGO)
	grid_ally.place_unit(unit1, 3, 2)
	
	var unit2 = Unit.new()
	unit2.initialize(UnitData.UnitType.ELFO)
	grid_ally.place_unit(unit2, 2, 2)
	
	# Guardar posiciones
	grid_ally.save_initial_positions()
	
	var saved_count = grid_ally.initial_positions.size()
	
	if saved_count == 2:
		print("  ✅ PASÓ: Posiciones iniciales guardadas correctamente (", saved_count, " unidades)")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Posiciones no guardadas correctamente (Esperado: 2, Obtenido: ", saved_count, ")")
		tests_failed += 1
	
	# Limpiar
	grid_ally.remove_unit(unit1)
	grid_ally.remove_unit(unit2)
	unit1.queue_free()
	unit2.queue_free()

func test_resurrect_all_units():
	"""Test: Resucitar todas las unidades funciona correctamente"""
	print("📋 Test: Resucitar todas las unidades")
	
	# Colocar unidades y guardar posiciones
	var unit1 = Unit.new()
	unit1.initialize(UnitData.UnitType.MAGO)
	grid_ally.place_unit(unit1, 3, 2)
	
	var unit2 = Unit.new()
	unit2.initialize(UnitData.UnitType.ELFO)
	grid_ally.place_unit(unit2, 2, 2)
	
	grid_ally.save_initial_positions()
	
	# Matar unidades
	unit1.take_damage(1000)
	unit2.take_damage(1000)
	
	# Resucitar
	grid_ally.resurrect_all_units()
	
	var all_alive = unit1.is_alive() and unit2.is_alive()
	var health_restored = unit1.current_health == unit1.max_health and unit2.current_health == unit2.max_health
	
	if all_alive and health_restored:
		print("  ✅ PASÓ: Todas las unidades resucitaron correctamente")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Unidades no resucitaron correctamente")
		tests_failed += 1
	
	# Limpiar
	grid_ally.remove_unit(unit1)
	grid_ally.remove_unit(unit2)
	unit1.queue_free()
	unit2.queue_free()

func test_resurrect_dead_units():
	"""Test: Solo las unidades muertas se resucitan"""
	print("📋 Test: Resucitar solo unidades muertas")
	
	# Colocar unidades
	var unit1 = Unit.new()
	unit1.initialize(UnitData.UnitType.MAGO)
	grid_ally.place_unit(unit1, 3, 2)
	
	var unit2 = Unit.new()
	unit2.initialize(UnitData.UnitType.ELFO)
	grid_ally.place_unit(unit2, 2, 2)
	
	grid_ally.save_initial_positions()
	
	# Matar solo una unidad
	unit1.take_damage(1000)
	# unit2 permanece viva
	
	var unit1_was_dead = not unit1.is_alive()
	var unit2_was_alive = unit2.is_alive()
	
	# Resucitar
	grid_ally.resurrect_all_units()
	
	var unit1_resurrected = unit1.is_alive()
	var unit2_still_alive = unit2.is_alive()
	
	if unit1_resurrected and unit2_still_alive:
		print("  ✅ PASÓ: Solo unidades muertas se resucitaron")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Resurrección incorrecta")
		tests_failed += 1
	
	# Limpiar
	grid_ally.remove_unit(unit1)
	grid_ally.remove_unit(unit2)
	unit1.queue_free()
	unit2.queue_free()

func test_restore_positions():
	"""Test: Restaurar posiciones iniciales funciona correctamente"""
	print("📋 Test: Restaurar posiciones iniciales")
	
	# Colocar unidades en posiciones específicas
	var unit1 = Unit.new()
	unit1.initialize(UnitData.UnitType.MAGO)
	grid_ally.place_unit(unit1, 3, 2)
	
	var unit2 = Unit.new()
	unit2.initialize(UnitData.UnitType.ELFO)
	grid_ally.place_unit(unit2, 2, 2)
	
	grid_ally.save_initial_positions()
	
	# Mover unidades a otras posiciones
	grid_ally.remove_unit(unit1)
	grid_ally.remove_unit(unit2)
	grid_ally.place_unit(unit1, 0, 0)
	grid_ally.place_unit(unit2, 1, 1)
	
	# Restaurar posiciones
	grid_ally.resurrect_all_units()
	
	var unit1_restored = unit1.get_grid_position() == Vector2i(3, 2)
	var unit2_restored = unit2.get_grid_position() == Vector2i(2, 2)
	
	if unit1_restored and unit2_restored:
		print("  ✅ PASÓ: Posiciones restauradas correctamente")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Posiciones no restauradas correctamente")
		tests_failed += 1
	
	# Limpiar
	grid_ally.remove_unit(unit1)
	grid_ally.remove_unit(unit2)
	unit1.queue_free()
	unit2.queue_free()

func test_resurrect_no_conflicts():
	"""Test: Resurrección no causa conflictos de celdas ocupadas"""
	print("📋 Test: Resurrección sin conflictos")
	
	# Colocar unidades
	var unit1 = Unit.new()
	unit1.initialize(UnitData.UnitType.MAGO)
	grid_ally.place_unit(unit1, 3, 2)
	
	var unit2 = Unit.new()
	unit2.initialize(UnitData.UnitType.ELFO)
	grid_ally.place_unit(unit2, 2, 2)
	
	grid_ally.save_initial_positions()
	
	# Matar y mover unidades
	unit1.take_damage(1000)
	unit2.take_damage(1000)
	
	# Intentar resucitar (no debería dar error de celda ocupada)
	var error_occurred = false
	grid_ally.resurrect_all_units()
	
	# Verificar que no hay conflictos
	var unit1_in_position = grid_ally.get_unit_at(3, 2) == unit1
	var unit2_in_position = grid_ally.get_unit_at(2, 2) == unit2
	
	if unit1_in_position and unit2_in_position and not error_occurred:
		print("  ✅ PASÓ: Resurrección sin conflictos de celdas")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Resurrección causó conflictos")
		tests_failed += 1
	
	# Limpiar
	grid_ally.remove_unit(unit1)
	grid_ally.remove_unit(unit2)
	unit1.queue_free()
	unit2.queue_free()

# ========== Tests del Sistema de Loot ==========

func run_all_loot_tests():
	"""Ejecuta todos los tests del sistema de loot"""
	print("\n💰 TESTS DEL SISTEMA DE LOOT\n")
	
	test_enemy_death_gives_loot()
	test_different_enemies_give_different_loot()
	test_loot_adds_to_gold()

func test_enemy_death_gives_loot():
	"""Test: Muerte de enemigo otorga loot"""
	print("📋 Test: Muerte de enemigo otorga loot")
	
	var initial_gold = game_manager.get_gold()
	
	# Crear enemigo
	var enemy = Unit.new()
	enemy.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
	grid_enemy.place_enemy(enemy, 3, 0)
	
	# Simular muerte de enemigo
	grid_enemy.on_enemy_died(enemy)
	
	var final_gold = game_manager.get_gold()
	var gold_gained = final_gold - initial_gold
	
	# Goblin_BOW otorga 1 oro
	if gold_gained == 1:
		print("  ✅ PASÓ: Enemigo otorgó loot correctamente (+", gold_gained, " oro)")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Loot incorrecto (Esperado: +1, Obtenido: +", gold_gained, ")")
		tests_failed += 1
	
	# Restaurar oro inicial
	game_manager.gold = initial_gold

func test_different_enemies_give_different_loot():
	"""Test: Diferentes enemigos otorgan diferente loot"""
	print("📋 Test: Diferentes enemigos otorgan diferente loot")
	
	var initial_gold = game_manager.get_gold()
	
	# Crear diferentes enemigos
	var enemy1 = Unit.new()
	enemy1.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)  # 1 oro
	grid_enemy.place_enemy(enemy1, 3, 0)
	
	var enemy2 = Unit.new()
	enemy2.initialize_enemy(EnemyData.EnemyType.GOBLIN_DAGGER)  # 2 oro
	grid_enemy.place_enemy(enemy2, 2, 0)
	
	var enemy3 = Unit.new()
	enemy3.initialize_enemy(EnemyData.EnemyType.GOBLIN_SHIELD)  # 3 oro
	grid_enemy.place_enemy(enemy3, 1, 0)
	
	# Simular muertes
	grid_enemy.on_enemy_died(enemy1)
	var gold1 = game_manager.get_gold() - initial_gold
	
	grid_enemy.on_enemy_died(enemy2)
	var gold2 = game_manager.get_gold() - initial_gold
	
	grid_enemy.on_enemy_died(enemy3)
	var gold3 = game_manager.get_gold() - initial_gold
	
	# Verificar que cada enemigo otorgó diferente cantidad
	if gold1 == 1 and gold2 == 3 and gold3 == 6:  # 1+2+3 = 6 total
		print("  ✅ PASÓ: Diferentes enemigos otorgan diferente loot")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Loot incorrecto (Esperado: 1, 3, 6; Obtenido: ", gold1, ", ", gold2, ", ", gold3, ")")
		tests_failed += 1
	
	# Restaurar oro inicial
	game_manager.gold = initial_gold

func test_loot_adds_to_gold():
	"""Test: El loot se suma correctamente al oro"""
	print("📋 Test: Loot se suma al oro")
	
	var initial_gold = game_manager.get_gold()
	
	# Crear enemigo
	var enemy = Unit.new()
	enemy.initialize_enemy(EnemyData.EnemyType.GOBLIN_DAGGER)  # 2 oro
	grid_enemy.place_enemy(enemy, 3, 0)
	
	# Simular muerte
	grid_enemy.on_enemy_died(enemy)
	
	var final_gold = game_manager.get_gold()
	var expected_gold = initial_gold + 2
	
	if final_gold == expected_gold:
		print("  ✅ PASÓ: Loot se sumó correctamente al oro (", initial_gold, " + 2 = ", final_gold, ")")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Loot no se sumó correctamente (Esperado: ", expected_gold, ", Obtenido: ", final_gold, ")")
		tests_failed += 1
	
	# Restaurar oro inicial
	game_manager.gold = initial_gold

