extends Node2D

var pos_cell_global 
var fog_on = true
var current_time = 0
onready var music = $Audio


func _ready():
	GameVariables.load_new_map()
	randomize()
	MovementUtils.map = $Map
	GameVariables.current_map = self
	MovementUtils.movement_tiles = $MovementTiles
	MovementUtils.map.create_map()
	MovementUtils.create_cell_cubed_list()
	MovementUtils.fog_map = $FogOfWar
	$FogOfWar.create_fog_of_war()
	spawn_caravan(Vector2(11,11))
	spawn_builder_random()
	spawn_builder_random()
	spawn_boar_random()
	spawn_boar_random()
	spawn_boar_random()
	spawn_boar_random()
	spawn_treasure_random()
	spawn_treasure_random()
	$Camera2D.activate_camera()
	music.play_music(music.get_audio(music.audio.FOREST_MAZE))
	update_minimap()
	update_gui_units()

func spawn_builder(pos: Vector2):
	pos_cell_global = MovementUtils.movement_tiles.map_to_world(pos)
	var builder = $ResourcePreloader.builder_res.instance()
	builder.position = pos_cell_global + Vector2(32,24)
	CellsContainers.set_cell_container(int(pos.y),int(pos.x),builder)
	add_child(builder)
	$FogOfWar.set_visibility(int(pos.x), int(pos.y), builder)

func spawn_builder_random():
	var rand_true_tile
	var true_tile_found = false
	while !true_tile_found:
		rand_true_tile = get_random_map_position()
		if MovementUtils.get_terrain_type_map(rand_true_tile) == MovementUtils.tiles.TOWN:
			continue
		true_tile_found = true
	spawn_builder(rand_true_tile)

func spawn_caravan(pos: Vector2):
	pos_cell_global = MovementUtils.movement_tiles.map_to_world(pos)
	var caravan = $ResourcePreloader.caravan_res.instance()
	caravan.position = pos_cell_global + Vector2(32,24)
	CellsContainers.set_cell_container(int(pos.y),int(pos.x),caravan)
	add_child(caravan)
	GameVariables.caravan = caravan
	$FogOfWar.set_visibility(int(pos.x), int(pos.y), caravan)

func spawn_boar(row, column):
	pos_cell_global = MovementUtils.movement_tiles.map_to_world(Vector2(column,row))
	var boar = $ResourcePreloader.boar_res.instance()
	boar.position = pos_cell_global + Vector2(32,24)
	CellsContainers.set_cell_container(row,column,boar)
	GameVariables.enemies.append(boar)
	add_child(boar)
	boar.set_owner(self)

func spawn_boar_random():
	var rand_forest_tile
	var forest_tile_found = false
	var active_unit_positions = GameVariables.get_active_unit_pos_list()
	while !forest_tile_found:
		rand_forest_tile = GameVariables.get_random_forest_tile()
		if active_unit_positions.has(Vector2(rand_forest_tile[0], rand_forest_tile[1])):
			continue
		forest_tile_found = true
	var row = rand_forest_tile[0]
	var column = rand_forest_tile[1]
	spawn_boar(row,column)

func spawn_treasure(pos: Vector2):
	pos_cell_global = MovementUtils.movement_tiles.map_to_world(pos)
	var treasure_chest = $ResourcePreloader.treasure_res.instance()
	treasure_chest.position = pos_cell_global + Vector2(32,24)
	add_child(treasure_chest)

func spawn_treasure_random():
	var rand_tile
	var tile_found = false
	var active_unit_positions = GameVariables.get_active_unit_pos_list()
	while !tile_found:
		rand_tile = get_random_map_position()
		if active_unit_positions.has(rand_tile):
			continue
		tile_found = true
	spawn_treasure(rand_tile)

func spawn_base(pos: Vector2):
	$Map.set_cell(pos.x,pos.y, MovementUtils.tiles.PLAINS)
	pos_cell_global = MovementUtils.movement_tiles.map_to_world(Vector2(pos))
	var town = GlobalPreloader.base_res.instance()
	town.position = pos_cell_global + Vector2(32,24)
	CellsContainers.set_cell_container(int(pos.y),int(pos.x),town)
	GameVariables.base = town
	add_child(town)
	$FogOfWar.set_visibility(int(pos.x), int(pos.y), town)

func get_random_map_position() -> Vector2:
	Utilities.rng.randomize()
	var column = Utilities.rng.randi()%GameVariables.map_columns
	var row = Utilities.rng.randi()%GameVariables.map_rows
	return Vector2(column,row)

func spawn_town():
	return $ResourcePreloader.town.instance()

func update_minimap():
	$SideGUILayer/SideGUIControl/MinimapViewportContainer/MinimapViewport/MinimapTiles.update_minimap()

func update_minimap_visibility():
	$SideGUILayer/SideGUIControl/MinimapViewportContainer/MinimapViewport/MinimapTiles.update_visibility()

func update_minimap_units():
	$SideGUILayer/SideGUIControl/MinimapViewportContainer/MinimapViewport/MinimapTiles.update_units()
	
func update_gui_units():
	$SideGUILayer/SideGUIControl.update_unit_panel()

func _unhandled_input(event):
	if event is InputEventKey:
		check_key_event(event)

func check_key_event(event):
	if event.is_action_pressed("ui_accept"):
		GameVariables.change_day_color(GameVariables.day_cycle.EVENING)
		print("It's evening!")
	if event.is_action_pressed("ui_cancel") && $PauseLayer/PauseControl.pause_is_on == false:
#		GameVariables.change_day_color(GameVariables.day_cycle.NOON)
#		print("It's noon!")
		$PauseLayer/PauseControl.pause_on()
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
		print(GameVariables.selected_unit)

func move_time():
	$ClockLayer/ClockControl.add_time()
	current_time += 1
	match(current_time):
		2: GameVariables.change_day_color(GameVariables.day_cycle.EVENING)
		4: GameVariables.change_day_color(GameVariables.day_cycle.NIGHT)
		8: GameVariables.change_day_color(GameVariables.day_cycle.MORNING)
		10: GameVariables.change_day_color(GameVariables.day_cycle.NOON)
		12: current_time = 0
		_: pass

func change_camera_position(pos):
	$Camera2D.position = pos

func pause_on():
	$PauseLayer/PauseControl.pause_on()

func _on_BattleArena_hide_gui():
	$SideGUILayer.hide()

func _on_BattleArena_show_gui():
	$SideGUILayer.show()


