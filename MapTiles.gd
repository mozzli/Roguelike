extends TileMap

var map_rows = GameVariables.map_rows
var map_columns = GameVariables.map_columns
var mountains_amount = 50
var towns = 3
var river_amount = 2
var forest_amount = 150
var current_number_of_tiles = 0

func _ready():
	clear()

func create_map():
	clear()
	create_plains()
	create_single_river(40)
	create_single_river(40)
	create_mountains(5)
	create_forest()
	create_towns()
	create_wall()

func create_plains():
	for rows in map_rows:
		for columns in map_columns:
			set_cell(columns, rows, MovementUtils.tiles.PLAINS)

func create_rivers():
	current_number_of_tiles = 0
	for _i in range(river_amount - 1):
		create_single_river(12)

func create_mountains(maximum_mountains_amount):
	current_number_of_tiles = 0
	while (current_number_of_tiles < mountains_amount):
		create_custom_random_tiles(MovementUtils.tiles.MOUNTAINS, 1, maximum_mountains_amount)

func create_forest():
	current_number_of_tiles = 0
	while (current_number_of_tiles < forest_amount):
		create_custom_random_tiles(MovementUtils.tiles.FOREST, 4, 8)

func create_towns():
	current_number_of_tiles = 0
	while (current_number_of_tiles < towns):
		create_town()

func create_wall():
	create_vertical_walls()
	create_horizontal_walls()

func create_custom_random_tiles(type_of_tile, minimum_amount_of_neighbours, 
extra_neighbours):
	var row = randi() % map_rows
	var column = randi() % map_columns
	var current_tile = get_cell(column, row)
	var neighbour_tiles = MovementUtils.get_neighbor_tiles(column, row).values()
	if (
		not neighbour_tiles.has(type_of_tile)
		&& current_tile == MovementUtils.tiles.PLAINS):
		var number_of_repeat = randi() % extra_neighbours + minimum_amount_of_neighbours
		place_tiles(type_of_tile, column, row,number_of_repeat,0)

func create_town():
	var row = randi() % map_rows
	var column = randi() % map_columns
	var current_tile = get_cell(column, row)
	if current_tile == MovementUtils.tiles.PLAINS:
		place_tiles(MovementUtils.tiles.TOWN, column, row,1,0)
		var town = GameVariables.current_map.spawn_town()
		var pos_cell_global = MovementUtils.movement_tiles.map_to_world(Vector2(column,row))
		town.position = pos_cell_global + Vector2(32,24)
		add_child(town)
		GameVariables.towns.append(town)

func place_tiles(tiles, column, row, repeat_number, current_repeat):
	divide_cells_by_type(tiles, [row,column])
	var current_repeat_number = current_repeat
	set_cell(column,row,tiles)
	current_number_of_tiles += 1
	current_repeat_number += 1
	if (current_repeat_number < repeat_number):
		var new_tile = MovementUtils.get_random_free_tile(
			MovementUtils.get_neighbor_tiles(column, row), column, row)
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

func create_single_river(river_lenght):
	var row = randi() % (map_rows - 1)
	var column = randi() % (map_columns - 1)
	var river_expand_direction = RiverCreator.sides.DRIGHT
	place_tiles(MovementUtils.tiles.MOUNTAINS_WITH_RIVER,column,row,0,0)
	for _i in range(river_lenght):
		var loop = true
		var loop_time = 0
		while loop:
			loop_time += 1
			if loop_time == 10:
				loop = false
			var x = place_river_tile(river_expand_direction, row, column)
			if x != null:
				row = x[0]
				column = x[1]
				river_expand_direction = x[2]
				loop = false
	place_tiles(MovementUtils.tiles.LAKE,column,row,0,0)

func place_river_tile(river_expand_direction, old_row, old_column):
	var new_river_type_cell = RiverCreator.get_random_matching_tile(river_expand_direction)
	var new_cell_placement = RiverCreator.get_next_river_position(old_row,old_column,river_expand_direction)
	var second_step_tile_placement = RiverCreator.get_next_river_position(new_cell_placement[0], new_cell_placement[1],new_river_type_cell[1])
	var second_step_tile_type = get_cell(second_step_tile_placement[1], second_step_tile_placement[0])
	if(second_step_tile_type == MovementUtils.tiles.PLAINS):
		old_row = new_cell_placement[0]
		old_column = new_cell_placement[1]
		place_tiles(new_river_type_cell[0],old_column,old_row,0,0)
		river_expand_direction = new_river_type_cell[1]
		return [old_row, old_column, river_expand_direction]

func divide_cells_by_type(type, cell):
	if type == MovementUtils.tiles.FOREST:
		GameVariables.forest_tiles.append(cell)
