extends Node2D

func _on_Button_button_up():
	if (get_tree().change_scene_to(GameVariables.base_map) == 0):
		print("Map loading successful")
	else:
		print("Map loading failed")
	GameVariables.map_on = true

func _ready():
	OS.window_borderless = true
	OS.window_fullscreen = true
	$Button.set_position(get_viewport_rect().size/2 - Vector2($Button.rect_size.x/2, $Button.rect_size.y/2))
	GameVariables.base_map = preload("res://Map.tscn")

