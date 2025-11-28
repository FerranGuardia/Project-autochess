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

## Obtiene la ruta del tile del tablero completo
## @param tile_index: Índice del tile (1-108)
## @return: Ruta del archivo del tile
static func get_tile_path(tile_index: int) -> String:
	return "res://assets/sprites/arena/tiles/board/tile_board_%d.png" % tile_index

