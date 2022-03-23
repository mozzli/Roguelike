extends Node

var map = MovementUtils.map
var mouse_position

func get_movement_distance(placement, distance_value, direction):
	MovementUtils.map2.set_cell(placement[0],placement[1],0)
	var last_tile = direction
	var new_tile
	for neighbour in MovementUtils.neighbour_tiles: 
		if (neighbour != get_last_used_tile(last_tile)):
			var even = check_if_even(placement[1])
			var coordinates = MovementUtils.get_new_movement_tile(neighbour, even)
			new_tile = [int(placement[0]) + coordinates[0], int(placement[1]) + coordinates[1]]
			var value_to_subtract = get_movement_subtract(MovementUtils.map.get_cell(new_tile[0], new_tile[1]))
			if (!value_to_subtract == -1 && distance_value - value_to_subtract>=0 ):
#			print(placement, "||", neighbour, ": ", value_to_subtract, " || ", distance_value - value_to_subtract)
				if (!value_to_subtract == -1 && distance_value - value_to_subtract >= 0 ):
					get_movement_distance(new_tile, distance_value - value_to_subtract, neighbour)

func change_position(newPosition):
	var tile_placement = map.world_to_map(newPosition)
	return map.map_to_world(tile_placement) + Vector2(32,32)

func get_last_used_tile(last_used_tile):
	match last_used_tile:
		"DOWN_LEFT": return "UP_RIGHT"
		"DOWN_RIGHT": return "UP_LEFT"
		"UP_LEFT": return "DOWN_RIGHT"
		"UP_RIGHT": return "DOWN_LEFT"
		"LEFT": return "RIGHT"
		"RIGHT": return "LEFT"
	
func check_if_even(row):
	return int(row) % 2 == 0

func reset_movement():
	MovementUtils.map2.clear()

func get_movement_subtract(new_tile_cell):
	match (new_tile_cell):
		0: return 1
		2: return 2
		3: return 3
		-1: return -1

func _process(_delta):
	if(GameVariables.map_on == true):
		mouse_position = MovementUtils.map.world_to_map(GameVariables.current_map.get_global_mouse_position())

func get_movement_cell():
	return MovementUtils.map2.get_cell(WalkCode.mouse_position[0], WalkCode.mouse_position[1])
