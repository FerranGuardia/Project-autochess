extends RefCounted
class_name BoardTileHelper

## Helper para calcular índices de tiles del tablero completo
## El tablero completo es 9 columnas × 12 filas = 108 tiles
## Numeración: tile_board_1.png a tile_board_108.png
## Orden: izquierda a derecha, arriba a abajo

const BOARD_COLUMNS = 9
const BOARD_ROWS = 12
const TOTAL_TILES = 108

## Calcula el índice del tile del tablero completo (1-108) para una posición del grid enemigo
## @param grid_col: Columna en el grid enemigo (0-6)
## @param grid_row: Fila en el grid enemigo (0-4)
## @return: Índice del tile (1-108)
static func get_enemy_tile_index(grid_col: int, grid_row: int) -> int:
	# Grid enemigo está en las filas 1-5 del tablero completo (0-indexed)
	# Columnas 1-7 del tablero completo (0-indexed)
	var board_row = grid_row + 1
	var board_col = grid_col + 1
	return (board_row * BOARD_COLUMNS) + board_col + 1

## Calcula el índice del tile del tablero completo (1-108) para una posición del grid aliado
## @param grid_col: Columna en el grid aliado (0-6)
## @param grid_row: Fila en el grid aliado (0-4)
## @return: Índice del tile (1-108)
static func get_ally_tile_index(grid_col: int, grid_row: int) -> int:
	# Grid aliado está en las filas 6-10 del tablero completo (0-indexed)
	# Columnas 1-7 del tablero completo (0-indexed)
	var board_row = grid_row + 6
	var board_col = grid_col + 1
	return (board_row * BOARD_COLUMNS) + board_col + 1

## Calcula el índice del tile del tablero completo (1-108) para una posición del borde decorativo
## @param board_col: Columna en el tablero completo (0-8)
## @param board_row: Fila en el tablero completo (0-11)
## @return: Índice del tile (1-108)
static func get_border_tile_index(board_col: int, board_row: int) -> int:
	return (board_row * BOARD_COLUMNS) + board_col + 1

## Determina si un tile es de borde o de combate
## @param tile_index: Índice del tile (1-108)
## @return: true si es borde, false si es combate
static func is_border_tile(tile_index: int) -> bool:
	# Calcular posición en el tablero (0-indexed)
	var board_row = (tile_index - 1) / BOARD_COLUMNS
	var board_col = (tile_index - 1) % BOARD_COLUMNS
	
	# Es borde si está en:
	# - Fila 0 (superior): tiles 1-9
	# - Fila 11 (inferior): tiles 100-108
	# - Columna 0 (izquierda): tiles 10, 19, 28, 37, 46, 55, 64, 73, 82, 91
	# - Columna 8 (derecha): tiles 18, 27, 36, 45, 54, 63, 72, 81, 90, 99
	if board_row == 0 or board_row == 11:
		return true
	if board_col == 0 or board_col == 8:
		return true
	return false

## Obtiene la ruta del tile del tablero completo
## Usa solo dos sprites base: tile_board_borde.png para bordes y tile_board_combat.png para combate
## @param tile_index: Índice del tile (1-108)
## @return: Ruta del archivo del tile
static func get_tile_path(tile_index: int) -> String:
	if is_border_tile(tile_index):
		return "res://assets/sprites/arena/tiles/board/tile_board_borde.png"
	else:
		return "res://assets/sprites/arena/tiles/board/tile_board_combat.png"

