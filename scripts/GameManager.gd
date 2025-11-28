extends Node
class_name GameManager

## Gestor del estado del juego
## Maneja: oro, rondas, vidas, y otros sistemas globales

# Señales
signal gold_changed(new_amount: int)
signal round_changed(new_round: int)
signal lives_changed(new_lives: int)
signal game_over()
signal phase_changed(new_phase: int)
signal combat_started()
signal combat_ended(victory: bool)
signal preparation_time_changed(time_remaining: float)  # Tiempo restante de preparación
signal victory()  # Se emite cuando se completa la ronda 5

# Sistema de oro
var gold: int = 10  # Oro inicial
const STARTING_GOLD = 10
const GOLD_PER_ROUND = 5  # Oro que se gana al empezar cada ronda

# Sistema de rondas
var current_round: int = 1

# Sistema de vidas
var lives: int = 5  # Vidas iniciales
const STARTING_LIVES = 5

# Sistema de fases
enum Phase {
	PREPARATION,  # Fase de preparación (comprar, colocar unidades)
	COMBAT        # Fase de combate
}
var current_phase: Phase = Phase.PREPARATION

# Sistema de temporizador de preparación
const PREPARATION_TIME: float = 30.0  # 30 segundos de preparación
var preparation_timer: Timer
var preparation_time_remaining: float = 0.0

func _ready():
	# Inicializar valores
	gold = STARTING_GOLD
	current_round = 1
	lives = STARTING_LIVES
	
	# Crear temporizador de preparación
	setup_preparation_timer()
	
	# Iniciar la primera fase de preparación
	start_preparation_phase()

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

func reward_enemy_kill(enemy_type: EnemyData.EnemyType):
	"""Otorga oro al jugador por matar un enemigo"""
	var gold_reward = EnemyData.get_enemy_gold_reward(enemy_type)
	if gold_reward > 0:
		add_gold(gold_reward)
		print("Loot obtenido: +", gold_reward, " oro por matar ", EnemyData.get_enemy_name(enemy_type))

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
	current_phase = Phase.PREPARATION
	preparation_time_remaining = 0.0
	
	# Detener temporizador si está corriendo
	if preparation_timer:
		preparation_timer.stop()
	
	gold_changed.emit(gold)
	round_changed.emit(current_round)
	lives_changed.emit(lives)
	phase_changed.emit(current_phase)
	
	# Reiniciar fase de preparación
	start_preparation_phase()
	
	print("Juego reiniciado")

# ========== Sistema de Fases ==========

func start_combat():
	"""Inicia la fase de combate"""
	if current_phase == Phase.COMBAT:
		return
	
	# Detener el temporizador de preparación si está corriendo
	if preparation_timer and preparation_timer.time_left > 0:
		preparation_timer.stop()
		preparation_time_remaining = 0.0
		preparation_time_changed.emit(0.0)
	
	current_phase = Phase.COMBAT
	phase_changed.emit(current_phase)
	combat_started.emit()
	print("Combate iniciado - Ronda ", current_round)

func end_combat(victory: bool):
	"""Termina la fase de combate"""
	if current_phase != Phase.COMBAT:
		return
	
	current_phase = Phase.PREPARATION
	phase_changed.emit(current_phase)
	combat_ended.emit(victory)
	
	if victory:
		print("¡Victoria! Ronda ", current_round, " completada")
		
		# Verificar si se completó la ronda 5 (victoria del juego)
		if current_round >= 5:
			print("¡FELICIDADES! Has completado todas las rondas. ¡VICTORIA!")
			victory.emit()
			return
		
		# Iniciar nueva ronda (incrementa current_round) y fase de preparación
		start_new_round()
		start_preparation_phase()
	else:
		print("Derrota. Perdiste una vida")
		lose_life()
		
		# Verificar game over
		if lives <= 0:
			return
		
		# Iniciar nueva ronda (incrementa current_round) y fase de preparación
		start_new_round()
		start_preparation_phase()

func get_current_phase() -> Phase:
	"""Obtiene la fase actual"""
	return current_phase

func is_preparation_phase() -> bool:
	"""Verifica si estamos en fase de preparación"""
	return current_phase == Phase.PREPARATION

func is_combat_phase() -> bool:
	"""Verifica si estamos en fase de combate"""
	return current_phase == Phase.COMBAT

# ========== Sistema de Temporizador de Preparación ==========

func setup_preparation_timer():
	"""Configura el temporizador de preparación"""
	preparation_timer = Timer.new()
	preparation_timer.name = "PreparationTimer"
	preparation_timer.wait_time = PREPARATION_TIME
	preparation_timer.one_shot = true
	preparation_timer.timeout.connect(_on_preparation_timer_timeout)
	add_child(preparation_timer)

func start_preparation_phase():
	"""Inicia la fase de preparación con temporizador de 30 segundos"""
	if current_phase != Phase.PREPARATION:
		current_phase = Phase.PREPARATION
		phase_changed.emit(current_phase)
	
	# Reiniciar y empezar el temporizador
	preparation_time_remaining = PREPARATION_TIME
	preparation_timer.start()
	
	print("Fase de preparación iniciada. Tienes ", PREPARATION_TIME, " segundos para prepararte.")
	print("Ronda ", current_round, " comenzará automáticamente...")

func _on_preparation_timer_timeout():
	"""Se llama cuando el temporizador de preparación termina"""
	print("Tiempo de preparación terminado. Iniciando combate...")
	start_combat()

func get_preparation_time_remaining() -> float:
	"""Obtiene el tiempo restante de preparación"""
	if preparation_timer and preparation_timer.time_left > 0:
		preparation_time_remaining = preparation_timer.time_left
	return preparation_time_remaining

func _process(_delta):
	"""Actualiza el tiempo restante y emite señal para UI"""
	if current_phase == Phase.PREPARATION and preparation_timer:
		var time_left = preparation_timer.time_left
		if time_left != preparation_time_remaining:
			preparation_time_remaining = time_left
			preparation_time_changed.emit(preparation_time_remaining)

