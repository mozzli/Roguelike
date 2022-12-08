extends Node2D

var pos_cell_global
var fog_on = true
onready var music = $Audio

func _ready():
	randomize()
	MovementUtils.map = $Map
	GameVariables.current_map = self
	MovementUtils.movement_tiles = $MovementTiles
	MovementUtils.map.create_map()
	MovementUtils.create_cell_cubed_list()
	$FogOfWar.create_fog_of_war()
	spawn_builder(Vector2(21,21))
	spawn_builder(Vector2(8,20))
	spawn_builder(Vector2(10,10))
	spawn_treasure(get_random_map_position())
	spawn_treasure(get_random_map_position())
	spawn_boar_random()
	spawn_boar_random()
	spawn_boar_random()
	spawn_boar_random()
	$Camera2D.activate_camera()
	music.play_music(music.get_audio(music.audio.FOREST_MAZE))

func spawn_builder(pos: Vector2):
	pos_cell_global = MovementUtils.movement_tiles.map_to_world(pos)
	var builder = $ResourcePreloader.builder_res.instance()
	builder.position = pos_cell_global + Vector2(32,24)
	CellsContainers.set_cell_container(int(pos.y),int(pos.x),builder)
	add_child(builder)
	$FogOfWar.set_visibility(int(pos.x), int(pos.y), builder)

func spawn_boar(column, row):
	pos_cell_global = MovementUtils.movement_tiles.map_to_world(Vector2(column,row))
	var boar = $ResourcePreloader.boar_res.instance()
	boar.position = pos_cell_global + Vector2(32,24)
	CellsContainers.set_cell_container(row,column,boar)
	GameVariables.enemies.append(boar)
	add_child(boar)
	boar.set_owner(self)

func spawn_boar_random():
	var rand_forest_tile = GameVariables.get_random_forest_tile()
	var row = rand_forest_tile[0]
	var column = rand_forest_tile[1]
	spawn_boar(column, row)

func spawn_treasure(pos: Vector2):
	pos_cell_global = MovementUtils.movement_tiles.map_to_world(pos)
	var treasure_chest = $ResourcePreloader.treasure_res.instance()
	treasure_chest.position = pos_cell_global + Vector2(32,24)
	add_child(treasure_chest)

func get_random_map_position() -> Vector2:
	Utilities.rng.randomize()
	var column = Utilities.rng.randi()%GameVariables.map_columns
	var row = Utilities.rng.randi()%GameVariables.map_rows
	return Vector2(column,row)

func spawn_town():
	return $ResourcePreloader.town.instance()

func _unhandled_input(event):
	if event is InputEventKey:
		check_key_event(event)

func check_key_event(event):
	if event.is_action_pressed("ui_accept"):
		GameVariables.change_day_color(GameVariables.day_cycle.EVENING)
		print("It's evening!")
	if event.is_action_pressed("ui_cancel") && $CanvasLayer/PauseControl.pause_is_on == false:
#		GameVariables.change_day_color(GameVariables.day_cycle.NOON)
#		print("It's noon!")
		$CanvasLayer/PauseControl.pause_on()
	if event.is_action_pressed("ui_select"):
		GameVariables.change_day_color(GameVariables.day_cycle.NIGHT)
		print("It's night!")
	if event.is_action_pressed("debug"):
#		if fog_on:
#			$FogOfWar.clear()
#			fog_on = false
#		else:
#			$FogOfWar.create_fog_of_war()
#			fog_on = true
		pass
