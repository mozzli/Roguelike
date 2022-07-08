extends TileMap

enum tiles {DARK_BLUE = 0}

func create_fog_of_war():
	for column in GameVariables.map_columns:
		for row in GameVariables.map_rows:
			set_cell(column,row,tiles.DARK_BLUE)

func set_visibility(column, row, player):
	var neighbours = MovementUtils.get_neighbors_position_with_vision(column, row, player.vision_range)
	for cell in neighbours:
		set_cell(cell[0],cell[1],-1)
	player.fog_of_war_visibility = neighbours

func check_if_visible(column, row):
	if get_cell(column,row) != 0:
		return true
	return false

func hide_tiles(tiles_list):
	for tile in tiles_list:
		if check_if_out_of_bounds(tile[0], tile[1]):
			set_cell(tile[0], tile[1], 0)

func show_tiles(tiles_list):
	for tile in tiles_list:
		if check_if_out_of_bounds(tile[0], tile[1]):
			set_cell(tile[0], tile[1], -1)

func check_if_out_of_bounds(column, row):
	if column < 0 || row < 0 || column > GameVariables.map_columns - 1 || row > GameVariables.map_rows - 1:
		return false
	else:
		return true
