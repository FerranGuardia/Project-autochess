extends Node
class_name GameManager

## Gestor del estado del juego
## Maneja: oro, rondas, vidas, y otros sistemas globales

# Señales
signal gold_changed(new_amount: int)
signal round_changed(new_round: int)
signal lives_changed(new_lives: int)
signal game_over()

# Sistema de oro
var gold: int = 10  # Oro inicial
const STARTING_GOLD = 10
const GOLD_PER_ROUND = 5  # Oro que se gana al empezar cada ronda

# Sistema de rondas
var current_round: int = 1

# Sistema de vidas
var lives: int = 5  # Vidas iniciales
const STARTING_LIVES = 5

func _ready():
	# Inicializar valores
	gold = STARTING_GOLD
	current_round = 1
	lives = STARTING_LIVES

# ========== Sistema de Oro ==========

func add_gold(amount: int):
	"""Agrega oro al jugador"""
	if amount <= 0:
		return
	
	gold += amount
	gold_changed.emit(gold)
	print("Oro agregado: +", amount, " (Total: ", gold, ")")

func spend_gold(amount: int) -> bool:
	"""Gasta oro. Retorna true si se pudo gastar, false si no hay suficiente"""
	if amount <= 0:
		return false
	
	if gold < amount:
		print("Error: No hay suficiente oro. Tienes: ", gold, ", necesitas: ", amount)
		return false
	
	gold -= amount
	gold_changed.emit(gold)
	print("Oro gastado: -", amount, " (Total: ", gold, ")")
	return true

func has_enough_gold(amount: int) -> bool:
	"""Verifica si el jugador tiene suficiente oro"""
	return gold >= amount

func get_gold() -> int:
	"""Obtiene el oro actual"""
	return gold

# ========== Sistema de Rondas ==========

func start_new_round():
	"""Inicia una nueva ronda"""
	current_round += 1
	# Agregar oro al empezar la ronda
	add_gold(GOLD_PER_ROUND)
	round_changed.emit(current_round)
	print("Ronda ", current_round, " iniciada. Oro: ", gold)

func get_current_round() -> int:
	"""Obtiene la ronda actual"""
	return current_round

# ========== Sistema de Vidas ==========

func lose_life():
	"""El jugador pierde una vida"""
	if lives <= 0:
		return
	
	lives -= 1
	lives_changed.emit(lives)
	print("Vida perdida. Vidas restantes: ", lives)
	
	if lives <= 0:
		game_over.emit()
		print("¡GAME OVER!")

func get_lives() -> int:
	"""Obtiene las vidas actuales"""
	return lives

# ========== Reset ==========

func reset_game():
	"""Reinicia el juego a los valores iniciales"""
	gold = STARTING_GOLD
	current_round = 1
	lives = STARTING_LIVES
	gold_changed.emit(gold)
	round_changed.emit(current_round)
	lives_changed.emit(lives)
	print("Juego reiniciado")

