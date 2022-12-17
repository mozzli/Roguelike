extends Node2D

onready var menu_control = $ButtonLayer/MenuButtonControl

func _on_Button_button_up():
	GameVariables.base_map = null
	GameVariables.load_new_map()
	GameVariables.base_map = load("res://Map.tscn")
	if (get_tree().change_scene_to(GameVariables.base_map) == 0):
		print("Map loading successful")
	else:
		print("Map loading failed")
	GameVariables.map_on = true

func _ready():
	OS.window_borderless = true
	OS.window_fullscreen = true
	menu_control.get_node("MainPopup").popup()
	

