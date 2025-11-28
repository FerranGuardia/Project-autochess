extends Resource
class_name UnitData

## Datos estáticos de las unidades
## Define tipos, nombres, colores y rutas de sprites

enum UnitType {
	MAGO,
	ORCO,
	ELFO,
	ENANO,
	BEASTKIN,
	DEMONIO
}

# Datos de cada tipo de unidad
static var UNIT_INFO = {
	UnitType.MAGO: {
		"name": "Mago",
		"color": Color(0.2, 0.4, 0.9),  # Azul
		"sprite_path": "res://assets/sprites/units/mago_idle.png",
		"health": 60,  # Salud base
		"attack": 20,
		"defense": 5,
		"attack_range": 3,
		"attack_speed": 1.2
	},
	UnitType.ORCO: {
		"name": "Orco",
		"color": Color(0.9, 0.2, 0.2),  # Rojo
		"sprite_path": "res://assets/sprites/units/orco_idle.png",
		"health": 100,  # Tanque
		"attack": 15,
		"defense": 10,
		"attack_range": 1,
		"attack_speed": 1.0
	},
	UnitType.ELFO: {
		"name": "Elfo",
		"color": Color(0.2, 0.9, 0.4),  # Verde
		"sprite_path": "res://assets/sprites/units/elfo_idle.png",
		"health": 50,  # Ranged
		"attack": 18,
		"defense": 4,
		"attack_range": 3,
		"attack_speed": 1.5
	},
	UnitType.ENANO: {
		"name": "Enano",
		"color": Color(0.6, 0.4, 0.2),  # Marrón
		"sprite_path": "res://assets/sprites/units/enano_idle.png",
		"health": 80,  # Mele
		"attack": 22,
		"defense": 8,
		"attack_range": 1,
		"attack_speed": 1.8
	},
	UnitType.BEASTKIN: {
		"name": "Beastkin",
		"color": Color(0.9, 0.9, 0.2),  # Amarillo
		"sprite_path": "res://assets/sprites/units/beastkin_idle.png",
		"health": 70,  # Mele rápido
		"attack": 19,
		"defense": 6,
		"attack_range": 1,
		"attack_speed": 2.0
	},
	UnitType.DEMONIO: {
		"name": "Demonio",
		"color": Color(0.9, 0.2, 0.7),  # Magenta
		"sprite_path": "res://assets/sprites/units/demonio_idle.png",
		"health": 90,  # Tanque/DPS
		"attack": 25,
		"defense": 7,
		"attack_range": 2,
		"attack_speed": 1.3
	}
}

static func get_unit_name(type: UnitType) -> String:
	return UNIT_INFO[type]["name"]

static func get_unit_color(type: UnitType) -> Color:
	return UNIT_INFO[type]["color"]

static func get_unit_sprite_path(type: UnitType) -> String:
	return UNIT_INFO[type]["sprite_path"]

static func get_unit_health(type: UnitType) -> int:
	"""Obtiene la salud máxima de una unidad"""
	return UNIT_INFO[type]["health"]

static func get_unit_attack(type: UnitType) -> int:
	"""Obtiene el ataque de una unidad"""
	return UNIT_INFO[type]["attack"]

static func get_unit_defense(type: UnitType) -> int:
	"""Obtiene la defensa de una unidad"""
	return UNIT_INFO[type]["defense"]

static func get_unit_attack_range(type: UnitType) -> int:
	"""Obtiene el rango de ataque de una unidad"""
	return UNIT_INFO[type]["attack_range"]

static func get_unit_attack_speed(type: UnitType) -> float:
	"""Obtiene la velocidad de ataque de una unidad"""
	return UNIT_INFO[type]["attack_speed"]





