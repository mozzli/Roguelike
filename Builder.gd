extends KinematicBody2D

var mouse_floats = false
var selected = false
var movement_value = 2
var old_position
var end_of_turn = false

func _ready():
	GameVariables.active_units.append(self)

func _on_KinematicBody2D_mouse_entered():
	mouse_floats = true

func _on_KinematicBody2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_click_left") && end_of_turn == false && selected == false:
			old_position = global_position
			selected = true
			WalkCode.get_movement_distance(get_position_on_map(global_position),
			movement_value, null)
			ColorManager.change_color_selected($AnimatedSprite)
			input_pickable = false

func _on_KinematicBody2D_mouse_exited():
	mouse_floats = false

func _input(event):
	if event is InputEventMouseButton && mouse_floats == false:
		if (event.is_action_pressed("mouse_click_left") && selected == true && 
		get_position_on_map(old_position) != WalkCode.mouse_position):
			selected = false
			$AnimatedSprite.speed_scale = 1
			input_pickable = true
			if (WalkCode.get_movement_cell() == 0):
				global_position = MovementUtils.map2.map_to_world(WalkCode.mouse_position)+Vector2(32,24)
				end_of_turn = true
				ColorManager.change_color_end_turn($AnimatedSprite)
				if GameVariables.object_under_player != null:
					print(GameVariables.object_under_player)
					GameVariables.object_under_player.play_event()
			elif (WalkCode.get_movement_cell() == -1 ||
			MovementUtils.map.world_to_map(global_position) == WalkCode.mouse_position):
				global_position = old_position
				ColorManager.change_color_default($AnimatedSprite)
			WalkCode.reset_movement()
	if event is InputEventMouseButton && selected == true:
		if event.is_action_pressed("mouse_click_right"):
			var line = randi() % 3
			match line:
				0: print("yeah, I'm going, siiiir")
				1: print("somtn' on ya mind?")
				2: print("whadda you want?!")
				

func _process(_delta):
	if (selected == true && WalkCode.get_movement_cell() == 0):
		self.global_position = MovementUtils.map2.map_to_world(WalkCode.mouse_position)+Vector2(32,24)

func new_turn():
	end_of_turn = false
	ColorManager.change_color_default($AnimatedSprite)

func get_position_on_map(pos):
	return MovementUtils.map.world_to_map(pos)