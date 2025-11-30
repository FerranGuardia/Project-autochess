extends Node
class_name Shop

## Sistema de tienda
## Genera ofertas aleatorias y maneja las compras

# Señales
signal unit_purchased(unit_type: UnitData.UnitType, cost: int)

# Configuración
const SHOP_OFFERS = 5  # Número de ofertas en la tienda

# Costos de unidades según el cuestionario MVP
const UNIT_COSTS = {
	UnitData.UnitType.ELFO: 1,
	UnitData.UnitType.ENANO: 1,
	UnitData.UnitType.BEASTKIN: 2,
	UnitData.UnitType.MAGO: 3,
	UnitData.UnitType.ORCO: 3,
	UnitData.UnitType.DEMONIO: 3
}

# Ofertas actuales de la tienda
var current_offers: Array[UnitData.UnitType] = []

# Referencias
var game_manager: GameManager = null
var bench: Bench = null

func _ready():
	# No generar ofertas aquí - se hará después de initialize()
	pass

func initialize(manager: GameManager, bench_ref: Bench):
	"""Inicializa la tienda con referencias necesarias"""
	game_manager = manager
	bench = bench_ref
	# Generar ofertas iniciales después de tener las referencias
	refresh_shop()

func refresh_shop():
	"""Genera nuevas ofertas aleatorias para la tienda"""
	current_offers.clear()
	
	# Obtener todos los tipos de unidades disponibles
	var all_unit_types = [
		UnitData.UnitType.MAGO,
		UnitData.UnitType.ORCO,
		UnitData.UnitType.ELFO,
		UnitData.UnitType.ENANO,
		UnitData.UnitType.BEASTKIN,
		UnitData.UnitType.DEMONIO
	]
	
	# Generar SHOP_OFFERS ofertas aleatorias
	for i in range(SHOP_OFFERS):
		var random_type = all_unit_types[randi() % all_unit_types.size()]
		current_offers.append(random_type)
	
	print("Tienda actualizada. Ofertas: ", get_offers_display())

func get_offers() -> Array[UnitData.UnitType]:
	"""Obtiene las ofertas actuales de la tienda"""
	return current_offers.duplicate()

func get_unit_cost(unit_type: UnitData.UnitType) -> int:
	"""Obtiene el costo de una unidad"""
	if UNIT_COSTS.has(unit_type):
		return UNIT_COSTS[unit_type]
	return 999  # Costo muy alto si no está definido

func purchase_unit(offer_index: int) -> bool:
	"""Intenta comprar una unidad de la tienda"""
	if offer_index < 0 or offer_index >= current_offers.size():
		print("Error: Índice de oferta inválido: ", offer_index)
		return false
	
	var unit_type = current_offers[offer_index]
	var cost = get_unit_cost(unit_type)
	
	# Verificar que tenemos GameManager
	if not game_manager:
		print("Error: GameManager no está inicializado")
		return false
	
	# Verificar que tenemos suficiente oro
	if not game_manager.has_enough_gold(cost):
		print("Error: No hay suficiente oro para comprar ", UnitData.get_unit_name(unit_type))
		return false
	
	# Verificar que tenemos espacio en el bench
	if not bench:
		print("Error: Bench no está inicializado")
		return false
	
	# Verificar espacio en el bench
	if bench.is_bench_full():
		print("Error: El banquillo está lleno")
		return false
	
	# Gastar oro
	if not game_manager.spend_gold(cost):
		return false
	
	# Crear la unidad
	var unit = Unit.new()
	unit.initialize(unit_type)
	
	# Colocar en el bench (en el primer slot disponible)
	var placed = false
	for slot_index in range(bench.SLOT_COUNT):
		if not bench.is_slot_occupied(slot_index):
			if bench.place_unit(unit, slot_index):
				placed = true
				break
	
	if not placed:
		# Si no se pudo colocar, devolver el oro
		game_manager.add_gold(cost)
		print("Error: No se pudo colocar la unidad en el banquillo")
		return false
	
	# Emitir señal de compra exitosa
	unit_purchased.emit(unit_type, cost)
	print("Unidad comprada: ", UnitData.get_unit_name(unit_type), " por ", cost, " oro")
	
	return true

func get_offers_display() -> String:
	"""Obtiene una representación en texto de las ofertas"""
	var display = []
	for i in range(current_offers.size()):
		var unit_type = current_offers[i]
		var cost = get_unit_cost(unit_type)
		display.append("%d: %s (%d oro)" % [i, UnitData.get_unit_name(unit_type), cost])
	return ", ".join(display)
