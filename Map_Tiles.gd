extends TileMap

enum tiles {PLAINS = 0, TOWN = 1, FOREST = 2, MOUNTAINS = 3}
enum neighbour_tiles {UP_LEFT = 0,UP_RIGHT = 1,LEFT = 2,RIGHT = 3,DOWN_LEFT = 4,DOWN_RIGHT = 5}

var map_rows = 20
var map_columns = 16
var mountains = 50
var towns = 3
var forest = 115
var current_number_of_tiles = 0

func create_plains():
	for rows in map_rows:
		for columns in map_columns:
			set_cell(columns, rows, tiles.PLAINS)

func create_mountains():
	var row
	var column
	var current_tile
	current_number_of_tiles = 0
	while (current_number_of_tiles<mountains):
		row = randi() % map_rows
		column = randi() % map_columns
		current_tile = get_cell(column,row)
		var neighbour_tiles = get_neighbor_tiles(column,row).values()
		if (neighbour_tiles.has(tiles.MOUNTAINS) == false && current_tile != tiles.MOUNTAINS):
			var number_of_repeat = randi() % 5 + 1
			place_tiles(tiles.MOUNTAINS, column, row,number_of_repeat,0)

func create_forest():
	var row
	var column
	var current_tile
	current_number_of_tiles = 0
	while (current_number_of_tiles<forest):
		row = randi() % map_rows
		column = randi() % map_columns
		current_tile = get_cell(column,row)
		var neighbour_tiles = get_neighbor_tiles(column,row).values()
		if (neighbour_tiles.has(tiles.FOREST) == false && current_tile != tiles.FOREST):
			var number_of_repeat = randi() % 8 + 4
			place_tiles(tiles.FOREST, column, row,number_of_repeat,0)

func get_neighbor_tiles(column, row):
	var tiles_list = {neighbour_tiles.UP_LEFT: null,
	neighbour_tiles.UP_RIGHT: null,
	neighbour_tiles.RIGHT: get_cell(column+1,row),
	neighbour_tiles.LEFT: get_cell(column-1,row),
	neighbour_tiles.DOWN_LEFT: null,
	neighbour_tiles.DOWN_RIGHT: null}
	if(row%2 == 0):
		tiles_list[neighbour_tiles.UP_RIGHT] = get_cell(column,row-1)
		tiles_list[neighbour_tiles.UP_LEFT] = get_cell(column-1,row-1)
		tiles_list[neighbour_tiles.DOWN_LEFT] = get_cell(column-1,row+1)
		tiles_list[neighbour_tiles.DOWN_RIGHT] = get_cell(column,row+1)
	else:
		tiles_list[neighbour_tiles.UP_RIGHT] = get_cell(column+1,row-1)
		tiles_list[neighbour_tiles.UP_LEFT] = get_cell(column,row-1)
		tiles_list[neighbour_tiles.DOWN_LEFT] = get_cell(column,row+1)
		tiles_list[neighbour_tiles.DOWN_RIGHT] = get_cell(column+1,row+1)
	return tiles_list

func place_tiles(tiles, column, row, repeat_number, current_repeat):
	var current_repeat_number = current_repeat
	set_cell(column,row,tiles)
	current_number_of_tiles+=1
	current_repeat_number+=1
	if (current_repeat_number < repeat_number):
		var new_tile = get_random_free_tile(get_neighbor_tiles(column, row),column,row)
		if (new_tile != null):
			place_tiles(tiles, new_tile[0], new_tile[1],repeat_number,current_repeat_number)

func get_random_free_tile(neighbour_dictionary, column, row):
	var new_column = column
	var new_row = row 
	var free_tiles = []
	for key in neighbour_dictionary.size():
		if (neighbour_dictionary.get(key) == tiles.PLAINS):
			free_tiles.append(key)
	if (free_tiles.size() != 0):
		var random_free_tile = randi() % free_tiles.size()
		return get_new_tile(free_tiles,random_free_tile, new_column, new_row)


func get_new_tile(free_tiles, random_free_tile, new_column, new_row):
	match free_tiles[random_free_tile]:
		neighbour_tiles.UP_LEFT: 
			if (new_row%2==0):
				new_column -= 1
				new_row -=1
			else:
				new_row -=1
		neighbour_tiles.UP_RIGHT: 
			if (new_row%2==0):
				new_row +=1
			else:
				new_column += 1
				new_row -=1 
		neighbour_tiles.LEFT:
			new_column -= 1
		neighbour_tiles.RIGHT:
			new_column += 1
		neighbour_tiles.DOWN_LEFT: 
			if (new_row%2==0):
				new_column -= 1
				new_row +=1
			else:
				new_row +=1 
		neighbour_tiles.DOWN_RIGHT:
			if (new_row%2==0):
				new_row +=1
			else:
				new_column += 1
				new_row +=1
	return [new_column,new_row]
