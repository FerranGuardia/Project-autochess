extends Node
class_name EnemyTests

## Tests unitarios para el sistema de enemigos
## Ejecutar desde el editor o desde código

var tests_passed: int = 0
var tests_failed: int = 0

# Referencias para los tests
var grid_enemy: GridEnemy
var enemy_ai: EnemyAI
var board: Node2D  # Mock Board para EnemyAI

func _ready():
	print("==================================================")
	print("🧪 INICIANDO TESTS DEL SISTEMA DE ENEMIGOS")
	print("==================================================")
	
	# Crear componentes necesarios para los tests
	setup_test_environment()
	
	# Ejecutar todos los tests
	run_all_enemy_data_tests()
	run_all_grid_enemy_tests()
	run_all_enemy_ai_tests()
	
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
	# Crear GridEnemy
	grid_enemy = GridEnemy.new()
	grid_enemy.name = "TestGridEnemy"
	# Mover el grid de test fuera de la vista para que no interfiera visualmente
	# Lo ponemos muy abajo (Y = 2000) para que no se vea en pantalla
	grid_enemy.position = Vector2(0, 2000)
	add_child(grid_enemy)
	
	# Crear mock Board
	board = Node2D.new()
	board.name = "TestBoard"
	add_child(board)
	
	# Crear EnemyAI
	enemy_ai = EnemyAI.new()
	enemy_ai.name = "TestEnemyAI"
	add_child(enemy_ai)
	enemy_ai.initialize(grid_enemy, board)

func cleanup_test_environment():
	"""Limpia el entorno de testing"""
	# Limpiar enemigos del grid
	if grid_enemy:
		grid_enemy.clear_all_enemies()
	
	# Los nodos se eliminarán automáticamente cuando se elimine este nodo

# ========== Tests de EnemyData ==========

func run_all_enemy_data_tests():
	"""Ejecuta todos los tests de EnemyData"""
	test_enemy_data_names()
	test_enemy_data_sprite_paths()
	test_enemy_data_colors()
	test_enemy_data_stats()
	test_enemy_data_roles()

func test_enemy_data_names():
	"""Test: Verificar que los nombres de enemigos son correctos"""
	print("\n📋 Test: Nombres de enemigos")
	
	var goblin_bow_name = EnemyData.get_enemy_name(EnemyData.EnemyType.GOBLIN_BOW)
	var goblin_dagger_name = EnemyData.get_enemy_name(EnemyData.EnemyType.GOBLIN_DAGGER)
	var goblin_shield_name = EnemyData.get_enemy_name(EnemyData.EnemyType.GOBLIN_SHIELD)
	
	if goblin_bow_name == "Goblin Arquero":
		pass_test("GOBLIN_BOW tiene nombre correcto")
	else:
		fail_test("GOBLIN_BOW nombre incorrecto: " + goblin_bow_name)
	
	if goblin_dagger_name == "Goblin Asesino":
		pass_test("GOBLIN_DAGGER tiene nombre correcto")
	else:
		fail_test("GOBLIN_DAGGER nombre incorrecto: " + goblin_dagger_name)
	
	if goblin_shield_name == "Goblin Defensor":
		pass_test("GOBLIN_SHIELD tiene nombre correcto")
	else:
		fail_test("GOBLIN_SHIELD nombre incorrecto: " + goblin_shield_name)

func test_enemy_data_sprite_paths():
	"""Test: Verificar que las rutas de sprites son correctas"""
	print("\n📋 Test: Rutas de sprites de enemigos")
	
	var bow_path = EnemyData.get_enemy_sprite_path(EnemyData.EnemyType.GOBLIN_BOW)
	var dagger_path = EnemyData.get_enemy_sprite_path(EnemyData.EnemyType.GOBLIN_DAGGER)
	var shield_path = EnemyData.get_enemy_sprite_path(EnemyData.EnemyType.GOBLIN_SHIELD)
	
	# Verificar que las rutas contienen el nombre del archivo esperado
	if "goblinbow" in bow_path:
		pass_test("GOBLIN_BOW tiene ruta de sprite correcta")
	else:
		fail_test("GOBLIN_BOW ruta incorrecta: " + bow_path)
	
	if "goblindagger" in dagger_path:
		pass_test("GOBLIN_DAGGER tiene ruta de sprite correcta")
	else:
		fail_test("GOBLIN_DAGGER ruta incorrecta: " + dagger_path)
	
	if "goblinshield" in shield_path:
		pass_test("GOBLIN_SHIELD tiene ruta de sprite correcta")
	else:
		fail_test("GOBLIN_SHIELD ruta incorrecta: " + shield_path)

func test_enemy_data_colors():
	"""Test: Verificar que los colores de enemigos son correctos"""
	print("\n📋 Test: Colores de enemigos")
	
	var bow_color = EnemyData.get_enemy_color(EnemyData.EnemyType.GOBLIN_BOW)
	var dagger_color = EnemyData.get_enemy_color(EnemyData.EnemyType.GOBLIN_DAGGER)
	var shield_color = EnemyData.get_enemy_color(EnemyData.EnemyType.GOBLIN_SHIELD)
	
	# Verificar que todos son verdes (goblins)
	if bow_color.g > 0.5:
		pass_test("GOBLIN_BOW tiene color verde")
	else:
		fail_test("GOBLIN_BOW no tiene color verde")
	
	if dagger_color.g > 0.5:
		pass_test("GOBLIN_DAGGER tiene color verde")
	else:
		fail_test("GOBLIN_DAGGER no tiene color verde")
	
	if shield_color.g > 0.5:
		pass_test("GOBLIN_SHIELD tiene color verde")
	else:
		fail_test("GOBLIN_SHIELD no tiene color verde")

func test_enemy_data_stats():
	"""Test: Verificar que las estadísticas de enemigos son correctas"""
	print("\n📋 Test: Estadísticas de enemigos")
	
	# Goblin Bow (Ranged)
	var bow_health = EnemyData.get_enemy_health(EnemyData.EnemyType.GOBLIN_BOW)
	var bow_attack = EnemyData.get_enemy_attack(EnemyData.EnemyType.GOBLIN_BOW)
	var bow_range = EnemyData.get_enemy_attack_range(EnemyData.EnemyType.GOBLIN_BOW)
	
	if bow_health > 0 and bow_attack > 0 and bow_range >= 2:
		pass_test("GOBLIN_BOW tiene stats válidas (ranged)")
	else:
		fail_test("GOBLIN_BOW stats inválidas: HP=" + str(bow_health) + ", ATK=" + str(bow_attack) + ", RANGE=" + str(bow_range))
	
	# Goblin Dagger (Mele)
	var dagger_health = EnemyData.get_enemy_health(EnemyData.EnemyType.GOBLIN_DAGGER)
	var dagger_attack = EnemyData.get_enemy_attack(EnemyData.EnemyType.GOBLIN_DAGGER)
	var dagger_range = EnemyData.get_enemy_attack_range(EnemyData.EnemyType.GOBLIN_DAGGER)
	
	if dagger_health > 0 and dagger_attack > 0 and dagger_range == 1:
		pass_test("GOBLIN_DAGGER tiene stats válidas (mele)")
	else:
		fail_test("GOBLIN_DAGGER stats inválidas: HP=" + str(dagger_health) + ", ATK=" + str(dagger_attack) + ", RANGE=" + str(dagger_range))
	
	# Goblin Shield (Tank)
	var shield_health = EnemyData.get_enemy_health(EnemyData.EnemyType.GOBLIN_SHIELD)
	var shield_attack = EnemyData.get_enemy_attack(EnemyData.EnemyType.GOBLIN_SHIELD)
	var shield_defense = EnemyData.get_enemy_defense(EnemyData.EnemyType.GOBLIN_SHIELD)
	
	if shield_health > 0 and shield_defense > 0:
		pass_test("GOBLIN_SHIELD tiene stats válidas (tank)")
	else:
		fail_test("GOBLIN_SHIELD stats inválidas: HP=" + str(shield_health) + ", DEF=" + str(shield_defense))

func test_enemy_data_roles():
	"""Test: Verificar que los roles de enemigos son correctos"""
	print("\n📋 Test: Roles de enemigos")
	
	var bow_role = EnemyData.get_enemy_role(EnemyData.EnemyType.GOBLIN_BOW)
	var dagger_role = EnemyData.get_enemy_role(EnemyData.EnemyType.GOBLIN_DAGGER)
	var shield_role = EnemyData.get_enemy_role(EnemyData.EnemyType.GOBLIN_SHIELD)
	
	if bow_role == "ranged":
		pass_test("GOBLIN_BOW tiene rol ranged")
	else:
		fail_test("GOBLIN_BOW rol incorrecto: " + bow_role)
	
	if dagger_role == "mele":
		pass_test("GOBLIN_DAGGER tiene rol mele")
	else:
		fail_test("GOBLIN_DAGGER rol incorrecto: " + dagger_role)
	
	if shield_role == "tank":
		pass_test("GOBLIN_SHIELD tiene rol tank")
	else:
		fail_test("GOBLIN_SHIELD rol incorrecto: " + shield_role)

# ========== Tests de GridEnemy ==========

func run_all_grid_enemy_tests():
	"""Ejecuta todos los tests de GridEnemy"""
	test_grid_enemy_place_enemy()
	test_grid_enemy_remove_enemy()
	test_grid_enemy_cell_occupation()
	test_grid_enemy_get_enemy_at()
	test_grid_enemy_clear_all_enemies()
	test_grid_enemy_get_all_enemies()

func test_grid_enemy_place_enemy():
	"""Test: Colocar un enemigo en el grid enemigo"""
	print("\n📋 Test: Colocar enemigo en GridEnemy")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Crear un enemigo
	var enemy = Unit.new()
	enemy.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
	
	# Colocar en posición válida
	var success = grid_enemy.place_enemy(enemy, 3, 2)
	
	if success:
		pass_test("Enemigo colocado exitosamente")
		
		# Verificar que está en la posición correcta
		var placed_enemy = grid_enemy.get_enemy_at(3, 2)
		if placed_enemy == enemy:
			pass_test("Enemigo está en la posición correcta")
		else:
			fail_test("Enemigo no está en la posición correcta")
	else:
		fail_test("No se pudo colocar el enemigo")
	
	# Limpiar
	enemy.queue_free()

func test_grid_enemy_remove_enemy():
	"""Test: Remover un enemigo del grid enemigo"""
	print("\n📋 Test: Remover enemigo de GridEnemy")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Crear y colocar un enemigo
	var enemy = Unit.new()
	enemy.initialize_enemy(EnemyData.EnemyType.GOBLIN_DAGGER)
	grid_enemy.place_enemy(enemy, 2, 1)
	
	# Verificar que está colocado
	if grid_enemy.is_cell_occupied(2, 1):
		pass_test("Enemigo está colocado antes de remover")
	else:
		fail_test("Enemigo no está colocado")
	
	# Remover
	grid_enemy.remove_enemy(enemy)
	
	# Verificar que ya no está
	if not grid_enemy.is_cell_occupied(2, 1):
		pass_test("Enemigo removido exitosamente")
	else:
		fail_test("Enemigo no fue removido")
	
	# Limpiar
	enemy.queue_free()

func test_grid_enemy_cell_occupation():
	"""Test: Verificar ocupación de celdas en GridEnemy"""
	print("\n📋 Test: Ocupación de celdas en GridEnemy")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Verificar que una celda está libre
	if not grid_enemy.is_cell_occupied(0, 0):
		pass_test("Celda (0, 0) está libre inicialmente")
	else:
		fail_test("Celda (0, 0) debería estar libre")
	
	# Colocar un enemigo
	var enemy = Unit.new()
	enemy.initialize_enemy(EnemyData.EnemyType.GOBLIN_SHIELD)
	grid_enemy.place_enemy(enemy, 0, 0)
	
	# Verificar que ahora está ocupada
	if grid_enemy.is_cell_occupied(0, 0):
		pass_test("Celda (0, 0) está ocupada después de colocar enemigo")
	else:
		fail_test("Celda (0, 0) debería estar ocupada")
	
	# Limpiar
	enemy.queue_free()

func test_grid_enemy_get_enemy_at():
	"""Test: Obtener enemigo en una posición específica"""
	print("\n📋 Test: Obtener enemigo en posición específica")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Crear y colocar un enemigo
	var enemy = Unit.new()
	enemy.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
	grid_enemy.place_enemy(enemy, 4, 3)
	
	# Obtener el enemigo
	var found_enemy = grid_enemy.get_enemy_at(4, 3)
	
	if found_enemy == enemy:
		pass_test("Enemigo encontrado en posición correcta")
	else:
		fail_test("Enemigo no encontrado en posición correcta")
	
	# Verificar que una celda vacía retorna null
	var empty_enemy = grid_enemy.get_enemy_at(0, 0)
	if empty_enemy == null:
		pass_test("Celda vacía retorna null")
	else:
		fail_test("Celda vacía no retorna null")
	
	# Limpiar
	enemy.queue_free()

func test_grid_enemy_clear_all_enemies():
	"""Test: Limpiar todos los enemigos del grid"""
	print("\n📋 Test: Limpiar todos los enemigos")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Colocar varios enemigos
	var enemies = []
	for i in range(3):
		var enemy = Unit.new()
		enemy.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
		grid_enemy.place_enemy(enemy, i, 0)
		enemies.append(enemy)
	
	# Verificar que hay enemigos
	var all_enemies = grid_enemy.get_all_enemies()
	if all_enemies.size() == 3:
		pass_test("3 enemigos colocados correctamente")
	else:
		fail_test("No se colocaron 3 enemigos: " + str(all_enemies.size()))
	
	# Limpiar todos
	grid_enemy.clear_all_enemies()
	
	# Verificar que no hay enemigos
	var remaining_enemies = grid_enemy.get_all_enemies()
	if remaining_enemies.size() == 0:
		pass_test("Todos los enemigos fueron removidos")
	else:
		fail_test("Quedaron enemigos después de limpiar: " + str(remaining_enemies.size()))

func test_grid_enemy_get_all_enemies():
	"""Test: Obtener todos los enemigos del grid"""
	print("\n📋 Test: Obtener todos los enemigos")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Colocar varios enemigos de diferentes tipos
	var enemy1 = Unit.new()
	enemy1.initialize_enemy(EnemyData.EnemyType.GOBLIN_BOW)
	grid_enemy.place_enemy(enemy1, 1, 1)
	
	var enemy2 = Unit.new()
	enemy2.initialize_enemy(EnemyData.EnemyType.GOBLIN_DAGGER)
	grid_enemy.place_enemy(enemy2, 2, 1)
	
	var enemy3 = Unit.new()
	enemy3.initialize_enemy(EnemyData.EnemyType.GOBLIN_SHIELD)
	grid_enemy.place_enemy(enemy3, 3, 1)
	
	# Obtener todos los enemigos
	var all_enemies = grid_enemy.get_all_enemies()
	
	if all_enemies.size() == 3:
		pass_test("Se obtuvieron todos los enemigos correctamente")
	else:
		fail_test("No se obtuvieron todos los enemigos: " + str(all_enemies.size()))

# ========== Tests de EnemyAI ==========

func run_all_enemy_ai_tests():
	"""Ejecuta todos los tests de EnemyAI"""
	test_enemy_ai_round_composition()
	test_enemy_ai_spawn_enemies_round_1()
	test_enemy_ai_spawn_enemies_round_2()
	test_enemy_ai_spawn_enemies_round_3()
	test_enemy_ai_spawn_enemies_round_4()
	test_enemy_ai_spawn_enemies_round_5()
	test_enemy_ai_round_1_composition_details()
	test_enemy_ai_round_2_composition_details()
	test_enemy_ai_round_3_composition_details()
	test_enemy_ai_round_4_composition_details()
	test_enemy_ai_round_5_composition_details()
	test_enemy_ai_find_free_position()

func test_enemy_ai_round_composition():
	"""Test: Verificar que las composiciones de ronda existen"""
	print("\n📋 Test: Composiciones de ronda")
	
	# Verificar que existen composiciones para rondas 1-5
	for round_num in range(1, 6):
		var composition = enemy_ai.get_round_composition(round_num)
		if composition.size() > 0:
			pass_test("Ronda " + str(round_num) + " tiene composición definida (" + str(composition.size()) + " enemigos)")
		else:
			fail_test("Ronda " + str(round_num) + " no tiene composición definida")

func test_enemy_ai_spawn_enemies_round_1():
	"""Test: Spawnear enemigos para la ronda 1"""
	print("\n📋 Test: Spawnear enemigos ronda 1")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Spawnear enemigos
	enemy_ai.spawn_enemies_for_round(1)
	
	# Verificar que hay enemigos
	var all_enemies = grid_enemy.get_all_enemies()
	if all_enemies.size() > 0:
		pass_test("Se spawnearon enemigos para la ronda 1 (" + str(all_enemies.size()) + " enemigos)")
	else:
		fail_test("No se spawnearon enemigos para la ronda 1")
	
	# Verificar que los enemigos están colocados
	var occupied_count = 0
	for col in range(grid_enemy.COLUMNS):
		for row in range(grid_enemy.ROWS):
			if grid_enemy.is_cell_occupied(col, row):
				occupied_count += 1
	
	if occupied_count == all_enemies.size():
		pass_test("Todos los enemigos están correctamente colocados")
	else:
		fail_test("Enemigos no están correctamente colocados: " + str(occupied_count) + " celdas ocupadas, " + str(all_enemies.size()) + " enemigos")

func test_enemy_ai_spawn_enemies_round_2():
	"""Test: Spawnear enemigos para la ronda 2"""
	print("\n📋 Test: Spawnear enemigos ronda 2")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Spawnear enemigos
	enemy_ai.spawn_enemies_for_round(2)
	
	# Verificar que hay más enemigos que en ronda 1
	var all_enemies = grid_enemy.get_all_enemies()
	if all_enemies.size() >= 4:
		pass_test("Ronda 2 tiene más enemigos que ronda 1 (" + str(all_enemies.size()) + " enemigos)")
	else:
		fail_test("Ronda 2 no tiene suficientes enemigos: " + str(all_enemies.size()))

func test_enemy_ai_spawn_enemies_round_3():
	"""Test: Spawnear enemigos para la ronda 3"""
	print("\n📋 Test: Spawnear enemigos ronda 3")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Spawnear enemigos
	enemy_ai.spawn_enemies_for_round(3)
	
	# Verificar que hay enemigos
	var all_enemies = grid_enemy.get_all_enemies()
	if all_enemies.size() >= 5:
		pass_test("Ronda 3 tiene enemigos suficientes (" + str(all_enemies.size()) + " enemigos)")
	else:
		fail_test("Ronda 3 no tiene suficientes enemigos: " + str(all_enemies.size()))

func test_enemy_ai_spawn_enemies_round_4():
	"""Test: Spawnear enemigos para la ronda 4"""
	print("\n📋 Test: Spawnear enemigos ronda 4")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Spawnear enemigos
	enemy_ai.spawn_enemies_for_round(4)
	
	# Verificar que hay enemigos
	var all_enemies = grid_enemy.get_all_enemies()
	if all_enemies.size() >= 6:
		pass_test("Ronda 4 tiene enemigos suficientes (" + str(all_enemies.size()) + " enemigos)")
	else:
		fail_test("Ronda 4 no tiene suficientes enemigos: " + str(all_enemies.size()))

func test_enemy_ai_spawn_enemies_round_5():
	"""Test: Spawnear enemigos para la ronda 5"""
	print("\n📋 Test: Spawnear enemigos ronda 5")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Spawnear enemigos
	enemy_ai.spawn_enemies_for_round(5)
	
	# Verificar que hay enemigos
	var all_enemies = grid_enemy.get_all_enemies()
	if all_enemies.size() >= 7:
		pass_test("Ronda 5 tiene enemigos suficientes (" + str(all_enemies.size()) + " enemigos)")
	else:
		fail_test("Ronda 5 no tiene suficientes enemigos: " + str(all_enemies.size()))

# ========== Tests de Composiciones Detalladas ==========

func test_enemy_ai_round_1_composition_details():
	"""Test: Verificar composición exacta de la ronda 1"""
	print("\n📋 Test: Composición detallada ronda 1")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Spawnear enemigos
	enemy_ai.spawn_enemies_for_round(1)
	
	# Contar tipos de enemigos
	var counts = count_enemy_types()
	
	# Ronda 1: 1 arquero + 2 asesinos = 3 enemigos total
	if counts["total"] == 3:
		pass_test("Ronda 1 tiene 3 enemigos totales")
	else:
		fail_test("Ronda 1 debería tener 3 enemigos, tiene: " + str(counts["total"]))
	
	if counts["bow"] == 1:
		pass_test("Ronda 1 tiene 1 Goblin Arquero")
	else:
		fail_test("Ronda 1 debería tener 1 Goblin Arquero, tiene: " + str(counts["bow"]))
	
	if counts["dagger"] == 2:
		pass_test("Ronda 1 tiene 2 Goblins Asesinos")
	else:
		fail_test("Ronda 1 debería tener 2 Goblins Asesinos, tiene: " + str(counts["dagger"]))
	
	if counts["shield"] == 0:
		pass_test("Ronda 1 no tiene Goblins Defensores (correcto)")
	else:
		fail_test("Ronda 1 no debería tener Goblins Defensores, tiene: " + str(counts["shield"]))

func test_enemy_ai_round_2_composition_details():
	"""Test: Verificar composición exacta de la ronda 2"""
	print("\n📋 Test: Composición detallada ronda 2")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Spawnear enemigos
	enemy_ai.spawn_enemies_for_round(2)
	
	# Contar tipos de enemigos
	var counts = count_enemy_types()
	
	# Ronda 2: 2 arqueros + 2 asesinos = 4 enemigos total
	if counts["total"] == 4:
		pass_test("Ronda 2 tiene 4 enemigos totales")
	else:
		fail_test("Ronda 2 debería tener 4 enemigos, tiene: " + str(counts["total"]))
	
	if counts["bow"] == 2:
		pass_test("Ronda 2 tiene 2 Goblins Arqueros")
	else:
		fail_test("Ronda 2 debería tener 2 Goblins Arqueros, tiene: " + str(counts["bow"]))
	
	if counts["dagger"] == 2:
		pass_test("Ronda 2 tiene 2 Goblins Asesinos")
	else:
		fail_test("Ronda 2 debería tener 2 Goblins Asesinos, tiene: " + str(counts["dagger"]))
	
	if counts["shield"] == 0:
		pass_test("Ronda 2 no tiene Goblins Defensores (correcto)")
	else:
		fail_test("Ronda 2 no debería tener Goblins Defensores, tiene: " + str(counts["shield"]))

func test_enemy_ai_round_3_composition_details():
	"""Test: Verificar composición exacta de la ronda 3"""
	print("\n📋 Test: Composición detallada ronda 3")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Spawnear enemigos
	enemy_ai.spawn_enemies_for_round(3)
	
	# Contar tipos de enemigos
	var counts = count_enemy_types()
	
	# Ronda 3: 1 tanque + 2 arqueros + 2 asesinos = 5 enemigos total
	if counts["total"] == 5:
		pass_test("Ronda 3 tiene 5 enemigos totales")
	else:
		fail_test("Ronda 3 debería tener 5 enemigos, tiene: " + str(counts["total"]))
	
	if counts["shield"] == 1:
		pass_test("Ronda 3 tiene 1 Goblin Defensor")
	else:
		fail_test("Ronda 3 debería tener 1 Goblin Defensor, tiene: " + str(counts["shield"]))
	
	if counts["bow"] == 2:
		pass_test("Ronda 3 tiene 2 Goblins Arqueros")
	else:
		fail_test("Ronda 3 debería tener 2 Goblins Arqueros, tiene: " + str(counts["bow"]))
	
	if counts["dagger"] == 2:
		pass_test("Ronda 3 tiene 2 Goblins Asesinos")
	else:
		fail_test("Ronda 3 debería tener 2 Goblins Asesinos, tiene: " + str(counts["dagger"]))

func test_enemy_ai_round_4_composition_details():
	"""Test: Verificar composición exacta de la ronda 4"""
	print("\n📋 Test: Composición detallada ronda 4")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Spawnear enemigos
	enemy_ai.spawn_enemies_for_round(4)
	
	# Contar tipos de enemigos
	var counts = count_enemy_types()
	
	# Ronda 4: 2 tanques + 2 arqueros + 2 asesinos = 6 enemigos total
	if counts["total"] == 6:
		pass_test("Ronda 4 tiene 6 enemigos totales")
	else:
		fail_test("Ronda 4 debería tener 6 enemigos, tiene: " + str(counts["total"]))
	
	if counts["shield"] == 2:
		pass_test("Ronda 4 tiene 2 Goblins Defensores")
	else:
		fail_test("Ronda 4 debería tener 2 Goblins Defensores, tiene: " + str(counts["shield"]))
	
	if counts["bow"] == 2:
		pass_test("Ronda 4 tiene 2 Goblins Arqueros")
	else:
		fail_test("Ronda 4 debería tener 2 Goblins Arqueros, tiene: " + str(counts["bow"]))
	
	if counts["dagger"] == 2:
		pass_test("Ronda 4 tiene 2 Goblins Asesinos")
	else:
		fail_test("Ronda 4 debería tener 2 Goblins Asesinos, tiene: " + str(counts["dagger"]))

func test_enemy_ai_round_5_composition_details():
	"""Test: Verificar composición exacta de la ronda 5"""
	print("\n📋 Test: Composición detallada ronda 5")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Spawnear enemigos
	enemy_ai.spawn_enemies_for_round(5)
	
	# Contar tipos de enemigos
	var counts = count_enemy_types()
	
	# Ronda 5: 3 tanques + 2 arqueros + 2 asesinos = 7 enemigos total
	if counts["total"] == 7:
		pass_test("Ronda 5 tiene 7 enemigos totales")
	else:
		fail_test("Ronda 5 debería tener 7 enemigos, tiene: " + str(counts["total"]))
	
	if counts["shield"] == 3:
		pass_test("Ronda 5 tiene 3 Goblins Defensores")
	else:
		fail_test("Ronda 5 debería tener 3 Goblins Defensores, tiene: " + str(counts["shield"]))
	
	if counts["bow"] == 2:
		pass_test("Ronda 5 tiene 2 Goblins Arqueros")
	else:
		fail_test("Ronda 5 debería tener 2 Goblins Arqueros, tiene: " + str(counts["bow"]))
	
	if counts["dagger"] == 2:
		pass_test("Ronda 5 tiene 2 Goblins Asesinos")
	else:
		fail_test("Ronda 5 debería tener 2 Goblins Asesinos, tiene: " + str(counts["dagger"]))

func test_enemy_ai_find_free_position():
	"""Test: Encontrar posición libre en el grid"""
	print("\n📋 Test: Encontrar posición libre")
	
	# Limpiar grid primero
	grid_enemy.clear_all_enemies()
	
	# Encontrar posición libre
	var free_pos = enemy_ai.find_free_position()
	
	if free_pos.x >= 0 and free_pos.y >= 0:
		pass_test("Se encontró posición libre: (" + str(free_pos.x) + ", " + str(free_pos.y) + ")")
		
		# Verificar que la posición está realmente libre
		if not grid_enemy.is_cell_occupied(free_pos.x, free_pos.y):
			pass_test("Posición encontrada está realmente libre")
		else:
			fail_test("Posición encontrada está ocupada")
	else:
		fail_test("No se encontró posición libre")

# ========== Utilidades ==========

func count_enemy_types() -> Dictionary:
	"""Cuenta los tipos de enemigos en el grid"""
	var counts = {
		"bow": 0,
		"dagger": 0,
		"shield": 0,
		"total": 0
	}
	
	var all_enemies = grid_enemy.get_all_enemies()
	counts["total"] = all_enemies.size()
	
	for enemy in all_enemies:
		# Obtener el tipo de enemigo desde la unidad
		# Necesitamos acceder al tipo de enemigo desde Unit
		# Por ahora, vamos a usar el nombre o alguna propiedad
		# Necesitamos verificar cómo Unit almacena el tipo de enemigo
		var enemy_type = get_enemy_type_from_unit(enemy)
		
		if enemy_type == EnemyData.EnemyType.GOBLIN_BOW:
			counts["bow"] += 1
		elif enemy_type == EnemyData.EnemyType.GOBLIN_DAGGER:
			counts["dagger"] += 1
		elif enemy_type == EnemyData.EnemyType.GOBLIN_SHIELD:
			counts["shield"] += 1
	
	return counts

func get_enemy_type_from_unit(unit: Unit) -> EnemyData.EnemyType:
	"""Obtiene el tipo de enemigo desde una unidad"""
	# Unit tiene una propiedad enemy_type que almacena el tipo directamente
	if unit.is_enemy and unit.has("enemy_type"):
		return unit.enemy_type
	
	# Fallback: retornar un tipo por defecto si no se puede determinar
	return EnemyData.EnemyType.GOBLIN_BOW

func pass_test(test_name: String):
	"""Marca un test como pasado"""
	tests_passed += 1
	print("  ✅ PASÓ: ", test_name)

func fail_test(test_name: String):
	"""Marca un test como fallido"""
	tests_failed += 1
	print("  ❌ FALLÓ: ", test_name)
