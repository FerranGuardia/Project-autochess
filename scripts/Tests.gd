extends Node
class_name Tests

## Tests unitarios específicos para el sistema de Bench
## Ejecutar desde el editor o desde código

var tests_passed: int = 0
var tests_failed: int = 0

func _ready():
	print("==================================================")
	print("🧪 INICIANDO TESTS DEL SISTEMA CLICK AND DRAG")
	print("==================================================")
	
	# Ejecutar todos los tests del bench
	run_all_bench_tests()
	
	# Ejecutar todos los tests del grid
	run_all_grid_tests()
	
	# Ejecutar todos los tests de drag and drop
	run_all_drag_drop_tests()
	
	# Mostrar resumen
	print("==================================================")
	print("📊 RESUMEN DE TESTS")
	print("✅ Tests pasados: ", tests_passed)
	print("❌ Tests fallados: ", tests_failed)
	print("==================================================")

func run_all_bench_tests():
	"""Ejecuta todos los tests del banquillo"""
	test_bench_place_unit()
	test_bench_remove_unit()
	test_bench_slot_occupation()
	test_bench_get_unit_at()
	test_bench_is_slot_occupied()
	test_bench_get_world_position()
	test_bench_get_slot_index()

func run_all_grid_tests():
	"""Ejecuta todos los tests del grid"""
	# Limpiar grid antes de los tests (para evitar conflictos con test_place_unit en Board.gd)
	cleanup_grid_only()
	test_grid_place_unit()
	test_grid_cell_occupation()
	test_grid_get_unit_at()
	test_grid_is_cell_occupied()

func run_all_drag_drop_tests():
	"""Ejecuta todos los tests de drag and drop"""
	# Limpiar todo antes de los tests de drag and drop
	cleanup_all_units()
	test_bench_to_grid_movement()
	test_grid_to_bench_movement()
	test_invalid_drop_returns_to_original()

# ========== Funciones Helper ==========

func cleanup_all_units():
	"""Limpia todas las unidades del grid y bench para evitar interferencias entre tests"""
	var board = get_node("/root/Board")
	if not board:
		return
	
	# Limpiar grid aliado
	if board.grid_ally:
		var units_to_remove = []
		for unit in board.grid_ally.units.values():
			units_to_remove.append(unit)
		for unit in units_to_remove:
			board.grid_ally.remove_unit(unit)
			if unit.get_parent():
				unit.get_parent().remove_child(unit)
			unit.queue_free()
	
	# Limpiar banquillo
	if board.bench:
		var units_to_remove = []
		for unit in board.bench.units.values():
			units_to_remove.append(unit)
		for unit in units_to_remove:
			board.bench.remove_unit(unit)
			if unit.get_parent():
				unit.get_parent().remove_child(unit)
			unit.queue_free()

func cleanup_grid_only():
	"""Limpia solo el grid aliado"""
	var board = get_node("/root/Board")
	if not board or not board.grid_ally:
		return
	
	var units_to_remove = []
	for unit in board.grid_ally.units.values():
		units_to_remove.append(unit)
	for unit in units_to_remove:
		board.grid_ally.remove_unit(unit)
		if unit.get_parent():
			unit.get_parent().remove_child(unit)
		unit.queue_free()

# ========== Tests Básicos del Bench ==========

func test_bench_place_unit():
	"""Test: Colocar una unidad en el banquillo"""
	print("\n📋 Test: Colocar unidad en banquillo")
	
	var board = get_node("/root/Board")
	if not board or not board.bench:
		print("❌ FALLÓ: No se encontró Board o Bench")
		tests_failed += 1
		return
	
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.MAGO)
	
	var success = board.bench.place_unit(unit, 0)
	
	if success:
		var placed_unit = board.bench.get_unit_at(0)
		if placed_unit == unit:
			print("✅ PASÓ: Unidad colocada correctamente en slot 0")
			tests_passed += 1
		else:
			print("❌ FALLÓ: Unidad no encontrada en slot 0")
			tests_failed += 1
	else:
		print("❌ FALLÓ: place_unit() retornó false")
		tests_failed += 1

func test_bench_remove_unit():
	"""Test: Remover una unidad del banquillo"""
	print("\n📋 Test: Remover unidad del banquillo")
	
	var board = get_node("/root/Board")
	if not board or not board.bench:
		print("❌ FALLÓ: No se encontró Board o Bench")
		tests_failed += 1
		return
	
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.ORCO)
	
	# Colocar unidad
	var placed = board.bench.place_unit(unit, 1)
	if not placed:
		print("❌ FALLÓ: No se pudo colocar la unidad inicialmente")
		tests_failed += 1
		return
	
	# Remover unidad
	board.bench.remove_unit(unit)
	
	# Verificar que ya no está
	var still_there = board.bench.get_unit_at(1) != null
	
	if not still_there:
		print("✅ PASÓ: Unidad removida correctamente del banquillo")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Unidad todavía está en el banquillo")
		tests_failed += 1

func test_bench_slot_occupation():
	"""Test: Verificar que no se pueden colocar dos unidades en el mismo slot"""
	print("\n📋 Test: Validación de slot ocupado")
	
	var board = get_node("/root/Board")
	if not board or not board.bench:
		print("❌ FALLÓ: No se encontró Board o Bench")
		tests_failed += 1
		return
	
	var unit1 = Unit.new()
	unit1.initialize(UnitData.UnitType.ELFO)
	var unit2 = Unit.new()
	unit2.initialize(UnitData.UnitType.ENANO)
	
	# Colocar primera unidad
	var success1 = board.bench.place_unit(unit1, 2)
	
	# Intentar colocar segunda unidad en el mismo slot
	var success2 = board.bench.place_unit(unit2, 2)
	
	if success1 and not success2:
		print("✅ PASÓ: Sistema previene colocar dos unidades en el mismo slot")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Sistema permitió colocar dos unidades en el mismo slot")
		tests_failed += 1

func test_bench_get_unit_at():
	"""Test: Obtener unidad de un slot específico"""
	print("\n📋 Test: Obtener unidad de slot")
	
	var board = get_node("/root/Board")
	if not board or not board.bench:
		print("❌ FALLÓ: No se encontró Board o Bench")
		tests_failed += 1
		return
	
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.BEASTKIN)
	
	# Colocar unidad
	var placed = board.bench.place_unit(unit, 3)
	if not placed:
		print("❌ FALLÓ: No se pudo colocar la unidad")
		tests_failed += 1
		return
	
	# Obtener unidad
	var retrieved_unit = board.bench.get_unit_at(3)
	
	if retrieved_unit == unit:
		print("✅ PASÓ: get_unit_at() retorna la unidad correcta")
		tests_passed += 1
	else:
		print("❌ FALLÓ: get_unit_at() no retorna la unidad correcta")
		tests_failed += 1

func test_bench_is_slot_occupied():
	"""Test: Verificar si un slot está ocupado"""
	print("\n📋 Test: Verificar ocupación de slot")
	
	var board = get_node("/root/Board")
	if not board or not board.bench:
		print("❌ FALLÓ: No se encontró Board o Bench")
		tests_failed += 1
		return
	
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.DEMONIO)
	
	# Verificar que el slot está vacío
	var empty_before = not board.bench.is_slot_occupied(4)
	
	# Colocar unidad
	var placed = board.bench.place_unit(unit, 4)
	if not placed:
		print("❌ FALLÓ: No se pudo colocar la unidad")
		tests_failed += 1
		return
	
	# Verificar que el slot está ocupado
	var occupied_after = board.bench.is_slot_occupied(4)
	
	if empty_before and occupied_after:
		print("✅ PASÓ: is_slot_occupied() funciona correctamente")
		tests_passed += 1
	else:
		print("❌ FALLÓ: is_slot_occupied() no funciona correctamente")
		tests_failed += 1

func test_bench_get_world_position():
	"""Test: Obtener posición mundial de un slot"""
	print("\n📋 Test: Obtener posición mundial de slot")
	
	var board = get_node("/root/Board")
	if not board or not board.bench:
		print("❌ FALLÓ: No se encontró Board o Bench")
		tests_failed += 1
		return
	
	# Obtener posición del slot 5
	var world_pos = board.bench.get_world_position(5)
	
	# Verificar que es un Vector2 válido
	if world_pos is Vector2:
		print("✅ PASÓ: get_world_position() retorna Vector2 válido: ", world_pos)
		tests_passed += 1
	else:
		print("❌ FALLÓ: get_world_position() no retorna Vector2 válido")
		tests_failed += 1

func test_bench_get_slot_index():
	"""Test: Convertir posición mundial a índice de slot"""
	print("\n📋 Test: Convertir posición a índice de slot")
	
	var board = get_node("/root/Board")
	if not board or not board.bench:
		print("❌ FALLÓ: No se encontró Board o Bench")
		tests_failed += 1
		return
	
	# Obtener posición mundial del slot 6
	var world_pos = board.bench.get_world_position(6)
	
	# Convertir de vuelta a índice
	var slot_index = board.bench.get_slot_index(world_pos)
	
	if slot_index == 6:
		print("✅ PASÓ: get_slot_index() convierte correctamente: ", slot_index)
		tests_passed += 1
	else:
		print("❌ FALLÓ: get_slot_index() retornó ", slot_index, " en lugar de 6")
		tests_failed += 1

# ========== Tests del Grid ==========

func test_grid_place_unit():
	"""Test: Colocar una unidad en el grid"""
	print("\n📋 Test: Colocar unidad en grid")
	
	var board = get_node("/root/Board")
	if not board or not board.grid_ally:
		print("❌ FALLÓ: No se encontró Board o GridAlly")
		tests_failed += 1
		return
	
	# Usar una posición que no esté ocupada (evitar 3, 2 que usa test_place_unit)
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.MAGO)
	
	# Usar posición (0, 0) que debería estar libre
	var success = board.grid_ally.place_unit(unit, 0, 0)
	
	if success:
		var placed_unit = board.grid_ally.get_unit_at(0, 0)
		if placed_unit == unit:
			print("✅ PASÓ: Unidad colocada correctamente en grid (0, 0)")
			tests_passed += 1
		else:
			print("❌ FALLÓ: Unidad no encontrada en grid (0, 0)")
			tests_failed += 1
	else:
		print("❌ FALLÓ: place_unit() retornó false")
		tests_failed += 1

func test_grid_cell_occupation():
	"""Test: Verificar que no se pueden colocar dos unidades en la misma celda"""
	print("\n📋 Test: Validación de celda ocupada en grid")
	
	var board = get_node("/root/Board")
	if not board or not board.grid_ally:
		print("❌ FALLÓ: No se encontró Board o GridAlly")
		tests_failed += 1
		return
	
	# Usar una posición diferente para evitar conflictos (6, 4)
	var unit1 = Unit.new()
	unit1.initialize(UnitData.UnitType.ORCO)
	var unit2 = Unit.new()
	unit2.initialize(UnitData.UnitType.ELFO)
	
	# Colocar primera unidad
	var success1 = board.grid_ally.place_unit(unit1, 6, 4)
	
	# Intentar colocar segunda unidad en la misma celda
	var success2 = board.grid_ally.place_unit(unit2, 6, 4)
	
	if success1 and not success2:
		print("✅ PASÓ: Sistema previene colocar dos unidades en la misma celda")
		tests_passed += 1
		# Limpiar después del test
		board.grid_ally.remove_unit(unit1)
		if unit1.get_parent():
			unit1.get_parent().remove_child(unit1)
		unit1.queue_free()
		if unit2.get_parent():
			unit2.get_parent().remove_child(unit2)
		unit2.queue_free()
	else:
		print("❌ FALLÓ: Sistema permitió colocar dos unidades en la misma celda")
		tests_failed += 1
		# Limpiar de todas formas
		board.grid_ally.remove_unit(unit1)
		if unit1.get_parent():
			unit1.get_parent().remove_child(unit1)
		unit1.queue_free()
		if unit2.get_parent():
			unit2.get_parent().remove_child(unit2)
		unit2.queue_free()

func test_grid_get_unit_at():
	"""Test: Obtener unidad de una celda específica"""
	print("\n📋 Test: Obtener unidad de celda del grid")
	
	var board = get_node("/root/Board")
	if not board or not board.grid_ally:
		print("❌ FALLÓ: No se encontró Board o GridAlly")
		tests_failed += 1
		return
	
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.ENANO)
	
	# Colocar unidad en posición (1, 1)
	var placed = board.grid_ally.place_unit(unit, 1, 1)
	if not placed:
		print("❌ FALLÓ: No se pudo colocar la unidad")
		tests_failed += 1
		return
	
	# Obtener unidad
	var retrieved_unit = board.grid_ally.get_unit_at(1, 1)
	
	if retrieved_unit == unit:
		print("✅ PASÓ: get_unit_at() retorna la unidad correcta del grid")
		tests_passed += 1
	else:
		print("❌ FALLÓ: get_unit_at() no retorna la unidad correcta del grid")
		tests_failed += 1

func test_grid_is_cell_occupied():
	"""Test: Verificar si una celda está ocupada"""
	print("\n📋 Test: Verificar ocupación de celda del grid")
	
	var board = get_node("/root/Board")
	if not board or not board.grid_ally:
		print("❌ FALLÓ: No se encontró Board o GridAlly")
		tests_failed += 1
		return
	
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.BEASTKIN)
	
	# Verificar que la celda está vacía
	var empty_before = not board.grid_ally.is_cell_occupied(1, 0)
	
	# Colocar unidad
	var placed = board.grid_ally.place_unit(unit, 1, 0)
	if not placed:
		print("❌ FALLÓ: No se pudo colocar la unidad")
		tests_failed += 1
		return
	
	# Verificar que la celda está ocupada
	var occupied_after = board.grid_ally.is_cell_occupied(1, 0)
	
	if empty_before and occupied_after:
		print("✅ PASÓ: is_cell_occupied() funciona correctamente")
		tests_passed += 1
	else:
		print("❌ FALLÓ: is_cell_occupied() no funciona correctamente")
		tests_failed += 1

# ========== Tests de Drag and Drop ==========

func test_bench_to_grid_movement():
	"""Test: Mover unidad del banquillo al grid"""
	print("\n📋 Test: Movimiento de banquillo a grid")
	
	var board = get_node("/root/Board")
	if not board or not board.bench or not board.grid_ally:
		print("❌ FALLÓ: No se encontró Board, Bench o GridAlly")
		tests_failed += 1
		return
	
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.DEMONIO)
	
	# Colocar unidad en el banquillo (usar slot 7 que debería estar libre después de cleanup)
	var bench_success = board.bench.place_unit(unit, 7)
	if not bench_success:
		print("❌ FALLÓ: No se pudo colocar la unidad en el banquillo")
		tests_failed += 1
		return
	
	# Verificar que está en el banquillo
	var in_bench = board.bench.get_unit_at(7) == unit
	if not in_bench:
		print("❌ FALLÓ: Unidad no está en el banquillo")
		tests_failed += 1
		return
	
	# Mover al grid usando handle_unit_drop (usar posición 5, 0 que debería estar libre)
	var grid_world_pos = board.grid_ally.get_world_position(5, 0)
	var drop_success = board.handle_unit_drop(unit, grid_world_pos)
	
	if drop_success:
		# Verificar que ya no está en el banquillo
		var still_in_bench = board.bench.get_unit_at(7) != null
		# Verificar que está en el grid
		var in_grid = board.grid_ally.get_unit_at(5, 0) == unit
		
		if not still_in_bench and in_grid:
			print("✅ PASÓ: Unidad movida correctamente de banquillo a grid")
			tests_passed += 1
		else:
			print("❌ FALLÓ: Unidad no se movió correctamente (bench: ", still_in_bench, ", grid: ", in_grid, ")")
			tests_failed += 1
	else:
		print("❌ FALLÓ: handle_unit_drop() retornó false")
		tests_failed += 1

func test_grid_to_bench_movement():
	"""Test: Mover unidad del grid al banquillo"""
	print("\n📋 Test: Movimiento de grid a banquillo")
	
	var board = get_node("/root/Board")
	if not board or not board.bench or not board.grid_ally:
		print("❌ FALLÓ: No se encontró Board, Bench o GridAlly")
		tests_failed += 1
		return
	
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.MAGO)
	
	# Colocar unidad en el grid (usar posición 4, 1 que debería estar libre)
	var grid_success = board.grid_ally.place_unit(unit, 4, 1)
	if not grid_success:
		print("❌ FALLÓ: No se pudo colocar la unidad en el grid")
		tests_failed += 1
		return
	
	# Verificar que está en el grid
	var in_grid = board.grid_ally.get_unit_at(4, 1) == unit
	if not in_grid:
		print("❌ FALLÓ: Unidad no está en el grid")
		tests_failed += 1
		return
	
	# Mover al banquillo usando handle_unit_drop (usar slot 8 que debería estar libre)
	var bench_world_pos = board.bench.get_world_position(8)
	var drop_success = board.handle_unit_drop(unit, bench_world_pos)
	
	if drop_success:
		# Verificar que ya no está en el grid
		var still_in_grid = board.grid_ally.get_unit_at(4, 1) != null
		# Verificar que está en el banquillo
		var in_bench = board.bench.get_unit_at(8) == unit
		
		if not still_in_grid and in_bench:
			print("✅ PASÓ: Unidad movida correctamente de grid a banquillo")
			tests_passed += 1
		else:
			print("❌ FALLÓ: Unidad no se movió correctamente (grid: ", still_in_grid, ", bench: ", in_bench, ")")
			tests_failed += 1
	else:
		print("❌ FALLÓ: handle_unit_drop() retornó false")
		tests_failed += 1

func test_invalid_drop_returns_to_original():
	"""Test: Verificar que un drop inválido restaura la posición original"""
	print("\n📋 Test: Drop inválido restaura posición original")
	
	var board = get_node("/root/Board")
	if not board or not board.bench or not board.grid_ally:
		print("❌ FALLÓ: No se encontró Board, Bench o GridAlly")
		tests_failed += 1
		return
	
	var unit = Unit.new()
	unit.initialize(UnitData.UnitType.ORCO)
	
	# Colocar unidad en el banquillo (usar slot 9 que debería estar libre)
	var bench_success = board.bench.place_unit(unit, 9)
	if not bench_success:
		print("❌ FALLÓ: No se pudo colocar la unidad en el banquillo")
		tests_failed += 1
		return
	
	# Guardar posición original (no se usa en la verificación actual, pero se puede usar en el futuro)
	var _original_world_pos = board.bench.get_world_position(9)
	var _original_local_pos = unit.position
	
	# Intentar drop en posición inválida (fuera del área del grid y bench)
	# Usar una posición muy lejos
	var invalid_pos = Vector2(10000, 10000)
	var drop_success = board.handle_unit_drop(unit, invalid_pos)
	
	# Verificar que el drop falló
	if not drop_success:
		# Verificar que la unidad todavía está en el banquillo
		var still_in_bench = board.bench.get_unit_at(9) == unit
		
		if still_in_bench:
			print("✅ PASÓ: Drop inválido restauró posición original correctamente")
			tests_passed += 1
		else:
			print("❌ FALLÓ: Unidad no está en su posición original después de drop inválido")
			tests_failed += 1
	else:
		print("❌ FALLÓ: handle_unit_drop() aceptó una posición inválida")
		tests_failed += 1
