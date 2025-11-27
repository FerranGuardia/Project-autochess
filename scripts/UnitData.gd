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
		"sprite_path": "res://assets/sprites/units/mago_idle.png"
	},
	UnitType.ORCO: {
		"name": "Orco",
		"color": Color(0.9, 0.2, 0.2),  # Rojo
		"sprite_path": "res://assets/sprites/units/orco_idle.png"
	},
	UnitType.ELFO: {
		"name": "Elfo",
		"color": Color(0.2, 0.9, 0.4),  # Verde
		"sprite_path": "res://assets/sprites/units/elfo_idle.png"
	},
	UnitType.ENANO: {
		"name": "Enano",
		"color": Color(0.6, 0.4, 0.2),  # Marrón
		"sprite_path": "res://assets/sprites/units/enano_idle.png"
	},
	UnitType.BEASTKIN: {
		"name": "Beastkin",
		"color": Color(0.9, 0.9, 0.2),  # Amarillo
		"sprite_path": "res://assets/sprites/units/beastkin_idle.png"
	},
	UnitType.DEMONIO: {
		"name": "Demonio",
		"color": Color(0.9, 0.2, 0.7),  # Magenta
		"sprite_path": "res://assets/sprites/units/demonio_idle.png"
	}
}

static func get_unit_name(type: UnitType) -> String:
	return UNIT_INFO[type]["name"]

static func get_unit_color(type: UnitType) -> Color:
	return UNIT_INFO[type]["color"]

static func get_unit_sprite_path(type: UnitType) -> String:
	return UNIT_INFO[type]["sprite_path"]


