extends KinematicBody2D

var mouse_floats = false
var selected = false
var end_of_turn = false
var movement_value = 4
var old_position

func _ready():
	GameVariables.active_units.append(self)

func _process(_delta):
	if (selected && MovementUtils.map_tiles.get_cell(WalkCode.mouse_position[0], WalkCode.mouse_position[1]) == 0):
		self.global_position = MovementUtils.map_tiles.map_to_world(WalkCode.mouse_position)+Vector2(32,24)

func _on_KinematicBody2D_mouse_entered():
	mouse_floats = true

func _on_KinematicBody2D_mouse_exited():
	mouse_floats = false

func _on_KinematicBody2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_click_left") && not end_of_turn && not selected:
			select_player()

func _input(event):
	if event is InputEventMouseButton && not mouse_floats:
		left_click_check(event)
	if event is InputEventMouseButton && selected:
		if event.is_action_pressed("mouse_click_right"):
			reset_player_position()

func left_click_check(event):
	if event.is_action_pressed("mouse_click_left") && selected && (MovementUtils.map.world_to_map(old_position) != WalkCode.mouse_position):
		if (WalkCode.get_movement_cell() == 0):
			move_player()
		elif (WalkCode.get_movement_cell() == -1):
			reset_player_position()

func new_turn():
	end_of_turn = false
	ColorManager.change_color_default($AnimatedSprite)

func get_position_on_map(pos):
	return MovementUtils.map.world_to_map(pos)

func play_object_event():
	GameVariables.object_under_player.play_event()
	
func move_player():
	deselect_player()
	global_position = MovementUtils.map_tiles.map_to_world(WalkCode.mouse_position)+Vector2(32,24)
	end_of_turn = true
	ColorManager.change_color_end_turn($AnimatedSprite)
	if GameVariables.object_under_player != null:
		play_object_event()

func reset_player_position():
	deselect_player()
	global_position = old_position
	ColorManager.change_color_default($AnimatedSprite)

func select_player():
	old_position = global_position
	selected = true
	WalkCode.get_movement_distance(get_position_on_map(global_position),
	movement_value, null)
	ColorManager.change_color_selected($AnimatedSprite)
	input_pickable = false

func deselect_player():
	WalkCode.reset_movement_tiles()
	selected = false
	$AnimatedSprite.speed_scale = 1
	input_pickable = true
