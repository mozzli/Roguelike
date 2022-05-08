extends Node

func boar_movement_tile(boar):
	var enemy_tile = MovementUtils.map.world_to_map(boar.get_global_position())
	var neighbour_tiles = MovementUtils.get_neighbor_tiles(int(enemy_tile.x), int(enemy_tile.y))
	var neighbour_forest_tiles = []
	for side in MovementUtils.neighbour_tiles.size():
		if neighbour_tiles.get(side) == MovementUtils.tiles.FOREST || neighbour_tiles.get(side) == MovementUtils.tiles.TOWN :
			neighbour_forest_tiles.append(side)
	return neighbour_forest_tiles[rand_range(0,neighbour_forest_tiles.size())]
