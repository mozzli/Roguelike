extends Node

enum sides {
ULEFT = 0,
URIGHT = 1,
LEFT = 2,
RIGHT = 3,
DLEFT = 4,
DRIGHT = 5,
}

enum tiles {
ULEFT_URIGHT = 20, 
URIGHT_LEFT = 19, 
ULEFT_RIGHT = 18,
URIGHT_RIGHT = 17,
RIGHT_DRIGHT = 16,
ULEFT_LEFT = 15,
LEFT_DRIGHT = 14,
LEFT_RIGHT = 13,
LEFT_DLEFT = 12,
DLEFT_DRIGHT = 11,
DLEFT_RIGHT = 10,
URIGHT_DRIGHT = 9,
ULEFT_DRIGHT = 8,
URIGHT_DLEFT = 7,
ULEFT_DLEFT = 6 }

var river_sides = {tiles.ULEFT_URIGHT : [sides.ULEFT, sides.URIGHT],
tiles.URIGHT_LEFT : [sides.URIGHT, sides.LEFT],
tiles.ULEFT_RIGHT : [sides.ULEFT, sides.RIGHT],
tiles.URIGHT_RIGHT : [sides.URIGHT, sides.RIGHT],
tiles.RIGHT_DRIGHT : [sides.RIGHT, sides.DRIGHT],
tiles.ULEFT_LEFT : [sides.ULEFT, sides.LEFT],
tiles.LEFT_DRIGHT : [sides.LEFT, sides.DRIGHT],
tiles.LEFT_RIGHT : [sides.LEFT, sides.RIGHT],
tiles.LEFT_DLEFT : [sides.LEFT, sides.DLEFT],
tiles.DLEFT_DRIGHT : [sides.DLEFT, sides.DRIGHT],
tiles.DLEFT_RIGHT : [sides.DLEFT, sides.RIGHT],
tiles.URIGHT_DRIGHT : [sides.URIGHT, sides.DRIGHT],
tiles.ULEFT_DRIGHT : [sides.ULEFT, sides.DRIGHT],
tiles.URIGHT_DLEFT : [sides.URIGHT, sides.DLEFT],
tiles.ULEFT_DLEFT : [sides.ULEFT, sides.DLEFT]
}

func get_river_ending(river_tile,river_start_side):
	var tile_sides = get_river_tile_sides(river_tile)
	for side in tile_sides:
		if (side != river_start_side):
			return side 


func get_random_matching_tile(expand_direction):
	var matching_tiles = []
	var starting_side = get_opposite_river_side(expand_direction)
	for number_of_tile in range(6,20):
		if (get_river_tile_sides(number_of_tile).has(starting_side)):
			matching_tiles.append(number_of_tile)
	var new_tile = matching_tiles[rand_range(0,matching_tiles.size())]
	var ending_direction = []
	ending_direction.append_array(river_sides.get(new_tile))
	ending_direction.erase(starting_side)
	return [new_tile, ending_direction[0]]

func get_opposite_river_side(direction):
	match direction:
		sides.DLEFT: return sides.URIGHT
		sides.DRIGHT: return sides.ULEFT
		sides.LEFT: return sides.RIGHT
		sides.RIGHT: return sides.LEFT
		sides.ULEFT: return sides.DRIGHT
		sides.URIGHT: return sides.DLEFT

func get_river_tile_sides(river_tile):
	return river_sides.get(river_tile)

func get_next_river_position(old_row, old_column, direction):
	var even = check_if_even(old_row)
	var new_row = old_row
	var new_column = old_column
	match direction:
		sides.DLEFT:
			new_row = old_row + 1
			if even: new_column = old_column - 1
		sides.DRIGHT:
			new_row = old_row + 1
			if not even: new_column = old_column + 1
		sides.RIGHT:
			new_column = old_column + 1
		sides.LEFT:
			new_column = old_column - 1
		sides.ULEFT:
			new_row = old_row - 1
			if even: new_column = old_column - 1
		sides.URIGHT:
			new_row = old_row - 1
			if not even: new_column = old_column + 1
	return [new_row, new_column]

func check_if_even(row):
	if row%2 == 0:
		return true
	else:
		return false
