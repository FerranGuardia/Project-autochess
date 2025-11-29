extends Node
class_name CombatSystem

## Sistema de combate
## Maneja movimiento y ataques de unidades durante el combate

# Referencias
var grid_ally: GridAlly = null
var grid_enemy: GridEnemy = null
var game_manager: GameManager = null

# Configuración de combate
const MOVE_SPEED: float = 200.0  # Píxeles por segundo
const ATTACK_COOLDOWN: float = 1.0  # Segundos entre ataques
const COMBAT_UPDATE_INTERVAL: float = 0.1  # Actualizar cada 0.1 segundos
const ENERGY_PER_ATTACK: int = 50  # Energía ganada por ataque (para llenar en ~2 segundos)

# Estado del combate
var is_combat_active: bool = false
var combat_timer: Timer = null

# Tracking de unidades en combate
var ally_units: Array[Unit] = []
var enemy_units: Array[Unit] = []

func _ready():
	# Crear timer para actualizar el combate
	combat_timer = Timer.new()
	combat_timer.name = "CombatTimer"
	combat_timer.wait_time = COMBAT_UPDATE_INTERVAL
	combat_timer.timeout.connect(_on_combat_tick)
	add_child(combat_timer)

func initialize(ally_grid: GridAlly, enemy_grid: GridEnemy, manager: GameManager):
	"""Inicializa el sistema de combate con referencias"""
	grid_ally = ally_grid
	grid_enemy = enemy_grid
	game_manager = manager

func start_combat():
	"""Inicia el combate"""
	if is_combat_active:
		return
	
	is_combat_active = true
	
	# Obtener todas las unidades vivas
	collect_combat_units()
	
	# Resetear energía de todas las unidades al inicio del combate
	reset_all_units_energy()
	
	# Conectar señales de muerte de enemigos para otorgar loot
	connect_unit_death_signals()
	
	# Iniciar el timer de combate
	combat_timer.start()

func connect_unit_death_signals():
	"""Conecta las señales de muerte de unidades para otorgar loot"""
	# Conectar muerte de enemigos
	for enemy in enemy_units:
		if is_instance_valid(enemy) and not enemy.unit_died.is_connected(_on_enemy_died):
			enemy.unit_died.connect(_on_enemy_died)

func _on_enemy_died(enemy: Unit):
	"""Se llama cuando un enemigo muere - otorgar loot"""
	if not enemy or not enemy.is_enemy:
		return
	
	# Otorgar loot a través del GridEnemy
	if grid_enemy and game_manager:
		grid_enemy.on_enemy_died(enemy)

func stop_combat():
	"""Detiene el combate"""
	is_combat_active = false
	combat_timer.stop()
	
	# Desconectar señales
	disconnect_unit_death_signals()
	
	# Limpiar referencias
	ally_units.clear()
	enemy_units.clear()

func disconnect_unit_death_signals():
	"""Desconecta las señales de muerte de unidades"""
	for enemy in enemy_units:
		if is_instance_valid(enemy) and enemy.unit_died.is_connected(_on_enemy_died):
			enemy.unit_died.disconnect(_on_enemy_died)

func collect_combat_units():
	"""Recopila todas las unidades vivas del combate"""
	ally_units.clear()
	enemy_units.clear()
	
	# Obtener unidades aliadas del grid
	if grid_ally:
		var all_ally_units = grid_ally.get_all_units()
		for unit in all_ally_units:
			if unit is Unit and unit.is_alive() and unit.get_grid_position().y >= 0:
				ally_units.append(unit)
	
	# Obtener unidades enemigas del grid
	if grid_enemy:
		var all_enemy_units = grid_enemy.get_all_enemies()
		for unit in all_enemy_units:
			if unit is Unit and unit.is_alive():
				enemy_units.append(unit)

func reset_all_units_energy():
	"""Resetea la energía de todas las unidades al inicio del combate"""
	# Resetear energía de unidades aliadas
	for unit in ally_units:
		if is_instance_valid(unit):
			unit.reset_energy()
	
	# Resetear energía de unidades enemigas
	for unit in enemy_units:
		if is_instance_valid(unit):
			unit.reset_energy()

func _on_combat_tick():
	"""Se llama periódicamente durante el combate"""
	if not is_combat_active:
		return
	
	# Verificar si el combate ha terminado
	if check_combat_end():
		return
	
	# Actualizar movimiento y ataques
	update_combat()

func update_combat():
	"""Actualiza el combate: movimiento y ataques"""
	# Actualizar unidades aliadas
	for unit in ally_units:
		if not is_instance_valid(unit) or not unit.is_alive():
			continue
		update_unit_combat(unit, enemy_units)
	
	# Actualizar unidades enemigas
	for unit in enemy_units:
		if not is_instance_valid(unit) or not unit.is_alive():
			continue
		update_unit_combat(unit, ally_units)

func update_unit_combat(unit: Unit, targets: Array[Unit]):
	"""Actualiza el combate de una unidad específica"""
	if targets.is_empty():
		return
	
	# Encontrar el objetivo más cercano
	var target = find_nearest_target(unit, targets)
	if not target:
		return
	
	# Obtener rango de ataque
	var attack_range = get_unit_attack_range(unit)
	
	# Calcular distancia al objetivo
	var distance = get_distance_to_target(unit, target)
	
	# Si está en rango, atacar
	if distance <= attack_range:
		attack_target(unit, target)
	else:
		# Si no está en rango, moverse hacia el objetivo
		move_towards_target(unit, target)

func find_nearest_target(unit: Unit, targets: Array[Unit]) -> Unit:
	"""Encuentra el objetivo más cercano"""
	if targets.is_empty():
		return null
	
	var nearest_target: Unit = null
	var nearest_distance: float = INF
	
	for target in targets:
		if not is_instance_valid(target) or not target.is_alive():
			continue
		
		var distance = get_distance_to_target(unit, target)
		if distance < nearest_distance:
			nearest_distance = distance
			nearest_target = target
	
	return nearest_target

func get_distance_to_target(unit: Unit, target: Unit) -> float:
	"""Calcula la distancia entre dos unidades"""
	if not unit or not target:
		return INF
	
	if not is_instance_valid(unit) or not is_instance_valid(target):
		return INF
	
	var unit_pos = unit.global_position
	var target_pos = target.global_position
	return unit_pos.distance_to(target_pos)

func get_unit_attack_range(unit: Unit) -> float:
	"""Obtiene el rango de ataque de una unidad en píxeles"""
	if not unit:
		return 0.0
	
	var range_in_cells: int = 0
	
	if unit.is_enemy:
		range_in_cells = EnemyData.get_enemy_attack_range(unit.enemy_type)
	else:
		range_in_cells = UnitData.get_unit_attack_range(unit.unit_type)
	
	# Convertir celdas a píxeles (cada celda es 100px)
	return float(range_in_cells) * 100.0

func move_towards_target(unit: Unit, target: Unit):
	"""Mueve la unidad hacia el objetivo"""
	if not unit or not target:
		return
	
	if not is_instance_valid(unit) or not is_instance_valid(target):
		return
	
	var unit_pos = unit.global_position
	var target_pos = target.global_position
	
	# Calcular dirección
	var direction = (target_pos - unit_pos).normalized()
	
	# Mover la unidad
	var move_distance = MOVE_SPEED * COMBAT_UPDATE_INTERVAL
	unit.global_position += direction * move_distance
	
	# Actualizar posición del grid si es necesario
	update_unit_grid_position(unit)

func update_unit_grid_position(unit: Unit):
	"""Actualiza la posición del grid de una unidad basándose en su posición mundial"""
	if not unit or not is_instance_valid(unit):
		return
	
	# Solo actualizar si la unidad está en el grid (no en el banquillo)
	var current_pos = unit.get_grid_position()
	if current_pos.y < 0:  # Está en el banquillo
		return
	
	# Determinar en qué grid está la unidad
	# No necesitamos la variable grid, usamos directamente grid_ally o grid_enemy
	
	# Convertir posición mundial a posición del grid
	var grid_pos: Vector2i = Vector2i(-1, -1)
	if unit.is_enemy:
		if grid_enemy:
			grid_pos = grid_enemy.get_grid_position(unit.global_position)
		else:
			return
	else:
		if grid_ally:
			grid_pos = grid_ally.get_grid_position(unit.global_position)
		else:
			return
	
	# Solo actualizar si la posición cambió significativamente (más de media celda)
	if grid_pos.x >= 0 and grid_pos.y >= 0:
		var distance = Vector2(current_pos).distance_to(Vector2(grid_pos))
		if distance > 0.5:  # Solo actualizar si se movió más de media celda
			# Verificar si la celda está libre o es la misma unidad
			var existing_unit: Unit = null
			if unit.is_enemy:
				existing_unit = grid_enemy.get_enemy_at(grid_pos.x, grid_pos.y)
			else:
				existing_unit = grid_ally.get_unit_at(grid_pos.x, grid_pos.y)
			
			if not existing_unit or existing_unit == unit:
				# Mover la unidad en el grid
				if unit.is_enemy:
					grid_enemy.remove_enemy(unit, false)
					grid_enemy.place_enemy(unit, grid_pos.x, grid_pos.y)
				else:
					grid_ally.remove_unit(unit)
					grid_ally.place_unit(unit, grid_pos.x, grid_pos.y)

# Tracking de cooldowns de ataque
var attack_cooldowns: Dictionary = {}  # Key: Unit, Value: float (tiempo restante)

func attack_target(unit: Unit, target: Unit):
	"""Ataca al objetivo"""
	if not unit or not target or not target.is_alive():
		return
	
	# Verificar cooldown de ataque
	var unit_id = unit.get_instance_id()
	if attack_cooldowns.has(unit_id):
		var cooldown = attack_cooldowns[unit_id]
		if cooldown > 0:
			attack_cooldowns[unit_id] = cooldown - COMBAT_UPDATE_INTERVAL
			return
	
	# Calcular daño
	var damage = get_unit_attack(unit)
	var defense = get_unit_defense(target)
	
	# Aplicar daño (daño - defensa, mínimo 1)
	var final_damage = max(1, damage - defense)
	
	# Aplicar daño al objetivo
	target.take_damage(final_damage)
	
	# Cargar energía por ataque
	unit.gain_energy(ENERGY_PER_ATTACK)
	
	# Establecer cooldown
	attack_cooldowns[unit_id] = ATTACK_COOLDOWN

func get_unit_attack(unit: Unit) -> int:
	"""Obtiene el ataque de una unidad"""
	if not unit:
		return 0
	
	if unit.is_enemy:
		return EnemyData.get_enemy_attack(unit.enemy_type)
	else:
		return UnitData.get_unit_attack(unit.unit_type)

func get_unit_defense(unit: Unit) -> int:
	"""Obtiene la defensa de una unidad"""
	if not unit:
		return 0
	
	if unit.is_enemy:
		return EnemyData.get_enemy_defense(unit.enemy_type)
	else:
		return UnitData.get_unit_defense(unit.unit_type)

func check_combat_end() -> bool:
	"""Verifica si el combate ha terminado"""
	# Remover unidades muertas
	var valid_allies: Array[Unit] = []
	for u in ally_units:
		if is_instance_valid(u) and u.is_alive():
			valid_allies.append(u)
	ally_units = valid_allies
	
	var valid_enemies: Array[Unit] = []
	for u in enemy_units:
		if is_instance_valid(u) and u.is_alive():
			valid_enemies.append(u)
	enemy_units = valid_enemies
	
	# Verificar condiciones de fin
	var allies_alive = ally_units.size() > 0
	var enemies_alive = enemy_units.size() > 0
	
	if not allies_alive:
		# Derrota: no quedan aliados
		end_combat(false)
		return true
	elif not enemies_alive:
		# Victoria: no quedan enemigos
		end_combat(true)
		return true
	
	return false

func end_combat(victory: bool):
	"""Termina el combate"""
	stop_combat()
	
	# Limpiar cooldowns
	attack_cooldowns.clear()
	
	# Notificar al GameManager
	if game_manager:
		game_manager.end_combat(victory)

