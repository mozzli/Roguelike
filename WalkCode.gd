extends Node

var map = MovementUtils.map
var mouse_position

func _process(_delta):
	if(GameVariables.map_on == true):
		mouse_position = MovementUtils.map.world_to_map(GameVariables.current_map.get_global_mouse_position())

func get_movement_distance(placement, distance_value, direction):
	MovementUtils.map_tiles.set_cell(placement[0],placement[1],0)
	var last_tile = direction
	var new_tile
	for neighbour in MovementUtils.neighbour_tiles: 
		check_neighbour_tiles(neighbour, last_tile, placement, new_tile, distance_value)

func check_neighbour_tiles(neighbour, last_tile, placement, new_tile, distance_value):
	if (neighbour != get_last_used_tile(last_tile)):
		var even = check_if_even(placement[1])
		var coordinates = MovementUtils.get_new_movement_tile(neighbour, even)
		new_tile = [int(placement[0]) + coordinates[0], int(placement[1]) + coordinates[1]]
		var value_to_subtract = get_movement_subtract(MovementUtils.map.get_cell(new_tile[0], new_tile[1]))
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

func reset_movement_tiles():
	MovementUtils.map_tiles.clear()

func get_movement_subtract(new_tile_cell):
	if MovementUtils.RIVER_TILES.has(new_tile_cell):
		return MovementUtils.tiles_mov_value.RIVER
	match (new_tile_cell):
		MovementUtils.tiles.PLAINS: return MovementUtils.tiles_mov_value.PLAINS
		MovementUtils.tiles.FOREST: return MovementUtils.tiles_mov_value.FOREST
		MovementUtils.tiles.MOUNTAINS: return MovementUtils.tiles_mov_value.MOUNTAINS
		MovementUtils.tiles.WALL: return MovementUtils.tiles_mov_value.WALL
		_: return -1

func get_movement_cell():
	return MovementUtils.map_tiles.get_cell(WalkCode.mouse_position[0], WalkCode.mouse_position[1])
