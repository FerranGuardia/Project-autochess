extends Node
class_name TileVerification

## Script de verificación de tiles del tablero
## Ejecuta verificaciones para asegurar que los tiles se cargan correctamente

const BoardTileHelper = preload("res://scripts/BoardTileHelper.gd")

static func verify_tile_exists(tile_index: int) -> bool:
	"""Verifica si un tile específico existe"""
	var tile_path = BoardTileHelper.get_tile_path(tile_index)
	var exists = ResourceLoader.exists(tile_path)
	if exists:
		print("✓ Tile %d existe: %s" % [tile_index, tile_path])
	else:
		print("✗ Tile %d NO existe: %s" % [tile_index, tile_path])
	return exists

static func verify_all_tiles() -> Dictionary:
	"""Verifica todos los tiles del tablero y retorna estadísticas"""
	var results = {
		"total": BoardTileHelper.TOTAL_TILES,
		"found": 0,
		"missing": 0,
		"missing_tiles": []
	}
	
	var separator = "============================================================"
	print(separator)
	print("VERIFICACIÓN DE TILES DEL TABLERO")
	print(separator)
	
	for i in range(1, BoardTileHelper.TOTAL_TILES + 1):
		if verify_tile_exists(i):
			results.found += 1
		else:
			results.missing += 1
			results.missing_tiles.append(i)
	
	print(separator)
	print("RESUMEN:")
	print("  Total de tiles: %d" % results.total)
	print("  Tiles encontrados: %d" % results.found)
	print("  Tiles faltantes: %d" % results.missing)
	print(separator)
	
	return results

static func verify_specific_positions():
	"""Verifica tiles en posiciones específicas importantes"""
	var separator = "============================================================"
	print("\n" + separator)
	print("VERIFICACIÓN DE POSICIONES ESPECÍFICAS")
	print(separator)
	
	# Esquina superior izquierda (tile 1)
	print("\nEsquina superior izquierda:")
	verify_tile_exists(1)
	
	# Grid Enemigo (0,0) -> tile 11
	print("\nGrid Enemigo (0,0):")
	var enemy_tile = BoardTileHelper.get_enemy_tile_index(0, 0)
	print("  Índice calculado: %d" % enemy_tile)
	verify_tile_exists(enemy_tile)
	
	# Grid Aliado (0,0) -> tile 56
	print("\nGrid Aliado (0,0):")
	var ally_tile = BoardTileHelper.get_ally_tile_index(0, 0)
	print("  Índice calculado: %d" % ally_tile)
	verify_tile_exists(ally_tile)
	
	# Esquina inferior derecha (tile 108)
	print("\nEsquina inferior derecha:")
	verify_tile_exists(108)
	
	var separator = "============================================================"
	print(separator + "\n")

