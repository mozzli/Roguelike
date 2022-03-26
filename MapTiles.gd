extends TileMap

var map_rows = GameVariables.map_rows
var map_columns = GameVariables.map_columns
var mountains = 50
var towns = 3
var forest = 115
var current_number_of_tiles = 0

func create_map():
	clear()
	create_plains()
	create_mountains()
	create_forest()
	create_wall()

func create_plains():
	for rows in map_rows:
		for columns in map_columns:
			set_cell(columns, rows, MovementUtils.tiles.PLAINS)

func create_mountains():

	current_number_of_tiles = 0
	while (current_number_of_tiles < mountains):
		create_custom_random_tiles(MovementUtils.tiles.MOUNTAINS, 1, 5)

func create_forest():

	current_number_of_tiles = 0
	while (current_number_of_tiles < forest):
		create_custom_random_tiles(MovementUtils.tiles.FOREST, 4, 8)

func create_wall():
	create_vertical_walls()
	create_horizontal_walls()

func create_custom_random_tiles(type_of_tile, minimum_amount_of_neighbours, 
extra_neighbours):
	var row = randi() % map_rows
	var column = randi() % map_columns
	var current_tile = get_cell(column, row)
	var neighbour_tiles = MovementUtils.get_neighbor_tiles(column, row, self).values()
	if (
		not neighbour_tiles.has(type_of_tile)
		&& current_tile != type_of_tile):
		var number_of_repeat = randi() % extra_neighbours + minimum_amount_of_neighbours
		place_tiles(type_of_tile, column, row,number_of_repeat,0)

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
			place_tiles(tiles, new_tile[0], new_tile[1],repeat_number,current_repeat_number)

func create_vertical_walls():
	for row in map_rows:
		place_tiles(MovementUtils.tiles.WALL, -1, row, 1, 0)
		place_tiles(MovementUtils.tiles.WALL, map_columns, row, 1, 0)

func create_horizontal_walls():
	for column in map_columns + 1:
		if map_rows% 2 == 1:
			place_tiles(MovementUtils.tiles.WALL, column - 1, -1, 1, 0)
			place_tiles(MovementUtils.tiles.WALL, column - 1, map_rows, 1, 0)
		else:
			place_tiles(MovementUtils.tiles.WALL, column - 1, -1, 1, 0)
			place_tiles(MovementUtils.tiles.WALL, column, map_rows, 1, 0)
