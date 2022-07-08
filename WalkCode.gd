extends Node2D

var map = MovementUtils.map
var mouse_position

func _process(_delta):
	if(GameVariables.map_on && !GameVariables.gui_is_on):
		mouse_position = MovementUtils.map.world_to_map(GameVariables.current_map.get_global_mouse_position())
		GameVariables.current_map.get_node("SelectedTile").global_position = MovementUtils.map.map_to_world(mouse_position) + Vector2(31,23)

func get_movement_distance(placement, distance_value, direction):
	MovementUtils.movement_tiles.set_cell(placement[0],placement[1],0)
	var last_tile = direction
	for neighbour in MovementUtils.neighbour_tiles: 
		check_neighbour_tiles(neighbour, last_tile, placement, distance_value)

func check_neighbour_tiles(neighbour, last_tile, placement, distance_value):
	if (neighbour != get_last_used_tile(last_tile)):
		var even = check_if_even(placement[1])
		var coordinates = MovementUtils.get_new_movement_tile(tile_string_to_tile(neighbour), even)
		var new_tile = [int(placement[0]) + coordinates[0], int(placement[1]) + coordinates[1]]
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

func tile_string_to_tile(tile_str):
	match tile_str:
		"DOWN_LEFT": return MovementUtils.neighbour_tiles.DOWN_LEFT
		"DOWN_RIGHT": return MovementUtils.neighbour_tiles.DOWN_RIGHT
		"UP_LEFT": return MovementUtils.neighbour_tiles.UP_LEFT
		"UP_RIGHT": return MovementUtils.neighbour_tiles.UP_RIGHT
		"LEFT": return MovementUtils.neighbour_tiles.LEFT
		"RIGHT": return MovementUtils.neighbour_tiles.RIGHT
		

func check_if_even(row: int):
	return row% 2 == 0

func reset_movement_tiles():
	MovementUtils.movement_tiles.clear()

func get_movement_subtract(new_tile_cell):
	if MovementUtils.RIVER_TILES.has(new_tile_cell):
		return MovementUtils.tiles_mov_value.RIVER
	match (new_tile_cell):
		MovementUtils.tiles.PLAINS: return MovementUtils.tiles_mov_value.PLAINS
		MovementUtils.tiles.FOREST: return MovementUtils.tiles_mov_value.FOREST
		MovementUtils.tiles.MOUNTAINS: return MovementUtils.tiles_mov_value.MOUNTAINS
		MovementUtils.tiles.WALL: return MovementUtils.tiles_mov_value.WALL
		MovementUtils.tiles.TOWN: return MovementUtils.tiles_mov_value.TOWN
		MovementUtils.tiles.LAKE: return MovementUtils.tiles_mov_value.LAKE
		_: return -1

func get_movement_cell():
	return MovementUtils.movement_tiles.get_cell(WalkCode.mouse_position[0], WalkCode.mouse_position[1])
