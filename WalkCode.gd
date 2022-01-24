extends Node

var map = MovementUtils.map

func get_movement_distance(placement):
	var current_placement = map.world_to_map(placement)
	print(current_placement)

func change_position(newPosition):
	var tile_placement = map.world_to_map(newPosition)
	return map.map_to_world(tile_placement) + Vector2(32,32)
