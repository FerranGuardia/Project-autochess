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
	PREPARATION,  # Fase inicial de preparación (1 minuto)
	COMBAT,       # Fase de combate (1 minuto por ronda)
	INTERFACE     # Interfase entre rondas (30 segundos)
}
var current_phase: Phase = Phase.PREPARATION

# Sistema de temporizadores
const PREPARATION_TIME: float = 60.0  # 60 segundos (1 minuto) - Preparación inicial
const COMBAT_TIME: float = 60.0  # 60 segundos (1 minuto) - Cada ronda de combate
const INTERFACE_TIME: float = 30.0  # 30 segundos - Interfase entre rondas

var preparation_timer: Timer
var combat_timer: Timer
var interface_timer: Timer
var preparation_time_remaining: float = 0.0
var combat_time_remaining: float = 0.0
var interface_time_remaining: float = 0.0

signal combat_time_changed(time_remaining: float)  # Tiempo restante de combate
signal interface_time_changed(time_remaining: float)  # Tiempo restante de interfase

func _ready():
	# Inicializar valores
	gold = STARTING_GOLD
	current_round = 1
	lives = STARTING_LIVES
	current_phase = Phase.PREPARATION  # Asegurar que empiece en fase de preparación
	
	# Crear temporizadores de preparación, combate e interfase
	setup_preparation_timer()
	setup_combat_timer()
	setup_interface_timer()
	
	# Iniciar la primera fase de preparación (1 minuto)
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
	
	# Detener temporizadores si están corriendo
	if preparation_timer:
		preparation_timer.stop()
	if combat_timer:
		combat_timer.stop()
	if interface_timer:
		interface_timer.stop()
	combat_time_remaining = 0.0
	interface_time_remaining = 0.0
	
	gold_changed.emit(gold)
	round_changed.emit(current_round)
	lives_changed.emit(lives)
	phase_changed.emit(current_phase)
	
	# Reiniciar fase de preparación
	start_preparation_phase()
	
	print("Juego reiniciado")

# ========== Sistema de Fases ==========

func start_combat():
	"""Inicia la fase de combate con temporizador de 60 segundos (1 minuto)"""
	if current_phase == Phase.COMBAT:
		return
	
	# Verificar si el juego ya terminó (victoria)
	if current_round > 5:
		print("Juego completado. No se puede iniciar más combate.")
		return
	
	# Detener otros temporizadores si están corriendo
	if preparation_timer and preparation_timer.time_left > 0:
		preparation_timer.stop()
		preparation_time_remaining = 0.0
		preparation_time_changed.emit(0.0)
	if interface_timer and interface_timer.time_left > 0:
		interface_timer.stop()
		interface_time_remaining = 0.0
		interface_time_changed.emit(0.0)
	
	current_phase = Phase.COMBAT
	phase_changed.emit(current_phase)
	combat_started.emit()
	
	# Reiniciar y empezar el temporizador de combate
	combat_time_remaining = COMBAT_TIME
	combat_timer.start()
	
	print("Combate iniciado - Ronda ", current_round)
	print("Tienes ", COMBAT_TIME, " segundos (1 minuto) para el combate.")

func end_combat(victory: bool):
	"""Termina la fase de combate y pasa a interfase"""
	if current_phase != Phase.COMBAT:
		return
	
	# Detener el temporizador de combate si está corriendo
	if combat_timer and combat_timer.time_left > 0:
		combat_timer.stop()
		combat_time_remaining = 0.0
		combat_time_changed.emit(0.0)
	
	combat_ended.emit(victory)
	
	if victory:
		print("¡Victoria! Ronda ", current_round, " completada")
		
		# Verificar si se completó la ronda 5 (victoria del juego)
		if current_round >= 5:
			print("¡FELICIDADES! Has completado todas las rondas. ¡VICTORIA!")
			self.victory.emit()
			return
		
		# Pasar a interfase antes de la siguiente ronda
		start_interface_phase()
	else:
		print("Derrota. Perdiste una vida")
		lose_life()
		
		# Verificar game over
		if lives <= 0:
			return
		
		# Pasar a interfase antes de la siguiente ronda
		start_interface_phase()

func get_current_phase() -> Phase:
	"""Obtiene la fase actual"""
	return current_phase

func is_preparation_phase() -> bool:
	"""Verifica si estamos en fase de preparación"""
	return current_phase == Phase.PREPARATION

func is_combat_phase() -> bool:
	"""Verifica si estamos en fase de combate"""
	return current_phase == Phase.COMBAT

func is_interface_phase() -> bool:
	"""Verifica si estamos en fase de interfase"""
	return current_phase == Phase.INTERFACE

# ========== Sistema de Temporizador de Preparación ==========

func setup_preparation_timer():
	"""Configura el temporizador de preparación inicial (1 minuto)"""
	preparation_timer = Timer.new()
	preparation_timer.name = "PreparationTimer"
	preparation_timer.wait_time = PREPARATION_TIME
	preparation_timer.one_shot = true
	preparation_timer.timeout.connect(_on_preparation_timer_timeout)
	add_child(preparation_timer)

func setup_combat_timer():
	"""Configura el temporizador de combate (1 minuto por ronda)"""
	combat_timer = Timer.new()
	combat_timer.name = "CombatTimer"
	combat_timer.wait_time = COMBAT_TIME
	combat_timer.one_shot = true
	combat_timer.timeout.connect(_on_combat_timer_timeout)
	add_child(combat_timer)

func setup_interface_timer():
	"""Configura el temporizador de interfase entre rondas (30 segundos)"""
	interface_timer = Timer.new()
	interface_timer.name = "InterfaceTimer"
	interface_timer.wait_time = INTERFACE_TIME
	interface_timer.one_shot = true
	interface_timer.timeout.connect(_on_interface_timer_timeout)
	add_child(interface_timer)

func start_preparation_phase():
	"""Inicia la fase inicial de preparación (1 minuto) - solo al inicio del juego"""
	# Verificar si el juego ya terminó (victoria)
	if current_round > 5:
		print("Juego completado. No se puede iniciar más preparación.")
		return
	
	# Detener otros temporizadores si están corriendo
	if combat_timer and combat_timer.time_left > 0:
		combat_timer.stop()
		combat_time_remaining = 0.0
		combat_time_changed.emit(0.0)
	if interface_timer and interface_timer.time_left > 0:
		interface_timer.stop()
		interface_time_remaining = 0.0
		interface_time_changed.emit(0.0)
	
	current_phase = Phase.PREPARATION
	phase_changed.emit(current_phase)
	
	# Reiniciar y empezar el temporizador de preparación inicial
	preparation_time_remaining = PREPARATION_TIME
	preparation_timer.start()
	
	print("Fase de preparación inicial iniciada. Tienes ", PREPARATION_TIME, " segundos (1 minuto) para prepararte.")
	print("Ronda 1 comenzará automáticamente...")

func _on_preparation_timer_timeout():
	"""Se llama cuando el temporizador de preparación inicial termina"""
	# Verificar si el juego ya terminó (victoria)
	if current_round > 5:
		print("Juego completado. No se inicia más combate.")
		return
	
	print("Tiempo de preparación inicial terminado. Iniciando Ronda 1...")
	start_combat()

func get_preparation_time_remaining() -> float:
	"""Obtiene el tiempo restante de preparación"""
	if preparation_timer and preparation_timer.time_left > 0:
		preparation_time_remaining = preparation_timer.time_left
	return preparation_time_remaining

func get_combat_time_remaining() -> float:
	"""Obtiene el tiempo restante de combate"""
	if combat_timer and combat_timer.time_left > 0:
		combat_time_remaining = combat_timer.time_left
	return combat_time_remaining

func get_interface_time_remaining() -> float:
	"""Obtiene el tiempo restante de interfase"""
	if interface_timer and interface_timer.time_left > 0:
		interface_time_remaining = interface_timer.time_left
	return interface_time_remaining

func get_current_round_time_remaining() -> float:
	"""Obtiene el tiempo restante de la fase actual (preparación, combate o interfase)"""
	if current_phase == Phase.PREPARATION:
		return get_preparation_time_remaining()
	elif current_phase == Phase.COMBAT:
		return get_combat_time_remaining()
	elif current_phase == Phase.INTERFACE:
		return get_interface_time_remaining()
	return 0.0

func start_interface_phase():
	"""Inicia la fase de interfase (30 segundos entre rondas)"""
	# Verificar si el juego ya terminó (victoria)
	if current_round >= 5:
		print("Juego completado. No se puede iniciar más interfase.")
		return
	
	# Detener otros temporizadores si están corriendo
	if preparation_timer and preparation_timer.time_left > 0:
		preparation_timer.stop()
		preparation_time_remaining = 0.0
		preparation_time_changed.emit(0.0)
	if combat_timer and combat_timer.time_left > 0:
		combat_timer.stop()
		combat_time_remaining = 0.0
		combat_time_changed.emit(0.0)
	
	current_phase = Phase.INTERFACE
	phase_changed.emit(current_phase)
	
	# Reiniciar y empezar el temporizador de interfase
	interface_time_remaining = INTERFACE_TIME
	interface_timer.start()
	
	print("Interfase iniciada. Tienes ", INTERFACE_TIME, " segundos antes de la siguiente ronda.")

func _on_combat_timer_timeout():
	"""Se llama cuando el temporizador de combate termina"""
	# Si el combate termina por tiempo, se considera derrota
	print("Tiempo de combate terminado. Fin del combate...")
	# El combate debe terminar automáticamente (esto se manejará en CombatSystem)
	# Por ahora, si el tiempo se acaba, el combate termina automáticamente
	# El CombatSystem debería manejar esto cuando detecte que el tiempo se acabó

func _on_interface_timer_timeout():
	"""Se llama cuando el temporizador de interfase termina"""
	# Verificar si el juego ya terminó (victoria)
	if current_round >= 5:
		print("Juego completado. No se inicia más combate.")
		return
	
	print("Interfase terminada. Iniciando siguiente ronda...")
	# Iniciar nueva ronda (incrementa current_round) y fase de combate
	start_new_round()
	start_combat()

func _process(_delta):
	"""Actualiza el tiempo restante y emite señal para UI"""
	if current_phase == Phase.PREPARATION and preparation_timer:
		var time_left = preparation_timer.time_left
		if time_left != preparation_time_remaining:
			preparation_time_remaining = time_left
			preparation_time_changed.emit(preparation_time_remaining)
	elif current_phase == Phase.COMBAT and combat_timer:
		var time_left = combat_timer.time_left
		if time_left != combat_time_remaining:
			combat_time_remaining = time_left
			combat_time_changed.emit(combat_time_remaining)
	elif current_phase == Phase.INTERFACE and interface_timer:
		var time_left = interface_timer.time_left
		if time_left != interface_time_remaining:
			interface_time_remaining = time_left
			interface_time_changed.emit(interface_time_remaining)

