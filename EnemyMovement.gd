extends Node

var forest: int = MovementUtils.tiles.FOREST
var town: int = MovementUtils.tiles.TOWN 

func get_tile_without_enemies(unit, sides) -> Array:
	var unit_tile = unit.get_tile_position()
	var unit_neighbour_tiles: Dictionary = MovementUtils.get_neighbor_dictionary(unit)
	var tiles_without_enemies: Array = []
	tiles_without_enemies.append_array(sides)
	for enemy in GameVariables.enemies:
		var new_enemy_pos = enemy.get_tile_position()
		if enemy != unit:
			for side in sides:
				if unit_neighbour_tiles.get(side) == new_enemy_pos:
					tiles_without_enemies.erase(side)
	return tiles_without_enemies

func boar_movement_tile(boar: Boar):
	var enemy_tile = boar.get_tile_position()
	var neighbour_tiles = MovementUtils.get_neighbor_tiles(int(enemy_tile.x), int(enemy_tile.y))
	var neighbour_forest_tiles = []
	for side in MovementUtils.neighbour_tiles.size():
		if neighbour_tiles.get(side) == forest || neighbour_tiles.get(side) == town:
			neighbour_forest_tiles.append(side)
	get_tile_without_enemies(boar, neighbour_forest_tiles)
	neighbour_forest_tiles = get_tile_without_enemies(boar, neighbour_forest_tiles)
	return neighbour_forest_tiles[rand_range(0,neighbour_forest_tiles.size())]
