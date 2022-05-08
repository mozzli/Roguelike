extends Node

enum tiles {PLAINS = 0,
 TOWN = 1,
 FOREST = 2,
 MOUNTAINS = 3,
 MOUNTAINS_WITH_RIVER = 4,
 WALL = 5,
 RIVER = 6,
 LAKE = 21}

enum tiles_mov_value {RIVER = 2,
 PLAINS = 1,
 FOREST = 2,
 MOUNTAINS = 3,
 MOUNTAINS_WITH_RIVER = 5,
 TOWN = 1,
 WALL = -1,
 LAKE = 2}

enum neighbour_tiles {UP_LEFT = 0, UP_RIGHT = 1, LEFT = 2, RIGHT = 3, DOWN_LEFT = 4, DOWN_RIGHT = 5}

var map
var map_tiles
const RIVER_TILES = []

func _ready():
	for i in range(6,20):
		RIVER_TILES.append(i)

func get_neighbor_tiles(column, row):
	var tiles_list = {
		MovementUtils.neighbour_tiles.UP_LEFT: null,
		neighbour_tiles.UP_RIGHT: null,
		neighbour_tiles.RIGHT: map.get_cell(column + 1, row),
		neighbour_tiles.LEFT: map.get_cell(column - 1, row),
		neighbour_tiles.DOWN_LEFT: null,
		neighbour_tiles.DOWN_RIGHT: null
	}
	if (row % 2 == 0):
		tiles_list[neighbour_tiles.UP_RIGHT] = map.get_cell(column, row - 1)
		tiles_list[neighbour_tiles.UP_LEFT] = map.get_cell(column - 1, row - 1)
		tiles_list[neighbour_tiles.DOWN_LEFT] = map.get_cell(column - 1, row + 1)
		tiles_list[neighbour_tiles.DOWN_RIGHT] = map.get_cell(column, row + 1)
	else:
		tiles_list[neighbour_tiles.UP_RIGHT] = map.get_cell(column + 1, row - 1)
		tiles_list[neighbour_tiles.UP_LEFT] = map.get_cell(column, row - 1)
		tiles_list[neighbour_tiles.DOWN_LEFT] = map.get_cell(column, row + 1)
		tiles_list[neighbour_tiles.DOWN_RIGHT] = map.get_cell(column + 1, row + 1)
	return tiles_list

func get_new_tile(free_tiles, random_free_tile, new_column, new_row):
	match free_tiles[random_free_tile]:
		neighbour_tiles.UP_LEFT:
			if (new_row % 2 == 0):
				new_column -= 1
			new_row -= 1
		neighbour_tiles.UP_RIGHT: 
			if (new_row % 2 != 0):
				new_column += 1
			new_row -= 1 
		neighbour_tiles.LEFT:
			new_column -= 1
		neighbour_tiles.RIGHT:
			new_column += 1
		neighbour_tiles.DOWN_LEFT: 
			if (new_row % 2 == 0):
				new_column -= 1
			new_row += 1
		neighbour_tiles.DOWN_RIGHT:
			if (new_row % 2 != 0):
				new_column += 1
			new_row += 1
	return [new_column, new_row]
	
func get_random_free_tile(neighbour_dictionary, column, row):
	var new_column = column
	var new_row = row 
	var free_tiles = []
	for key in neighbour_dictionary.size():
		if (neighbour_dictionary.get(key) == MovementUtils.tiles.PLAINS):
			free_tiles.append(key)
	if (free_tiles.size() != 0):
		var random_free_tile = randi() % free_tiles.size()
		return get_new_tile(free_tiles, random_free_tile, new_column, new_row)

func get_new_movement_tile(next_tile, even):
	var new_column = 0
	var new_row = 0
	match next_tile:
		neighbour_tiles.UP_LEFT:
			if (even): new_column = -1
			new_row = -1
		neighbour_tiles.UP_RIGHT: 
			if (not even): new_column = 1
			new_row = -1
		neighbour_tiles.LEFT:
			new_column = -1
		neighbour_tiles.RIGHT:
			new_column = 1
		neighbour_tiles.DOWN_LEFT: 
			if (even): new_column = -1
			new_row = 1
		neighbour_tiles.DOWN_RIGHT:
			if (not even): new_column = 1
			new_row = 1
	return [new_column, new_row]

func get_cell_in_position(position_of_next_tile, old_position):
	var cell_coordinates
	if (int(old_position.y)%2 == 0):
		cell_coordinates = get_new_movement_tile(position_of_next_tile,true)
	else:
		cell_coordinates = get_new_movement_tile(position_of_next_tile,false)
	return [old_position.x + cell_coordinates[0], old_position.y + cell_coordinates[1]]
