extends Node2D

const Util = preload("MovementUtils.gd")

func _ready():
	MovementUtils.map = $Map
	MovementUtils.map2 = $MovementTiles
	randomize()
	spawn_builder(0,0)
	spawn_builder(8,20)
	spawn_builder(10,10)
	create_map()

func create_map():
	$Map.clear()
	$Map.create_plains()
	$Map.create_mountains()
	$Map.create_forest()

func spawn_builder(column, row):
	var pos_cell_global = get_node("Map").map_to_world(Vector2(column,row))
	var builder = $ResourcePreloader.builder_res.instance()
	builder.position = pos_cell_global + Vector2(32,24)
	add_child(builder) 

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_accept"):
			GameVariables.change_day_color(GameVariables.day_cycle.EVENING)
			print("It's evening!")
		if event.is_action_pressed("ui_cancel"):
			GameVariables.change_day_color(GameVariables.day_cycle.NOON)
			print("It's noon!")
		if event.is_action_pressed("ui_select"):
			GameVariables.change_day_color(GameVariables.day_cycle.NIGHT)
			print("It's night!")

