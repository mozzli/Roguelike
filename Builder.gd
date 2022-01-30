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
		if event.is_action_pressed("mouse_click_left") && end_of_turn == false:
			old_position = global_position
			selected = true
			WalkCode.get_movement_distance(MovementUtils.map.world_to_map(global_position),
				 movement_value, null)
			$AnimatedSprite.speed_scale = 3
			$AnimatedSprite.modulate.r = 1.9
			input_pickable = false

func _on_KinematicBody2D_mouse_exited():
	mouse_floats = false

func _input(event):
	if event is InputEventMouseButton && mouse_floats == false:
		if event.is_action_pressed("mouse_click_left") && selected == true:
			selected = false
			$AnimatedSprite.speed_scale = 1
			$AnimatedSprite.modulate.r = 1
			input_pickable = true
			if (MovementUtils.map2.get_cell(WalkCode.mouse_position[0],WalkCode.mouse_position[1]) == 0):
				global_position = MovementUtils.map2.map_to_world(WalkCode.mouse_position)+Vector2(32,24)
				end_of_turn = true
				$AnimatedSprite.modulate.r = 0.1
			elif (MovementUtils.map2.get_cell(WalkCode.mouse_position[0],WalkCode.mouse_position[1]) == -1):
				global_position = old_position
			WalkCode.reset_movement()
	if event is InputEventMouseButton && selected == true:
		if event.is_action_pressed("mouse_click_right"):
#			self.global_position = $WalkCode.change_position(event.position)
			print("yeah, I'm going")

func _process(delta):
	if (selected == true && MovementUtils.map2.get_cell(WalkCode.mouse_position[0],WalkCode.mouse_position[1]) == 0):
		self.global_position = MovementUtils.map2.map_to_world(WalkCode.mouse_position)+Vector2(32,24)

func new_turn():
	end_of_turn = false
	$AnimatedSprite.modulate.r = 1
