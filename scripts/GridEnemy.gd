extends Node2D
class_name GridEnemy

## Grid del tablero enemigo (7×5 celdas)
## Visualización y gestión del grid superior

const CELL_SIZE = 100
const COLUMNS = 7
const ROWS = 5

# Referencia al contenedor de celdas (se crean dinámicamente)
var cells_container: Node2D
var background: Polygon2D

var cells: Array[Polygon2D] = []

func _ready():
	create_grid()

func create_grid():
	"""Crea el grid visual de 7×5 celdas"""
	# Crear fondo del grid
	if not background:
		background = Polygon2D.new()
		background.name = "Background"
		background.color = Color(1.0, 0.2, 0.2, 0.25)  # Rojo semitransparente
		var width = float(COLUMNS * CELL_SIZE)
		var height = float(ROWS * CELL_SIZE)
		background.polygon = PackedVector2Array([
			Vector2(-width / 2.0, -height / 2.0),
			Vector2(width / 2.0, -height / 2.0),
			Vector2(width / 2.0, height / 2.0),
			Vector2(-width / 2.0, height / 2.0)
		])
		add_child(background)
	
	# Crear contenedor de celdas si no existe
	if not cells_container:
		cells_container = Node2D.new()
		cells_container.name = "CellsContainer"
		add_child(cells_container)
	
	# Crear cada celda del grid
	for row in range(ROWS):
		for col in range(COLUMNS):
			create_cell(col, row)

func create_cell(col: int, row: int):
	"""Crea una celda individual en la posición (col, row)"""
	var cell = Polygon2D.new()
	cell.name = "Cell_%d_%d" % [col, row]
	
	# Tamaño y posición de la celda
	var x = (float(col) - float(COLUMNS) / 2.0 + 0.5) * float(CELL_SIZE)
	var y = (float(row) - float(ROWS) / 2.0 + 0.5) * float(CELL_SIZE)
	var pos = Vector2(x - float(CELL_SIZE) / 2.0, y - float(CELL_SIZE) / 2.0)
	
	# Crear polígono rectangular para la celda
	cell.color = Color(1.0, 0.3, 0.3, 0.1)  # Rojo muy transparente
	var cell_size_float = float(CELL_SIZE)
	cell.polygon = PackedVector2Array([
		pos,
		pos + Vector2(cell_size_float, 0),
		pos + Vector2(cell_size_float, cell_size_float),
		pos + Vector2(0, cell_size_float)
	])
	
	# Crear borde de la celda
	var border = create_cell_border(pos, Vector2(cell_size_float, cell_size_float))
	cells_container.add_child(border)
	
	cells_container.add_child(cell)
	cells.append(cell)

func create_cell_border(pos: Vector2, size: Vector2) -> Line2D:
	"""Crea el borde visual de una celda"""
	var border = Line2D.new()
	border.width = 2.0
	border.default_color = Color(1.0, 0.5, 0.5, 0.5)  # Rojo claro semitransparente
	
	# Crear rectángulo con líneas
	var points = PackedVector2Array([
		pos,
		pos + Vector2(size.x, 0),
		pos + size,
		pos + Vector2(0, size.y),
		pos  # Cerrar el rectángulo
	])
	border.points = points
	
	return border

func get_world_position(col: int, row: int) -> Vector2:
	"""Convierte coordenadas del grid (col, row) a posición mundial"""
	var x = (float(col) - float(COLUMNS) / 2.0 + 0.5) * float(CELL_SIZE)
	var y = (float(row) - float(ROWS) / 2.0 + 0.5) * float(CELL_SIZE)
	return global_position + Vector2(x, y)

func get_grid_position(world_pos: Vector2) -> Vector2i:
	"""Convierte posición mundial a coordenadas del grid"""
	var local_pos = to_local(world_pos)
	var col = int((local_pos.x / float(CELL_SIZE)) + float(COLUMNS) / 2.0)
	var row = int((local_pos.y / float(CELL_SIZE)) + float(ROWS) / 2.0)
	return Vector2i(clamp(col, 0, COLUMNS - 1), clamp(row, 0, ROWS - 1))

