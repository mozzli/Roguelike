extends Node

enum tiles {PLAINS = 0,
 TOWN = 1,
 FOREST = 2,
 MOUNTAINS = 3,
 MOUNTAINS_WITH_RIVER = 4,
 WALL = 5,
 RIVER = 6,
 LAKE = 21}

enum tiles_mov_value {RIVER = 3,
 PLAINS = 1,
 FOREST = 2,
 MOUNTAINS = 6,
 MOUNTAINS_WITH_RIVER = 5,
 TOWN = 1,
 WALL = -1,
 LAKE = 2}

enum neighbour_tiles {UP_LEFT = 0, UP_RIGHT = 1, LEFT = 2, RIGHT = 3, DOWN_LEFT = 4, DOWN_RIGHT = 5}

var cell = load("res://CellClass.gd")
var map
var movement_tiles
var fog_map
var cell_cubed_list
var cell_dictionary = {}
const RIVER_TILES = []

func _ready():
	for i in range(6,20):
		RIVER_TILES.append(i)

func get_terrain_type(position):
	var cell_position = map.world_to_map(position)
	return MovementUtils.map.get_cell(cell_position.x, cell_position.y)

func get_movement_value_by_index(index):
	if RIVER_TILES.has(index):
		return tiles_mov_value.RIVER
	match(index):
		tiles.PLAINS: return tiles_mov_value.PLAINS
		tiles.TOWN: return tiles_mov_value.TOWN
		tiles.FOREST: return tiles_mov_value.FOREST
		tiles.MOUNTAINS: return tiles_mov_value.MOUNTAINS
		tiles.MOUNTAINS_WITH_RIVER: return tiles_mov_value.MOUNTAINS_WITH_RIVER
		tiles.LAKE: return tiles_mov_value.LAKE
		[RIVER_TILES]: return tiles_mov_value.RIVER
		_: return 99

func get_neighbor_tiles(column: int, row: int):
	var tiles_list = {
		neighbour_tiles.UP_LEFT: null,
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

func get_neighbors_position(column: int, row: int):
	var neighbor_position_list = []
	for side in neighbour_tiles:
		var new_column = int(column)
		var new_row = int(row)
		match side:
			"UP_LEFT":
				if (new_row % 2 == 0):
					new_column -= 1
				new_row -= 1
			"UP_RIGHT": 
				if (new_row % 2 != 0):
					new_column += 1
				new_row -= 1 
			"LEFT":
				new_column -= 1
			"RIGHT":
				new_column += 1
			"DOWN_LEFT": 
				if (new_row % 2 == 0):
					new_column -= 1
				new_row += 1
			"DOWN_RIGHT":
				if (new_row % 2 != 0):
					new_column += 1
				new_row += 1
		neighbor_position_list.append([new_column,new_row])
	return neighbor_position_list
	
func get_neighbour_cells(main_cell: Node):
	var cells = []
	var coordinates_list = get_neighbors_position(main_cell.coordinates.x, main_cell.coordinates.y)
	for data in coordinates_list:
		cells.append(cell_dictionary.get(Vector2(data[0], data[1])))
	return cells
	
func get_neighbors_position_with_vision(column: int, row: int, vision: int ):
	var tiles_to_check = [[column, row]]
	for _i in range(0,vision):
		var new_array = []
		for tile in tiles_to_check:
			var array = get_neighbors_position(tile[0], tile[1])
			for arrays in array:
				if !tiles_to_check.has(arrays) && !new_array.has(arrays):
					new_array.append(arrays)
		tiles_to_check.append_array(new_array)
	return tiles_to_check

func create_cell_cubed_list():
	cell_cubed_list = get_map_tiles_cube_coordinates_list()

func get_map_tiles_cube_coordinates_list():
	var tiles_cubed_list = []
	var x = 0
	var y = 0
	for row in GameVariables.map_rows:
		if row % 2 == 1:
			x += 1
		if (row % 2 == 0 && row != 0):
			y += 1
		for column in GameVariables.map_columns:
			var coordinates = Vector2(column,row)
			var cubed = Vector3(x + column,row * -1,y - column)
			var new_cell = cell.new(coordinates, cubed)
			tiles_cubed_list.append(new_cell)
			cell_dictionary[coordinates] = new_cell
	return tiles_cubed_list

func update_cell_list():
	add_tile_types_to_cell_list()
	add_g_value_to_cells()

func add_tile_types_to_cell_list():
	for i_cell in cell_cubed_list:
		i_cell.type = map.get_cell(i_cell.coordinates.x,i_cell.coordinates.y)

func add_g_value_to_cells():
	for i_cell in cell_cubed_list:
		i_cell.g_value = get_movement_value_by_index(i_cell.type)

func get_neighbor_dictionary(unit: Node2D) -> Dictionary:
	var neighbours: Dictionary = {neighbour_tiles.UP_LEFT: null,
	 neighbour_tiles.UP_RIGHT: null,
	 neighbour_tiles.LEFT: null,
	 neighbour_tiles.RIGHT: null,
	 neighbour_tiles.DOWN_LEFT: null,
	 neighbour_tiles.DOWN_RIGHT: null}
	var unit_pos: Vector2 = unit.get_tile_position()
	for tile in neighbours:
		match tile:
			neighbour_tiles.UP_LEFT:
				if (int(unit_pos.y) % 2 == 0):
					neighbours[neighbour_tiles.UP_LEFT] = unit_pos + Vector2(-1,-1)
				else:
					neighbours[neighbour_tiles.UP_LEFT] = unit_pos + Vector2(0,-1)
			neighbour_tiles.UP_RIGHT: 
				if (int(unit_pos.y) % 2 == 0):
					neighbours[neighbour_tiles.UP_RIGHT] = unit_pos + Vector2(0,-1)
				else:
					neighbours[neighbour_tiles.UP_RIGHT] = unit_pos + Vector2(+1,-1)
			neighbour_tiles.LEFT:
				neighbours[neighbour_tiles.LEFT] = unit_pos + Vector2(-1,0)
			neighbour_tiles.RIGHT:
				neighbours[neighbour_tiles.RIGHT] = unit_pos + Vector2(+1,0)
			neighbour_tiles.DOWN_LEFT: 
				if (int(unit_pos.y) % 2 == 0):
					neighbours[neighbour_tiles.DOWN_LEFT] = unit_pos + Vector2(-1,+1)
				else:
					neighbours[neighbour_tiles.DOWN_LEFT] = unit_pos + Vector2(0,+1)
			neighbour_tiles.DOWN_RIGHT:
				if (int(unit_pos.y) % 2 == 0):
					neighbours[neighbour_tiles.DOWN_RIGHT] = unit_pos + Vector2(0,+1)
				else:
					neighbours[neighbour_tiles.DOWN_RIGHT] = unit_pos + Vector2(+1,+1)
	return neighbours
