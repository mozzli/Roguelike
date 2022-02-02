extends TileMap

var map_rows = GameVariables.map_rows
var map_columns = GameVariables.map_columns
var mountains = 50
var towns = 3
var forest = 115
var current_number_of_tiles = 0

func create_plains():
	for rows in map_rows:
		for columns in map_columns:
			set_cell(columns, rows, MovementUtils.tiles.PLAINS)

func create_mountains():
	var row
	var column
	var current_tile
	current_number_of_tiles = 0
	while (current_number_of_tiles < mountains):
		row = randi() % map_rows
		column = randi() % map_columns
		current_tile = get_cell(column,row)
		var neighbour_tiles = MovementUtils.get_neighbor_tiles(column, row, self).values()
		if (
			not neighbour_tiles.has(MovementUtils.tiles.MOUNTAINS)
			&& current_tile != MovementUtils.tiles.MOUNTAINS
		):
			var number_of_repeat = randi() % 5 + 1
			place_tiles(MovementUtils.tiles.MOUNTAINS, column, row,number_of_repeat, 0)

func create_forest():
	var row
	var column
	var current_tile
	current_number_of_tiles = 0
	while (current_number_of_tiles < forest):
		row = randi() % map_rows
		column = randi() % map_columns
		current_tile = get_cell(column, row)
		var neighbour_tiles = MovementUtils.get_neighbor_tiles(column, row, self).values()
		if (
			not neighbour_tiles.has(MovementUtils.tiles.FOREST)
			&& current_tile != MovementUtils.tiles.FOREST
		):
			var number_of_repeat = randi() % 8 + 4
			place_tiles(MovementUtils.tiles.FOREST, column, row,number_of_repeat,0)

func place_tiles(tiles, column, row, repeat_number, current_repeat):
	var current_repeat_number = current_repeat
	set_cell(column,row,tiles)
	current_number_of_tiles += 1
	current_repeat_number += 1
	if (current_repeat_number < repeat_number):
		var new_tile = MovementUtils.get_random_free_tile(
			MovementUtils.get_neighbor_tiles(column, row, self), column, row
		)
		if (new_tile != null):
			place_tiles(tiles, new_tile[0], new_tile[1], repeat_number, current_repeat_number)
