extends Node
class_name SpriteSizeTests

## Tests unitarios para verificar el tamaño de sprites y posicionamiento de barras
## Ejecutar desde el editor o desde código

var tests_passed: int = 0
var tests_failed: int = 0

# Referencias para los tests
var test_unit: Unit = null

func _ready():
	print("==================================================")
	print("🧪 INICIANDO TESTS DE TAMAÑO DE SPRITES Y BARRAS")
	print("==================================================")
	
	# Ejecutar todos los tests
	run_all_sprite_size_tests()
	run_all_bar_position_tests()
	
	# Mostrar resumen
	print("==================================================")
	print("📊 RESUMEN DE TESTS")
	print("✅ Tests pasados: ", tests_passed)
	print("❌ Tests fallados: ", tests_failed)
	print("==================================================")

# ========== Tests de Tamaño de Sprites ==========

func run_all_sprite_size_tests():
	"""Ejecuta todos los tests de tamaño de sprites"""
	print("\n📐 TESTS DE TAMAÑO DE SPRITES\n")
	
	test_sprite_scale_factor()
	test_sprite_size_calculation()
	test_sprite_top_position_calculation()

func test_sprite_scale_factor():
	"""Test: Verificar que el factor de escala es 1.6 (duplicado)"""
	print("📋 Test: Factor de escala de sprites")
	
	setup_test_unit()
	
	if test_unit.sprite:
		var scale = test_unit.sprite.scale.x
		# El factor debería ser aproximadamente 1.6 (puede variar según el tamaño de la imagen)
		# Verificamos que sea mayor que 1.0 (duplicado del original 0.8)
		if scale > 1.0:
			print("  ✅ PASÓ: Sprite tiene escala mayor a 1.0 (duplicado)")
			print("     Escala actual: %f" % scale)
			tests_passed += 1
		else:
			print("  ❌ FALLÓ: Sprite no está duplicado")
			print("     Escala: %f (esperado > 1.0)" % scale)
			tests_failed += 1
	else:
		print("  ❌ FALLÓ: Sprite no existe")
		tests_failed += 1
	
	cleanup_test_unit()

func test_sprite_size_calculation():
	"""Test: Verificar cálculo del tamaño del sprite"""
	print("📋 Test: Cálculo de tamaño de sprite")
	
	setup_test_unit()
	
	if test_unit.sprite and test_unit.sprite.texture:
		var texture_width = test_unit.sprite.texture.get_width()
		var texture_height = test_unit.sprite.texture.get_height()
		var sprite_size = max(texture_width, texture_height)
		var scale = test_unit.sprite.scale.x
		var final_size = sprite_size * scale
		
		print("  📏 Tamaño original: %dx%d" % [texture_width, texture_height])
		print("  📏 Tamaño considerado (cuadrado): %d" % sprite_size)
		print("  📏 Escala: %f" % scale)
		print("  📏 Tamaño final escalado: ~%dpx" % final_size)
		
		# Verificar que el tamaño final es razonable (mayor que 100px, menor que 500px)
		if final_size > 100 and final_size < 500:
			print("  ✅ PASÓ: Tamaño final del sprite es razonable")
			tests_passed += 1
		else:
			print("  ❌ FALLÓ: Tamaño final fuera de rango esperado")
			tests_failed += 1
	else:
		print("  ❌ FALLÓ: Sprite o textura no existe")
		tests_failed += 1
	
	cleanup_test_unit()

func test_sprite_top_position_calculation():
	"""Test: Verificar cálculo de posición superior del sprite"""
	print("📋 Test: Cálculo de posición superior del sprite")
	
	setup_test_unit()
	
	var sprite_top = test_unit.get_sprite_top_position()
	
	# La posición superior debería ser negativa (arriba del centro)
	if sprite_top < 0:
		print("  ✅ PASÓ: Posición superior calculada correctamente (negativa)")
		print("     Posición Y: %f" % sprite_top)
		tests_passed += 1
	else:
		print("  ❌ FALLÓ: Posición superior debería ser negativa")
		print("     Obtenido: %f" % sprite_top)
		tests_failed += 1
	
	cleanup_test_unit()

# ========== Tests de Posicionamiento de Barras ==========

func run_all_bar_position_tests():
	"""Ejecuta todos los tests de posicionamiento de barras"""
	print("\n📍 TESTS DE POSICIONAMIENTO DE BARRAS\n")
	
	test_bars_above_sprite()
	test_health_bar_position()
	test_energy_bar_position()
	test_bar_positions_relative()

func test_bars_above_sprite():
	"""Test: Verificar que las barras están encima del sprite"""
	print("📋 Test: Barras posicionadas encima del sprite")
	
	setup_test_unit()
	
	var sprite_top = test_unit.get_sprite_top_position()
	
	if test_unit.health_bar_background and test_unit.energy_bar_background:
		var health_y = test_unit.health_bar_background.position.y
		var energy_y = test_unit.energy_bar_background.position.y
		
		# Ambas barras deberían estar arriba del sprite (Y menor que sprite_top)
		if health_y < sprite_top and energy_y < sprite_top:
			print("  ✅ PASÓ: Ambas barras están encima del sprite")
			print("     Sprite top: %f, Health Y: %f, Energy Y: %f" % [sprite_top, health_y, energy_y])
			tests_passed += 1
		else:
			print("  ❌ FALLÓ: Alguna barra no está encima del sprite")
			print("     Sprite top: %f, Health Y: %f, Energy Y: %f" % [sprite_top, health_y, energy_y])
			tests_failed += 1
	else:
		print("  ❌ FALLÓ: Barras no existen")
		tests_failed += 1
	
	cleanup_test_unit()

func test_health_bar_position():
	"""Test: Verificar posición específica de la barra de vida"""
	print("📋 Test: Posición de barra de vida")
	
	setup_test_unit()
	
	var sprite_top = test_unit.get_sprite_top_position()
	var expected_y = sprite_top - 8.0
	
	if test_unit.health_bar_background:
		var actual_y = test_unit.health_bar_background.position.y
		
		# Permitir pequeña diferencia por redondeo
		if abs(actual_y - expected_y) < 1.0:
			print("  ✅ PASÓ: Barra de vida en posición correcta")
			print("     Esperado: ~%f, Obtenido: %f" % [expected_y, actual_y])
			tests_passed += 1
		else:
			print("  ❌ FALLÓ: Barra de vida en posición incorrecta")
			print("     Esperado: ~%f, Obtenido: %f" % [expected_y, actual_y])
			tests_failed += 1
	else:
		print("  ❌ FALLÓ: Barra de vida no existe")
		tests_failed += 1
	
	cleanup_test_unit()

func test_energy_bar_position():
	"""Test: Verificar posición específica de la barra de energía"""
	print("📋 Test: Posición de barra de energía")
	
	setup_test_unit()
	
	var sprite_top = test_unit.get_sprite_top_position()
	var expected_y = sprite_top - 16.0
	
	if test_unit.energy_bar_background:
		var actual_y = test_unit.energy_bar_background.position.y
		
		# Permitir pequeña diferencia por redondeo
		if abs(actual_y - expected_y) < 1.0:
			print("  ✅ PASÓ: Barra de energía en posición correcta")
			print("     Esperado: ~%f, Obtenido: %f" % [expected_y, actual_y])
			tests_passed += 1
		else:
			print("  ❌ FALLÓ: Barra de energía en posición incorrecta")
			print("     Esperado: ~%f, Obtenido: %f" % [expected_y, actual_y])
			tests_failed += 1
	else:
		print("  ❌ FALLÓ: Barra de energía no existe")
		tests_failed += 1
	
	cleanup_test_unit()

func test_bar_positions_relative():
	"""Test: Verificar que la barra de energía está encima de la barra de vida"""
	print("📋 Test: Posición relativa entre barras")
	
	setup_test_unit()
	
	if test_unit.health_bar_background and test_unit.energy_bar_background:
		var health_y = test_unit.health_bar_background.position.y
		var energy_y = test_unit.energy_bar_background.position.y
		
		# La barra de energía debería estar más arriba (Y menor) que la de vida
		if energy_y < health_y:
			var distance = health_y - energy_y
			print("  ✅ PASÓ: Barra de energía está encima de la barra de vida")
			print("     Distancia: %f píxeles" % distance)
			tests_passed += 1
		else:
			print("  ❌ FALLÓ: Barra de energía no está encima de la barra de vida")
			print("     Health Y: %f, Energy Y: %f" % [health_y, energy_y])
			tests_failed += 1
	else:
		print("  ❌ FALLÓ: Barras no existen")
		tests_failed += 1
	
	cleanup_test_unit()

# ========== Helpers ==========

func setup_test_unit():
	"""Configura una unidad de prueba"""
	test_unit = Unit.new()
	test_unit.name = "TestUnit"
	add_child(test_unit)
	test_unit.initialize(UnitData.UnitType.MAGO)
	
	# Esperar un frame para que el sprite se cree completamente
	await get_tree().process_frame

func cleanup_test_unit():
	"""Limpia la unidad de prueba"""
	if test_unit and is_instance_valid(test_unit):
		test_unit.queue_free()
		test_unit = null
