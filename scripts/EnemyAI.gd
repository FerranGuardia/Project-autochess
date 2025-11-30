extends Node
class_name EnemyAI

## Sistema de IA predefinida para enemigos
## Define composiciones fijas por ronda y coloca unidades enemigas

# Referencias
var grid_enemy: GridEnemy = null
var board: Node = null  # Board, pero usamos Node para evitar problemas de tipos

# Composiciones por ronda
# Cada ronda tiene una lista de enemigos: [tipo, col, row]
# Si col/row son -1, se coloca automáticamente en una posición libre
# Diseño progresivo de dificultad:
# - Ronda 1: Introducción simple (3 enemigos: 1 arquero, 2 asesinos)
# - Ronda 2: Aumento de cantidad (4 enemigos: 2 arqueros, 2 asesinos)
# - Ronda 3: Introducción del tanque (5 enemigos: 1 tanque, 2 arqueros, 2 asesinos)
# - Ronda 4: Más tanques (6 enemigos: 2 tanques, 2 arqueros, 2 asesinos)
# - Ronda 5: Desafío completo (7 enemigos: 3 tanques, 2 arqueros, 2 asesinos)
var round_compositions = {
	1: [
		# Ronda 1: Oleada simple - 1 arquero + 2 asesinos
		{"type": EnemyData.EnemyType.GOBLIN_BOW, "col": 3, "row": 0},      # Arquero central
		{"type": EnemyData.EnemyType.GOBLIN_DAGGER, "col": 2, "row": 1},   # Asesino izquierda
		{"type": EnemyData.EnemyType.GOBLIN_DAGGER, "col": 4, "row": 1}    # Asesino derecha
	],
	2: [
		# Ronda 2: Oleada doble - 2 arqueros + 2 asesinos
		{"type": EnemyData.EnemyType.GOBLIN_BOW, "col": 2, "row": 0},      # Arquero izquierda
		{"type": EnemyData.EnemyType.GOBLIN_BOW, "col": 4, "row": 0},      # Arquero derecha
		{"type": EnemyData.EnemyType.GOBLIN_DAGGER, "col": 1, "row": 1},   # Asesino izquierda
		{"type": EnemyData.EnemyType.GOBLIN_DAGGER, "col": 5, "row": 1}    # Asesino derecha
	],
	3: [
		# Ronda 3: Primera oleada con tanque - 1 tanque + 2 arqueros + 2 asesinos
		{"type": EnemyData.EnemyType.GOBLIN_SHIELD, "col": 3, "row": 0},   # Tanque central (frente)
		{"type": EnemyData.EnemyType.GOBLIN_BOW, "col": 2, "row": 0},      # Arquero izquierda
		{"type": EnemyData.EnemyType.GOBLIN_BOW, "col": 4, "row": 0},      # Arquero derecha
		{"type": EnemyData.EnemyType.GOBLIN_DAGGER, "col": 1, "row": 1},   # Asesino izquierda
		{"type": EnemyData.EnemyType.GOBLIN_DAGGER, "col": 5, "row": 1}    # Asesino derecha
	],
	4: [
		# Ronda 4: Oleada con doble tanque - 2 tanques + 2 arqueros + 2 asesinos
		{"type": EnemyData.EnemyType.GOBLIN_SHIELD, "col": 2, "row": 0},   # Tanque izquierda
		{"type": EnemyData.EnemyType.GOBLIN_SHIELD, "col": 4, "row": 0},   # Tanque derecha
		{"type": EnemyData.EnemyType.GOBLIN_BOW, "col": 1, "row": 0},      # Arquero izquierda
		{"type": EnemyData.EnemyType.GOBLIN_BOW, "col": 5, "row": 0},      # Arquero derecha
		{"type": EnemyData.EnemyType.GOBLIN_DAGGER, "col": 3, "row": 1},   # Asesino central
		{"type": EnemyData.EnemyType.GOBLIN_DAGGER, "col": 0, "row": 1}    # Asesino izquierda
	],
	5: [
		# Ronda 5: Oleada completa - 3 tanques + 2 arqueros + 2 asesinos
		{"type": EnemyData.EnemyType.GOBLIN_SHIELD, "col": 1, "row": 0},   # Tanque izquierda
		{"type": EnemyData.EnemyType.GOBLIN_SHIELD, "col": 3, "row": 0},   # Tanque central
		{"type": EnemyData.EnemyType.GOBLIN_SHIELD, "col": 5, "row": 0},   # Tanque derecha
		{"type": EnemyData.EnemyType.GOBLIN_BOW, "col": 0, "row": 0},      # Arquero izquierda
		{"type": EnemyData.EnemyType.GOBLIN_BOW, "col": 6, "row": 0},      # Arquero derecha
		{"type": EnemyData.EnemyType.GOBLIN_DAGGER, "col": 2, "row": 1},   # Asesino izquierda
		{"type": EnemyData.EnemyType.GOBLIN_DAGGER, "col": 4, "row": 1}    # Asesino derecha
	]
}

func initialize(grid: GridEnemy, board_ref: Node = null):
	"""Inicializa el sistema de IA con referencias"""
	grid_enemy = grid
	board = board_ref

func spawn_enemies_for_round(round_number: int):
	"""Coloca enemigos según la composición de la ronda"""
	if not grid_enemy:
		print("Error: GridEnemy no está inicializado")
		return
	
	# Limpiar enemigos anteriores
	grid_enemy.clear_all_enemies()
	
	# Obtener composición de la ronda
	var composition = get_round_composition(round_number)
	
	if composition.is_empty():
		print("No hay composición definida para la ronda ", round_number)
		return
	
	# Colocar cada enemigo
	for enemy_data in composition:
		var enemy_type = enemy_data["type"]
		var col = enemy_data.get("col", -1)
		var row = enemy_data.get("row", -1)
		
		# Si no se especifica posición, encontrar una libre
		if col < 0 or row < 0:
			var free_pos = find_free_position()
			if free_pos.x < 0:
				print("No hay espacio para más enemigos")
				continue
			col = free_pos.x
			row = free_pos.y
		
		# Crear y colocar el enemigo
		create_and_place_enemy(enemy_type, col, row)
	
	print("Enemigos colocados para la ronda ", round_number, ": ", composition.size())

func get_round_composition(round_number: int) -> Array:
	"""Obtiene la composición de enemigos para una ronda"""
	# Si hay una composición específica, usarla
	if round_compositions.has(round_number):
		return round_compositions[round_number]
	
	# Si la ronda es mayor que las definidas, escalar la última composición
	var max_round = round_compositions.keys().max()
	if round_number > max_round:
		# Usar la composición de la última ronda y agregar más enemigos
		var base_composition = round_compositions[max_round].duplicate()
		# Agregar enemigos adicionales según la ronda
		var additional_enemies = round_number - max_round
		for _i in range(additional_enemies):
			# Agregar un enemigo aleatorio en posición libre
			var enemy_types = [EnemyData.EnemyType.GOBLIN_BOW, EnemyData.EnemyType.GOBLIN_DAGGER, EnemyData.EnemyType.GOBLIN_SHIELD]
			var random_type = enemy_types[randi() % enemy_types.size()]
			base_composition.append({"type": random_type, "col": -1, "row": -1})
		return base_composition
	
	# Ronda 1 por defecto
	return round_compositions[1]

func create_and_place_enemy(enemy_type: EnemyData.EnemyType, col: int, row: int) -> Unit:
	"""Crea un enemigo y lo coloca en el grid"""
	if not grid_enemy:
		return null
	
	# Crear unidad enemiga (reutilizamos Unit para enemigos también)
	var enemy = Unit.new()
	
	# Convertir EnemyType a UnitType temporalmente (necesitamos ajustar esto)
	# Por ahora, vamos a crear un sistema que funcione con Unit pero usando EnemyData
	# Necesitamos modificar Unit para que acepte EnemyType también, o crear una clase Enemy
	# Por simplicidad, vamos a crear enemigos como unidades pero con datos de EnemyData
	
	# Crear el enemigo usando Unit pero con datos de EnemyData
	# Necesitamos una forma de inicializar Unit con EnemyType
	# Por ahora, vamos a hacer que Unit pueda inicializarse con EnemyType también
	
	# Inicializar el enemigo (necesitamos modificar Unit.initialize para aceptar EnemyType)
	# Por ahora, vamos a crear una función helper aquí
	initialize_enemy_unit(enemy, enemy_type)
	
	# Colocar en el grid
	if grid_enemy.place_enemy(enemy, col, row):
		print("Enemigo ", EnemyData.get_enemy_name(enemy_type), " colocado en (", col, ", ", row, ")")
		return enemy
	else:
		enemy.queue_free()
		return null

func initialize_enemy_unit(unit: Unit, enemy_type: EnemyData.EnemyType):
	"""Inicializa una unidad como enemigo usando EnemyData"""
	unit.initialize_enemy(enemy_type)

func find_free_position() -> Vector2i:
	"""Encuentra una posición libre en el grid enemigo"""
	if not grid_enemy:
		return Vector2i(-1, -1)
	
	# Buscar desde el centro hacia afuera
	var center_col = int(float(grid_enemy.COLUMNS) / 2.0)
	var center_row = int(float(grid_enemy.ROWS) / 2.0)
	
	# Buscar en espiral desde el centro
	for radius in range(max(grid_enemy.COLUMNS, grid_enemy.ROWS)):
		for col in range(max(0, center_col - radius), min(grid_enemy.COLUMNS, center_col + radius + 1)):
			for row in range(max(0, center_row - radius), min(grid_enemy.ROWS, center_row + radius + 1)):
				if not grid_enemy.is_cell_occupied(col, row):
					return Vector2i(col, row)
	
	return Vector2i(-1, -1)

