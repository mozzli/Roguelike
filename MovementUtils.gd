extends Node

enum tiles {PLAINS = 0, TOWN = 1, FOREST = 2, MOUNTAINS = 3}
enum tiles_mov_value {PLAINS = 1, FOREST = 2, MOUNTAINS = 5, TOWN = 1}
enum neighbour_tiles {UP_LEFT = 0, UP_RIGHT = 1, LEFT = 2, RIGHT = 3, DOWN_LEFT = 4, DOWN_RIGHT = 5}

var map
var map2

func get_neighbor_tiles(column, row, TileMap):
	var tiles_list = {
		MovementUtils.neighbour_tiles.UP_LEFT: null,
		neighbour_tiles.UP_RIGHT: null,
		neighbour_tiles.RIGHT: TileMap.get_cell(column + 1, row),
		neighbour_tiles.LEFT: TileMap.get_cell(column - 1, row),
		neighbour_tiles.DOWN_LEFT: null,
		neighbour_tiles.DOWN_RIGHT: null
	}
	if (row % 2 == 0):
		tiles_list[neighbour_tiles.UP_RIGHT] = TileMap.get_cell(column, row - 1)
		tiles_list[neighbour_tiles.UP_LEFT] = TileMap.get_cell(column - 1, row - 1)
		tiles_list[neighbour_tiles.DOWN_LEFT] = TileMap.get_cell(column - 1, row + 1)
		tiles_list[neighbour_tiles.DOWN_RIGHT] = TileMap.get_cell(column, row + 1)
	else:
		tiles_list[neighbour_tiles.UP_RIGHT] = TileMap.get_cell(column + 1, row - 1)
		tiles_list[neighbour_tiles.UP_LEFT] = TileMap.get_cell(column, row - 1)
		tiles_list[neighbour_tiles.DOWN_LEFT] = TileMap.get_cell(column, row + 1)
		tiles_list[neighbour_tiles.DOWN_RIGHT] = TileMap.get_cell(column + 1, row + 1)
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
		"UP_LEFT":
			if (even):
				new_column = -1
			new_row = -1
		"UP_RIGHT": 
			if (not even):
				new_column = 1
			new_row = -1
		"LEFT":
				new_column = -1
		"RIGHT":
			new_column = 1
		"DOWN_LEFT": 
			if (even):
				new_column = -1
			new_row = 1
		"DOWN_RIGHT":
			if (not even):
				new_column = 1
			new_row = 1
	return [new_column, new_row]
