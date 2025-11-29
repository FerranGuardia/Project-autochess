extends Node
class_name EnergyTests

## Tests unitarios para el sistema de barra de energía
## Ejecutar desde el editor o desde código

var tests_passed: int = 0
var tests_failed: int = 0

# Referencias para los tests
var test_unit: Unit

func _ready():
	print("==================================================")
	print("🧪 INICIANDO TESTS DEL SISTEMA DE ENERGÍA")
	print("==================================================")
	
	# Ejecutar todos los tests
	run_all_energy_system_tests()
	run_all_energy_bar_tests()
	run_all_energy_combat_tests()
	
	# Mostrar resumen
	print("==================================================")
	print("📊 RESUMEN DE TESTS DE ENERGÍA")
	print("✅ Tests pasados: ", tests_passed)
	print("❌ Tests fallados: ", tests_failed)
	print("==================================================")

# ========== Tests del Sistema de Energía ==========

func run_all_energy_system_tests():
	"""Ejecuta todos los tests del sistema de energía"""
	print("\n⚡ TESTS DEL SISTEMA DE ENERGÍA\n")
	
	test_energy_initialization()
	test_energy_default_values()
	test_gain_energy()
	test_gain_energy_overflow()
	test_gain_energy_negative()
	test_reset_energy()
	test_get_energy()
	test_get_max_energy()

func test_energy_initialization():
	"""Test: La energía se inicializa correctamente"""
	print("📋 Test: Inicialización de energía")
	
	setup_test_unit()
	
	if test_unit.max_energy == 100 and test_unit.current_energy == 0:
		print("  ✅ PASÓ: Energía inicializada correctamente (max: 100, current: 0)")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Energía no inicializada correctamente")
		print("     Esperado: max=100, current=0")
		print("     Obtenido: max=%d, current=%d" % [test_unit.max_energy, test_unit.current_energy])
		tests_failed += 1
	
	cleanup_test_unit()

func test_energy_default_values():
	"""Test: Los valores por defecto de energía son correctos"""
	print("📋 Test: Valores por defecto de energía")
	
	setup_test_unit()
	
	var max_energy = test_unit.get_max_energy()
	var current_energy = test_unit.get_energy()
	
	if max_energy == 100 and current_energy == 0:
		print("  ✅ PASÓ: Valores por defecto correctos")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Valores por defecto incorrectos")
		tests_failed += 1
	
	cleanup_test_unit()

func test_gain_energy():
	"""Test: Ganar energía funciona correctamente"""
	print("📋 Test: Ganar energía")
	
	setup_test_unit()
	
	# Ganar 25 de energía
	test_unit.gain_energy(25)
	if test_unit.current_energy == 25:
		print("  ✅ PASÓ: Energía aumentó correctamente (25)")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Energía no aumentó correctamente")
		print("     Esperado: 25, Obtenido: %d" % test_unit.current_energy)
		tests_failed += 1
	
	# Ganar más energía
	test_unit.gain_energy(30)
	if test_unit.current_energy == 55:
		print("  ✅ PASÓ: Energía acumulativa funciona (55)")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Energía acumulativa no funciona")
		print("     Esperado: 55, Obtenido: %d" % test_unit.current_energy)
		tests_failed += 1
	
	cleanup_test_unit()

func test_gain_energy_overflow():
	"""Test: La energía no excede el máximo"""
	print("📋 Test: Límite máximo de energía")
	
	setup_test_unit()
	
	# Intentar ganar más energía de la máxima
	test_unit.current_energy = 90
	test_unit.gain_energy(50)  # Debería quedar en 100, no en 140
	
	if test_unit.current_energy == 100:
		print("  ✅ PASÓ: Energía no excede el máximo (100)")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Energía excedió el máximo")
		print("     Esperado: 100, Obtenido: %d" % test_unit.current_energy)
		tests_failed += 1
	
	cleanup_test_unit()

func test_gain_energy_negative():
	"""Test: No se puede ganar energía negativa"""
	print("📋 Test: Ganar energía negativa")
	
	setup_test_unit()
	
	var initial_energy = test_unit.current_energy
	test_unit.gain_energy(-10)  # No debería cambiar
	
	if test_unit.current_energy == initial_energy:
		print("  ✅ PASÓ: Energía negativa ignorada")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Energía negativa fue aplicada")
		tests_failed += 1
	
	cleanup_test_unit()

func test_reset_energy():
	"""Test: Resetear energía funciona correctamente"""
	print("📋 Test: Resetear energía")
	
	setup_test_unit()
	
	# Llenar energía
	test_unit.current_energy = 100
	test_unit.reset_energy()
	
	if test_unit.current_energy == 0:
		print("  ✅ PASÓ: Energía reseteada correctamente (0)")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Energía no se reseteó")
		print("     Esperado: 0, Obtenido: %d" % test_unit.current_energy)
		tests_failed += 1
	
	cleanup_test_unit()

func test_get_energy():
	"""Test: Obtener energía actual funciona"""
	print("📋 Test: Obtener energía actual")
	
	setup_test_unit()
	
	test_unit.current_energy = 75
	var energy = test_unit.get_energy()
	
	if energy == 75:
		print("  ✅ PASÓ: get_energy() retorna valor correcto")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: get_energy() retorna valor incorrecto")
		tests_failed += 1
	
	cleanup_test_unit()

func test_get_max_energy():
	"""Test: Obtener energía máxima funciona"""
	print("📋 Test: Obtener energía máxima")
	
	setup_test_unit()
	
	var max_energy = test_unit.get_max_energy()
	
	if max_energy == 100:
		print("  ✅ PASÓ: get_max_energy() retorna valor correcto")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: get_max_energy() retorna valor incorrecto")
		tests_failed += 1
	
	cleanup_test_unit()

# ========== Tests de Barra de Energía Visual ==========

func run_all_energy_bar_tests():
	"""Ejecuta todos los tests de la barra visual de energía"""
	print("\n🎨 TESTS DE BARRA DE ENERGÍA VISUAL\n")
	
	test_energy_bar_creation()
	test_energy_bar_position()
	test_energy_bar_update()
	test_energy_bar_colors()

func test_energy_bar_creation():
	"""Test: La barra de energía se crea correctamente"""
	print("📋 Test: Creación de barra de energía")
	
	setup_test_unit()
	
	if test_unit.energy_bar and test_unit.energy_bar_background and test_unit.energy_bar_fill:
		print("  ✅ PASÓ: Barra de energía creada correctamente")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Barra de energía no se creó")
		tests_failed += 1
	
	cleanup_test_unit()

func test_energy_bar_position():
	"""Test: La barra de energía está posicionada correctamente"""
	print("📋 Test: Posición de barra de energía")
	
	setup_test_unit()
	
	if test_unit.energy_bar_background:
		var position = test_unit.energy_bar_background.position
		# Debe estar en Y = -42 (debajo de la barra de vida que está en -50)
		if position.y == -42:
			print("  ✅ PASÓ: Barra de energía posicionada correctamente (Y: -42)")
			tests_passed += 1
		else:
			print("  ❌ FALLÓ: Barra de energía en posición incorrecta")
			print("     Esperado Y: -42, Obtenido: %d" % position.y)
			tests_failed += 1
	else:
		print("  ❌ FALLÓ: Barra de energía no existe")
		tests_failed += 1
	
	cleanup_test_unit()

func test_energy_bar_update():
	"""Test: La barra de energía se actualiza correctamente"""
	print("📋 Test: Actualización de barra de energía")
	
	setup_test_unit()
	
	# Ganar energía y verificar que la barra se actualiza
	var initial_width = test_unit.energy_bar_fill.size.x
	test_unit.gain_energy(50)  # 50% de energía
	var new_width = test_unit.energy_bar_fill.size.x
	
	if new_width > initial_width:
		print("  ✅ PASÓ: Barra de energía se actualiza (ancho aumentó)")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Barra de energía no se actualizó")
		tests_failed += 1
	
	# Verificar que con 100% de energía, el ancho es máximo
	test_unit.gain_energy(50)
	var full_width = test_unit.energy_bar_fill.size.x
	var expected_width = 58.0  # Ancho máximo de la barra
	
	if abs(full_width - expected_width) < 0.1:  # Tolerancia para floats
		print("  ✅ PASÓ: Barra de energía al 100% tiene ancho correcto")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Barra de energía al 100% tiene ancho incorrecto")
		print("     Esperado: ~58.0, Obtenido: %f" % full_width)
		tests_failed += 1
	
	cleanup_test_unit()

func test_energy_bar_colors():
	"""Test: Los colores de la barra de energía cambian correctamente"""
	print("📋 Test: Colores de barra de energía")
	
	setup_test_unit()
	
	# Energía baja (azul normal)
	test_unit.current_energy = 30
	test_unit.update_energy_bar()
	var low_color = test_unit.energy_bar_fill.color
	var is_blue = low_color.b > 0.8 and low_color.r < 0.3
	
	if is_blue:
		print("  ✅ PASÓ: Color azul para energía baja")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Color incorrecto para energía baja")
		tests_failed += 1
	
	# Energía casi llena (azul claro)
	test_unit.current_energy = 85
	test_unit.update_energy_bar()
	var mid_color = test_unit.energy_bar_fill.color
	
	# Energía llena (amarillo)
	test_unit.current_energy = 100
	test_unit.update_energy_bar()
	var full_color = test_unit.energy_bar_fill.color
	var is_yellow = full_color.r > 0.8 and full_color.g > 0.8 and full_color.b < 0.3
	
	if is_yellow:
		print("  ✅ PASÓ: Color amarillo para energía llena")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Color incorrecto para energía llena")
		tests_failed += 1
	
	cleanup_test_unit()

# ========== Tests de Integración con Combate ==========

func run_all_energy_combat_tests():
	"""Ejecuta todos los tests de integración energía-combate"""
	print("\n⚔️ TESTS DE ENERGÍA EN COMBATE\n")
	
	test_energy_gain_on_attack()
	test_energy_reset_at_combat_start()
	test_energy_full_signal()
	test_energy_reset_after_ability()

func test_energy_gain_on_attack():
	"""Test: La energía se carga al atacar"""
	print("📋 Test: Carga de energía en ataques")
	
	setup_test_unit()
	
	# Simular ataque (ganar energía como lo haría CombatSystem)
	var initial_energy = test_unit.current_energy
	var energy_per_attack = CombatSystem.ENERGY_PER_ATTACK
	test_unit.gain_energy(energy_per_attack)
	
	if test_unit.current_energy == initial_energy + energy_per_attack:
		print("  ✅ PASÓ: Energía se carga correctamente por ataque (%d)" % energy_per_attack)
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Energía no se carga por ataque")
		print("     Esperado: %d, Obtenido: %d" % [initial_energy + energy_per_attack, test_unit.current_energy])
		tests_failed += 1
	
	# Verificar que con 2 ataques se llena (50 + 50 = 100)
	test_unit.reset_energy()
	test_unit.gain_energy(energy_per_attack)
	test_unit.gain_energy(energy_per_attack)
	if test_unit.current_energy == 100:
		print("  ✅ PASÓ: Energía se llena en 2 ataques (tiempo de carga a la mitad)")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Energía no se llena en 2 ataques")
		tests_failed += 1
	
	cleanup_test_unit()

func test_energy_full_signal():
	"""Test: La señal energy_full se emite cuando la energía está llena"""
	print("📋 Test: Señal energy_full")
	
	setup_test_unit()
	
	var signal_emitted = false
	test_unit.energy_full.connect(func(_unit): signal_emitted = true)
	
	# Llenar energía hasta 100
	test_unit.current_energy = 90
	test_unit.gain_energy(15)  # Debería llegar a 100 y emitir señal
	
	# Esperar un frame para que la señal se procese
	await get_tree().process_frame
	
	if signal_emitted:
		print("  ✅ PASÓ: Señal energy_full emitida correctamente")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Señal energy_full no se emitió")
		tests_failed += 1
	
	cleanup_test_unit()

func test_energy_reset_at_combat_start():
	"""Test: La energía se resetea al inicio de cada combate"""
	print("📋 Test: Reset de energía al inicio de combate")
	
	setup_test_unit()
	
	# Simular que la unidad tiene energía de un combate anterior
	test_unit.current_energy = 75
	
	# Simular inicio de combate (resetear energía)
	test_unit.reset_energy()
	
	if test_unit.current_energy == 0:
		print("  ✅ PASÓ: Energía reseteada al inicio de combate")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Energía no se reseteó al inicio de combate")
		print("     Esperado: 0, Obtenido: %d" % test_unit.current_energy)
		tests_failed += 1
	
	cleanup_test_unit()

func test_energy_reset_after_ability():
	"""Test: La energía se resetea después de usar habilidad"""
	print("📋 Test: Reset de energía después de habilidad")
	
	setup_test_unit()
	
	# Llenar energía
	test_unit.current_energy = 100
	test_unit.use_ability()  # Debería resetear a 0
	
	if test_unit.current_energy == 0:
		print("  ✅ PASÓ: Energía reseteada después de usar habilidad")
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Energía no se reseteó después de habilidad")
		print("     Esperado: 0, Obtenido: %d" % test_unit.current_energy)
		tests_failed += 1
	
	cleanup_test_unit()

# ========== Helpers ==========

func setup_test_unit():
	"""Configura una unidad de prueba"""
	test_unit = Unit.new()
	test_unit.name = "TestUnit"
	add_child(test_unit)
	test_unit.initialize(UnitData.UnitType.MAGO)

func cleanup_test_unit():
	"""Limpia la unidad de prueba"""
	if test_unit and is_instance_valid(test_unit):
		test_unit.queue_free()
		test_unit = null

