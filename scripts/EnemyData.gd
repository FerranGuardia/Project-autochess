extends Resource
class_name EnemyData

## Datos estáticos de los enemigos
## Define tipos, nombres, colores y rutas de sprites

enum EnemyType {
	GOBLIN_BOW,      # Goblin con arco (Ranged)
	GOBLIN_DAGGER,   # Goblin con daga (Mele)
	GOBLIN_SHIELD    # Goblin con espada y escudo (Tank)
}

# Datos de cada tipo de enemigo
static var ENEMY_INFO = {
	EnemyType.GOBLIN_BOW: {
		"name": "Goblin Arquero",
		"color": Color(0.2, 0.8, 0.2),  # Verde
		"sprite_path": "res://assets/sprites/units/goblinbow_idle.png",
		"role": "ranged",  # Ranged, mele, tank
		"health": 50,
		"attack": 15,
		"defense": 5,
		"attack_range": 3,
		"attack_speed": 1.5,
		"gold_reward": 1  # Oro que otorga al morir
	},
	EnemyType.GOBLIN_DAGGER: {
		"name": "Goblin Asesino",
		"color": Color(0.3, 0.7, 0.2),  # Verde oscuro
		"sprite_path": "res://assets/sprites/units/goblindagger_idle.png",
		"role": "mele",
		"health": 60,
		"attack": 20,
		"defense": 3,
		"attack_range": 1,
		"attack_speed": 2.0,
		"gold_reward": 2  # Oro que otorga al morir
	},
	EnemyType.GOBLIN_SHIELD: {
		"name": "Goblin Defensor",
		"color": Color(0.2, 0.6, 0.2),  # Verde más oscuro
		"sprite_path": "res://assets/sprites/units/goblinshield_idle.png",
		"role": "tank",
		"health": 100,
		"attack": 10,
		"defense": 10,
		"attack_range": 1,
		"attack_speed": 1.0,
		"gold_reward": 3  # Oro que otorga al morir
	}
}

static func get_enemy_name(type: EnemyType) -> String:
	return ENEMY_INFO[type]["name"]

static func get_enemy_color(type: EnemyType) -> Color:
	return ENEMY_INFO[type]["color"]

static func get_enemy_sprite_path(type: EnemyType) -> String:
	return ENEMY_INFO[type]["sprite_path"]

static func get_enemy_role(type: EnemyType) -> String:
	return ENEMY_INFO[type]["role"]

static func get_enemy_health(type: EnemyType) -> int:
	return ENEMY_INFO[type]["health"]

static func get_enemy_attack(type: EnemyType) -> int:
	return ENEMY_INFO[type]["attack"]

static func get_enemy_defense(type: EnemyType) -> int:
	return ENEMY_INFO[type]["defense"]

static func get_enemy_attack_range(type: EnemyType) -> int:
	return ENEMY_INFO[type]["attack_range"]

static func get_enemy_attack_speed(type: EnemyType) -> float:
	return ENEMY_INFO[type]["attack_speed"]

static func get_enemy_gold_reward(type: EnemyType) -> int:
	"""Obtiene el oro que otorga un enemigo al morir"""
	return ENEMY_INFO[type]["gold_reward"]

