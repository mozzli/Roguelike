extends Node2D

func _on_Button_button_up():
	if (get_tree().change_scene("res://Map.tscn") == 0):
		print("Map loading successful")
	else:
		print("Map loading failed")
	GameVariables.map_on = true

func _ready():
	print(OS.window_size)
	OS.window_borderless = true
	OS.window_fullscreen = true
