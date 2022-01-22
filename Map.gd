extends Node2D

var builder_res = preload("res://builder.tscn")

func _ready():
	randomize()
	var pos_cell_global= get_node("Map").map_to_world(Vector2(6,13))
	var builder = builder_res.instance()
	builder.position = pos_cell_global + Vector2(32,32)
	add_child(builder) 
	create_map()

func create_map():
	$Map.clear()
	$Map.create_plains()
	$Map.create_mountains()
	$Map.create_forest()
	
