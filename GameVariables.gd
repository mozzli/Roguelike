extends Node

enum day_cycle {MORNING = 0, NOON = 1, EVENING = 2, NIGHT = 3}

var object_under_player = null
var base
var map_on: bool = false
var selected_unit: Array
var map_selected_unit: MapUnit
var time_of_the_day: Color = Color(1,1,1,1)
var map_columns: int = 23
var map_rows: int = 23
var active_units: Array = []
var caravan: MapUnit
var current_map
var camera_zoom: Vector2 = Vector2(0.5,0.5)
var gui_is_on: bool = false
var enemies = []
var towns = []
var forest_tiles = []
var number_of_towns = 0
var current_scene
var base_map
var saved_node
var main_menu = preload("res://Main.tscn")
var battle_on: bool = false
var enemies_turn_on: bool = false
signal enemies_moved

func change_day_color(day_enum):
	match day_enum:
		day_cycle.MORNING: time_of_the_day = Color(0.70, 1, 1, 1)
		day_cycle.NOON: time_of_the_day = Color(1, 1, 1, 1)
		day_cycle.EVENING: time_of_the_day = Color(0.70, 0.40, 0.10, 1)
		day_cycle.NIGHT: time_of_the_day = Color(0.2, 0.2, 0.55, 1)

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("new_turn"):
			new_turn()

func new_turn():
	enemies_turn_on = true
	end_turn_of_player()
	enemies_turn()
	yield(self, "enemies_moved")
	current_map.move_time()
	for active_unit in active_units:
		active_unit.new_turn()
		enemies_turn_on = false
	print("New Turn!!")

func enemies_turn():
	for enemy in enemies:
		enemy.enemy_turn()
		yield(enemy, "boar_was_moved")
	emit_signal("enemies_moved")

func end_turn_of_player():
	for unit in active_units:
		unit.end_turn()

func get_random_forest_tile():
	return forest_tiles[rand_range(0,forest_tiles.size())]

func get_enemies() -> Array:
	return enemies

func load_new_map():
	object_under_player = null
	gui_is_on = false
	base = null
	forest_tiles.clear()
	active_units.clear()
	selected_unit.clear()
	enemies.clear()
	towns.clear()
	map_on = true
	time_of_the_day = Color(1,1,1,1)
	camera_zoom = Vector2(0.5,0.5)
	battle_on = false
	enemies_turn_on = false
	caravan = null
	

func get_active_unit_pos_list():
	var pos: Array = []
	for unit in active_units:
		pos.append(unit.get_tile())
	return pos
