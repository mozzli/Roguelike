extends Node2D

var pos_cell_global

func _ready():
	randomize()
	MovementUtils.map = $Map
	GameVariables.current_map = self
	MovementUtils.map_tiles = $MovementTiles
	$Map.create_map()
	spawn_builder(0,0)
	spawn_builder(8,20)
	spawn_builder(10,10)
	spawn_treasure(12,12)
	spawn_treasure(11,11)
	spawn_boar_random()
	spawn_boar_random()
	spawn_boar_random()
	spawn_boar_random()
	$Camera2D.activate_camera()

func spawn_builder(column, row):
	pos_cell_global = MovementUtils.map_tiles.map_to_world(Vector2(column,row))
	var builder = $ResourcePreloader.builder_res.instance()
	builder.position = pos_cell_global + Vector2(32,24)
	CellsContainers.set_cell_container(row,column,builder)
	add_child(builder)

func spawn_boar(column, row):
	pos_cell_global = MovementUtils.map_tiles.map_to_world(Vector2(column,row))
	var boar = $ResourcePreloader.boar_res.instance()
	boar.position = pos_cell_global + Vector2(32,24)
	CellsContainers.set_cell_container(row,column,boar)
	GameVariables.enemies.append(boar)
	add_child(boar)

func spawn_boar_random():
	var rand_forest_tile = GameVariables.get_random_forest_tile()
	var row = rand_forest_tile[0]
	var column = rand_forest_tile[1]
	spawn_boar(column, row)

func spawn_treasure(column: int, row: int):
	pos_cell_global = MovementUtils.map_tiles.map_to_world(Vector2(column,row))
	var treasure_chest = $ResourcePreloader.treasure_res.instance()
	treasure_chest.position = pos_cell_global + Vector2(32,24)
	add_child(treasure_chest)

func spawn_town():
	return $ResourcePreloader.town.instance()

func _input(event):
	if event is InputEventKey:
		check_key_event(event)

func check_key_event(event):
	if event.is_action_pressed("ui_accept"):
		GameVariables.change_day_color(GameVariables.day_cycle.EVENING)
		print("It's evening!")
	if event.is_action_pressed("ui_cancel"):
		GameVariables.change_day_color(GameVariables.day_cycle.NOON)
		print("It's noon!")
	if event.is_action_pressed("ui_select"):
		GameVariables.change_day_color(GameVariables.day_cycle.NIGHT)
		print("It's night!")
	if event.is_action_pressed("debug"):
		GameVariables.map_on = false
		GameVariables.current_scene = PackedScene.new()
		print(GameVariables.base_map)
		var result = GameVariables.current_scene.pack(get_tree().get_current_scene())
		if result == OK:
			ResourceSaver.save("res://name.scn", GameVariables.current_scene)
		get_tree().change_scene("res://Town.tscn")
