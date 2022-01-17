extends Node2D

var builder_res = preload("res://builder.tscn")

enum tiles {PLAINS = 0, TOWN = 1, FOREST = 2, MOUNTAINS = 3}

var map_rows = 20
var map_columns = 13
var mountains = 23
var towns = 3
var forest = 25

func _ready():
	randomize()
	var pos_cell_global= get_node("Map").map_to_world(Vector2(6,13))
	var builder = builder_res.instance()
	builder.position = pos_cell_global + Vector2(32,32)
	add_child(builder) 
	create_map()

func create_map():
	$Map.clear()
	create_mountains()
	
func create_mountains():
	var current_mountain_tiles = 0
	while (current_mountain_tiles<mountains):
		var row = randi() % map_rows + 1
		var column = randi() % map_columns + 1
		if (get_neighbor_tiles(tiles.MOUNTAINS,row,column).has(tiles.MOUNTAINS) == false):
			$Map.set_cell(column,row,tiles.MOUNTAINS)
			current_mountain_tiles+=1

func get_neighbor_tiles(tiles, row, column):
	var tiles_list = [$Map.get_cell(column,row),
	$Map.get_cell(column-1,row),
	$Map.get_cell(column+1,row),
	$Map.get_cell(column,row+1),
	$Map.get_cell(column,row-1)]
	if(row%2 == 0):
		tiles_list.append_array([$Map.get_cell(column-1,row-1),
		$Map.get_cell(column-1,row+1)])
	else:
		tiles_list.append_array([$Map.get_cell(column+1,row+1),
		$Map.get_cell(column+1,row-1)])
	return tiles_list
