extends Node2D

func _on_Button_button_up():
	get_tree().change_scene("res://Map.tscn")
	GameVariables.map_on = true
