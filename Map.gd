extends Node2D

var pos_cell_global

func _ready():
	randomize()
	MovementUtils.map = $Map
	GameVariables.current_map = self
	MovementUtils.map2 = $MovementTiles
	spawn_builder(0,0)
	spawn_builder(8,20)
	spawn_builder(10,10)
	spawn_treasure(12,12)
	spawn_treasure(11,11)
	$Map.create_map()
	GameVariables.object_under_player = null

func spawn_builder(column, row):
	pos_cell_global = get_node("Map").map_to_world(Vector2(column,row))
	var builder = $ResourcePreloader.builder_res.instance()
	builder.position = pos_cell_global + Vector2(32,24)
	add_child(builder) 

func spawn_treasure(column, row):
	pos_cell_global = get_node("Map").map_to_world(Vector2(column,row))
	var treasure_chest = $ResourcePreloader.treasure_res.instance()
	treasure_chest.position = pos_cell_global + Vector2(32,24)
	add_child(treasure_chest)

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

