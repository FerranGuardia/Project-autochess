extends Node
class_name ShopTests

## Tests unitarios para el sistema de oro y tienda
## Ejecutar desde el editor o desde código

var tests_passed: int = 0
var tests_failed: int = 0

# Referencias para los tests
var game_manager: GameManager
var shop: Shop
var bench: Bench

func _ready():
	print("==================================================")
	print("🧪 INICIANDO TESTS DEL SISTEMA DE ORO Y TIENDA")
	print("==================================================")
	
	# Crear componentes necesarios para los tests
	setup_test_environment()
	
	# Ejecutar todos los tests
	run_all_gold_tests()
	run_all_shop_tests()
	run_all_purchase_tests()
	run_all_shop_ui_tests()
	
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
	# Crear GameManager
	game_manager = GameManager.new()
	game_manager.name = "TestGameManager"
	add_child(game_manager)
	
	# Crear Bench
	bench = Bench.new()
	bench.name = "TestBench"
	add_child(bench)
	
	# Crear Shop
	shop = Shop.new()
	shop.name = "TestShop"
	add_child(shop)
	
	# Inicializar Shop con referencias
	shop.initialize(game_manager, bench)
	
	print("✅ Entorno de testing configurado")

func cleanup_test_environment():
	"""Limpia el entorno de testing"""
	# Limpiar unidades del bench
	cleanup_bench()
	
	# Remover nodos de prueba
	if game_manager:
		game_manager.queue_free()
	if shop:
		shop.queue_free()
	if bench:
		bench.queue_free()

func cleanup_bench():
	"""Limpia todas las unidades del bench"""
	if not bench:
		return
	
	# Obtener todas las unidades del bench
	var units_to_remove = []
	for slot_index in bench.units.keys():
		units_to_remove.append(bench.units[slot_index])
	
	# Remover todas las unidades
	for unit in units_to_remove:
		bench.remove_unit(unit)
		unit.queue_free()

# ========== Tests del Sistema de Oro ==========

func run_all_gold_tests():
	"""Ejecuta todos los tests del sistema de oro"""
	print("\n💰 TESTS DEL SISTEMA DE ORO\n")
	
	test_gold_initial_value()
	test_gold_add()
	test_gold_spend_success()
	test_gold_spend_insufficient()
	test_gold_has_enough()
	test_gold_cannot_spend_negative()
	test_gold_cannot_add_negative()

func test_gold_initial_value():
	"""Test: Verificar que el oro inicial es correcto"""
	print("📋 Test: Oro inicial")
	
	var initial_gold = game_manager.get_gold()
	if initial_gold == 10:
		print("✅ PASÓ: Oro inicial es 10")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Oro inicial incorrecto. Esperado: 10, Obtenido: ", initial_gold)
		tests_failed += 1

func test_gold_add():
	"""Test: Agregar oro funciona correctamente"""
	print("📋 Test: Agregar oro")
	
	var initial_gold = game_manager.get_gold()
	game_manager.add_gold(5)
	var new_gold = game_manager.get_gold()
	
	if new_gold == initial_gold + 5:
		print("✅ PASÓ: Oro agregado correctamente (", initial_gold, " → ", new_gold, ")")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Oro no se agregó correctamente. Esperado: ", initial_gold + 5, ", Obtenido: ", new_gold)
		tests_failed += 1
	
	# Resetear para otros tests
	game_manager.reset_game()

func test_gold_spend_success():
	"""Test: Gastar oro cuando hay suficiente"""
	print("📋 Test: Gastar oro (éxito)")
	
	game_manager.reset_game()
	var initial_gold = game_manager.get_gold()
	var success = game_manager.spend_gold(3)
	var new_gold = game_manager.get_gold()
	
	if success and new_gold == initial_gold - 3:
		print("✅ PASÓ: Oro gastado correctamente (", initial_gold, " → ", new_gold, ")")
		tests_passed += 1
	else:
		print("❌ FALLÓ: No se pudo gastar oro o cantidad incorrecta")
		tests_failed += 1
	
	game_manager.reset_game()

func test_gold_spend_insufficient():
	"""Test: No se puede gastar más oro del que se tiene"""
	print("📋 Test: Gastar oro (insuficiente)")
	
	game_manager.reset_game()
	var initial_gold = game_manager.get_gold()
	var success = game_manager.spend_gold(initial_gold + 1)
	var new_gold = game_manager.get_gold()
	
	if not success and new_gold == initial_gold:
		print("✅ PASÓ: Sistema previene gastar más oro del disponible")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Se permitió gastar más oro del disponible")
		tests_failed += 1
	
	game_manager.reset_game()

func test_gold_has_enough():
	"""Test: Verificar si hay suficiente oro"""
	print("📋 Test: Verificar oro suficiente")
	
	game_manager.reset_game()
	var has_enough = game_manager.has_enough_gold(5)
	var not_enough = game_manager.has_enough_gold(20)
	
	if has_enough and not not_enough:
		print("✅ PASÓ: has_enough_gold() funciona correctamente")
		tests_passed += 1
	else:
		print("❌ FALLÓ: has_enough_gold() no funciona correctamente")
		tests_failed += 1
	
	game_manager.reset_game()

func test_gold_cannot_spend_negative():
	"""Test: No se puede gastar cantidades negativas"""
	print("📋 Test: Gastar oro negativo")
	
	game_manager.reset_game()
	var initial_gold = game_manager.get_gold()
	var success = game_manager.spend_gold(-5)
	var new_gold = game_manager.get_gold()
	
	if not success and new_gold == initial_gold:
		print("✅ PASÓ: Sistema previene gastar cantidades negativas")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Se permitió gastar cantidad negativa")
		tests_failed += 1
	
	game_manager.reset_game()

func test_gold_cannot_add_negative():
	"""Test: No se puede agregar cantidades negativas"""
	print("📋 Test: Agregar oro negativo")
	
	game_manager.reset_game()
	var initial_gold = game_manager.get_gold()
	game_manager.add_gold(-5)
	var new_gold = game_manager.get_gold()
	
	if new_gold == initial_gold:
		print("✅ PASÓ: Sistema previene agregar cantidades negativas")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Se permitió agregar cantidad negativa")
		tests_failed += 1
	
	game_manager.reset_game()

# ========== Tests del Sistema de Tienda ==========

func run_all_shop_tests():
	"""Ejecuta todos los tests del sistema de tienda"""
	print("\n🛒 TESTS DEL SISTEMA DE TIENDA\n")
	
	test_shop_initialization()
	test_shop_refresh()
	test_shop_get_offers()
	test_shop_get_unit_cost()
	test_shop_offers_count()

func test_shop_initialization():
	"""Test: La tienda se inicializa correctamente"""
	print("📋 Test: Inicialización de tienda")
	
	if shop and shop.game_manager == game_manager and shop.bench == bench:
		print("✅ PASÓ: Tienda inicializada correctamente")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Tienda no se inicializó correctamente")
		tests_failed += 1

func test_shop_refresh():
	"""Test: Refrescar tienda genera nuevas ofertas"""
	print("📋 Test: Refrescar tienda")
	
	var offers_before = shop.get_offers()
	shop.refresh_shop()
	var offers_after = shop.get_offers()
	
	# Verificar que hay ofertas
	if offers_after.size() == 5:
		print("✅ PASÓ: Tienda refrescada correctamente (", offers_after.size(), " ofertas)")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Número incorrecto de ofertas. Esperado: 5, Obtenido: ", offers_after.size())
		tests_failed += 1

func test_shop_get_offers():
	"""Test: Obtener ofertas de la tienda"""
	print("📋 Test: Obtener ofertas")
	
	var offers = shop.get_offers()
	
	if offers.size() == 5:
		print("✅ PASÓ: Se obtuvieron ", offers.size(), " ofertas")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Número incorrecto de ofertas")
		tests_failed += 1

func test_shop_get_unit_cost():
	"""Test: Obtener costo de unidades"""
	print("📋 Test: Obtener costo de unidades")
	
	var elfo_cost = shop.get_unit_cost(UnitData.UnitType.ELFO)
	var enano_cost = shop.get_unit_cost(UnitData.UnitType.ENANO)
	var beastkin_cost = shop.get_unit_cost(UnitData.UnitType.BEASTKIN)
	var mago_cost = shop.get_unit_cost(UnitData.UnitType.MAGO)
	var orco_cost = shop.get_unit_cost(UnitData.UnitType.ORCO)
	var demonio_cost = shop.get_unit_cost(UnitData.UnitType.DEMONIO)
	
	if elfo_cost == 1 and enano_cost == 1 and beastkin_cost == 2 and mago_cost == 3 and orco_cost == 3 and demonio_cost == 3:
		print("✅ PASÓ: Costos de unidades correctos")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Costos incorrectos. Elfo:", elfo_cost, ", Enano:", enano_cost, ", Beastkin:", beastkin_cost, ", Mago:", mago_cost, ", Orco:", orco_cost, ", Demonio:", demonio_cost)
		tests_failed += 1

func test_shop_offers_count():
	"""Test: La tienda tiene el número correcto de ofertas"""
	print("📋 Test: Número de ofertas")
	
	var offers = shop.get_offers()
	if offers.size() == 5:
		print("✅ PASÓ: Tienda tiene 5 ofertas")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Número incorrecto de ofertas. Esperado: 5, Obtenido: ", offers.size())
		tests_failed += 1

# ========== Tests del Sistema de Compra ==========

func run_all_purchase_tests():
	"""Ejecuta todos los tests del sistema de compra"""
	print("\n💳 TESTS DEL SISTEMA DE COMPRA\n")
	
	# Limpiar bench antes de los tests
	cleanup_bench()
	game_manager.reset_game()
	
	test_purchase_success()
	test_purchase_insufficient_gold()
	test_purchase_bench_full()
	test_purchase_invalid_index()
	test_purchase_multiple_units()
	test_purchase_all_units()

func test_purchase_success():
	"""Test: Compra exitosa de unidad"""
	print("📋 Test: Compra exitosa")
	
	cleanup_bench()
	game_manager.reset_game()
	shop.refresh_shop()
	
	var offers = shop.get_offers()
	if offers.size() == 0:
		print("❌ FALLÓ: No hay ofertas disponibles")
		tests_failed += 1
		return
	
	var initial_gold = game_manager.get_gold()
	var unit_type = offers[0]
	var cost = shop.get_unit_cost(unit_type)
	
	# Asegurar que tenemos suficiente oro
	if initial_gold < cost:
		game_manager.add_gold(cost - initial_gold)
	
	var success = shop.purchase_unit(0)
	var new_gold = game_manager.get_gold()
	var unit_in_bench = false
	
	# Verificar que la unidad está en el bench
	for slot_index in bench.units.keys():
		if bench.units[slot_index].unit_type == unit_type:
			unit_in_bench = true
			break
	
	if success and new_gold == game_manager.get_gold() and unit_in_bench:
		print("✅ PASÓ: Unidad comprada y colocada en bench correctamente")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Compra falló o unidad no está en bench")
		tests_failed += 1
	
	cleanup_bench()
	game_manager.reset_game()

func test_purchase_insufficient_gold():
	"""Test: No se puede comprar sin suficiente oro"""
	print("📋 Test: Compra sin suficiente oro")
	
	cleanup_bench()
	game_manager.reset_game()
	shop.refresh_shop()
	
	# Establecer oro a 0
	game_manager.spend_gold(game_manager.get_gold())
	
	var offers = shop.get_offers()
	if offers.size() == 0:
		print("❌ FALLÓ: No hay ofertas disponibles")
		tests_failed += 1
		return
	
	var success = shop.purchase_unit(0)
	
	if not success:
		print("✅ PASÓ: Sistema previene compra sin suficiente oro")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Se permitió comprar sin suficiente oro")
		tests_failed += 1
	
	game_manager.reset_game()

func test_purchase_bench_full():
	"""Test: No se puede comprar si el bench está lleno"""
	print("📋 Test: Compra con bench lleno")
	
	cleanup_bench()
	game_manager.reset_game()
	shop.refresh_shop()
	
	# Llenar el bench
	for i in range(bench.SLOT_COUNT):
		var unit = Unit.new()
		unit.initialize(UnitData.UnitType.ELFO)
		bench.place_unit(unit, i)
	
	var offers = shop.get_offers()
	if offers.size() == 0:
		print("❌ FALLÓ: No hay ofertas disponibles")
		tests_failed += 1
		return
	
	# Asegurar que tenemos suficiente oro
	var cost = shop.get_unit_cost(offers[0])
	game_manager.add_gold(cost)
	
	var success = shop.purchase_unit(0)
	
	if not success:
		print("✅ PASÓ: Sistema previene compra con bench lleno")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Se permitió comprar con bench lleno")
		tests_failed += 1
	
	cleanup_bench()
	game_manager.reset_game()

func test_purchase_invalid_index():
	"""Test: No se puede comprar con índice inválido"""
	print("📋 Test: Compra con índice inválido")
	
	game_manager.reset_game()
	
	# Intentar comprar con índice negativo
	var success_negative = shop.purchase_unit(-1)
	
	# Intentar comprar con índice fuera de rango
	var success_out_of_range = shop.purchase_unit(100)
	
	if not success_negative and not success_out_of_range:
		print("✅ PASÓ: Sistema previene compra con índice inválido")
		tests_passed += 1
	else:
		print("❌ FALLÓ: Se permitió comprar con índice inválido")
		tests_failed += 1
	
	game_manager.reset_game()

func test_purchase_multiple_units():
	"""Test: Comprar múltiples unidades"""
	print("📋 Test: Compra de múltiples unidades")
	
	cleanup_bench()
	game_manager.reset_game()
	shop.refresh_shop()
	
	var offers = shop.get_offers()
	if offers.size() < 2:
		print("❌ FALLÓ: No hay suficientes ofertas")
		tests_failed += 1
		return
	
	# Asegurar que tenemos suficiente oro para 2 compras
	var cost1 = shop.get_unit_cost(offers[0])
	var cost2 = shop.get_unit_cost(offers[1])
	var total_cost = cost1 + cost2
	
	if game_manager.get_gold() < total_cost:
		game_manager.add_gold(total_cost - game_manager.get_gold())
	
	var success1 = shop.purchase_unit(0)
	var success2 = shop.purchase_unit(1)
	
	var units_in_bench = bench.units.size()
	
	if success1 and success2 and units_in_bench == 2:
		print("✅ PASÓ: Se compraron múltiples unidades correctamente")
		tests_passed += 1
	else:
		print("❌ FALLÓ: No se pudieron comprar múltiples unidades. Unidades en bench: ", units_in_bench)
		tests_failed += 1
	
	cleanup_bench()
	game_manager.reset_game()

func test_purchase_all_units():
	"""Test: Comprar todas las unidades posibles con el oro disponible"""
	print("📋 Test: Compra de todas las unidades posibles")
	
	cleanup_bench()
	game_manager.reset_game()
	shop.refresh_shop()
	
	var initial_gold = game_manager.get_gold()
	var offers = shop.get_offers()
	var purchases_made = 0
	
	# Intentar comprar todas las ofertas hasta quedarse sin oro o espacio
	for i in range(offers.size()):
		if bench.is_bench_full():
			break
		
		var cost = shop.get_unit_cost(offers[i])
		if game_manager.has_enough_gold(cost):
			if shop.purchase_unit(i):
				purchases_made += 1
			else:
				break
		else:
			break
	
	var final_gold = game_manager.get_gold()
	var units_in_bench = bench.units.size()
	
	if purchases_made > 0 and units_in_bench == purchases_made:
		print("✅ PASÓ: Se compraron ", purchases_made, " unidades. Oro inicial: ", initial_gold, ", Oro final: ", final_gold)
		tests_passed += 1
	else:
		print("❌ FALLÓ: No se compraron unidades correctamente. Compras: ", purchases_made, ", Unidades en bench: ", units_in_bench)
		tests_failed += 1
	
	cleanup_bench()
	game_manager.reset_game()

# ========== Tests del Sistema de UI de Tienda ==========

func run_all_shop_ui_tests():
	"""Ejecuta todos los tests del sistema de UI de tienda"""
	print("\n🖥️ TESTS DEL SISTEMA DE UI DE TIENDA\n")
	
	# Nota: Estos tests requieren que ShopUI esté en el árbol de escena
	# Por ahora, solo verificamos la lógica básica de actualización
	
	test_shop_ui_gold_update()
	test_shop_ui_offers_update()
	test_shop_ui_button_enable_disable()

func test_shop_ui_gold_update():
	"""Test: Actualización de display de oro funciona"""
	print("📋 Test: Actualización de display de oro")
	
	var initial_gold = game_manager.get_gold()
	
	# Agregar oro
	game_manager.add_gold(5)
	var new_gold = game_manager.get_gold()
	
	if new_gold == initial_gold + 5:
		print("  ✅ PASÓ: Oro se actualiza correctamente (", initial_gold, " -> ", new_gold, ")")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Oro no se actualizó correctamente")
		tests_failed += 1
	
	# Restaurar
	game_manager.gold = initial_gold

func test_shop_ui_offers_update():
	"""Test: Actualización de ofertas funciona"""
	print("📋 Test: Actualización de ofertas")
	
	var initial_offers = shop.get_offers()
	var initial_count = initial_offers.size()
	
	# Refrescar tienda
	shop.refresh_shop()
	var new_offers = shop.get_offers()
	var new_count = new_offers.size()
	
	if new_count == 5:  # Debe tener 5 ofertas
		print("  ✅ PASÓ: Ofertas se actualizan correctamente (", new_count, " ofertas)")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Ofertas no se actualizaron correctamente (Esperado: 5, Obtenido: ", new_count, ")")
		tests_failed += 1

func test_shop_ui_button_enable_disable():
	"""Test: Botones se habilitan/deshabilitan según oro"""
	print("📋 Test: Habilitación/deshabilitación de botones")
	
	# Obtener ofertas
	var offers = shop.get_offers()
	if offers.is_empty():
		print("  ⚠️  ADVERTENCIA: No hay ofertas para probar")
		return
	
	var unit_type = offers[0]
	var cost = shop.get_unit_cost(unit_type)
	
	# Test 1: Con suficiente oro, debería poder comprar
	game_manager.gold = cost + 10  # Oro suficiente
	var can_buy_with_gold = game_manager.has_enough_gold(cost)
	
	# Test 2: Sin suficiente oro, no debería poder comprar
	game_manager.gold = cost - 1  # Oro insuficiente
	var cannot_buy_without_gold = not game_manager.has_enough_gold(cost)
	
	if can_buy_with_gold and cannot_buy_without_gold:
		print("  ✅ PASÓ: Lógica de habilitación de botones correcta")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Lógica de habilitación de botones incorrecta")
		tests_failed += 1
	
	# Restaurar
	game_manager.reset_game()

