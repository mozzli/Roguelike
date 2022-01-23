extends KinematicBody2D


var mouse_floats = false
var selected = false



func _ready():
	pass # Replace with function body.


func _on_KinematicBody2D_mouse_entered():
	mouse_floats = true


func _on_KinematicBody2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_click_left"):
			selected = true
			$AnimatedSprite.speed_scale = 3
			$AnimatedSprite.modulate.r = 1.5
			GameVariables.selected_unit = self
			print(GameVariables.selected_unit)


func _on_KinematicBody2D_mouse_exited():
	mouse_floats = false

func _input(event):
	if event is InputEventMouseButton && mouse_floats == false:
		if event.is_action_pressed("mouse_click_left"):
			selected = false
			$AnimatedSprite.speed_scale = 1
			$AnimatedSprite.modulate.r = 1
			GameVariables.selected_unit = null
	if event is InputEventMouseButton && selected == true:
		if event.is_action_pressed("mouse_click_right"):
			print("yeah, I'm going")
		
