extends Control

var selected = false

func _process(_delta):
	if GameVariables.enemies_turn_on:
		$BuildButton.disabled = true
	else:
		$BuildButton.disabled = false

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("mouse_click_left"):
		if selected == false:
			selected = true 
		else:
			GameVariables.base.focus_camera()
