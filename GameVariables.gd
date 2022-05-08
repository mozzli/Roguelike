extends Node

enum day_cycle {MORNING = 0, NOON = 1, EVENING = 2, NIGHT = 3}

var object_under_player = null
var map_on = false
var selected_unit
var time_of_the_day = Color(1,1,1,1)
var map_columns = 23
var map_rows = 23
var active_units = []
var current_map
var camera_zoom = Vector2(0.5,0.5)
var gui_is_on = false
var enemies = []
var forest_tiles = []
signal enemies_moved

func change_day_color(day_enum):
	match day_enum:
		day_cycle.MORNING: time_of_the_day = Color(0.94, 1, 1, 1)
		day_cycle.NOON: time_of_the_day = Color(1, 1, 1, 1)
		day_cycle.EVENING: time_of_the_day = Color(1, 0.27, 0, 1)
		day_cycle.NIGHT: time_of_the_day = Color(0, 0, 0.55, 1)

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("new_turn"):
			enemies_turn()
			yield(self, "enemies_moved")
			for active_unit in active_units:
				active_unit.new_turn()
			print("New Turn!!")

func enemies_turn():
	for enemy in enemies:
		var en = enemy.enemy_turn()
		yield(enemy, "boar_was_moved")
	emit_signal("enemies_moved")

func get_random_forest_tile():
	return forest_tiles[rand_range(0,forest_tiles.size())]
