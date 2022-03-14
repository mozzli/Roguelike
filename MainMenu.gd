extends Node2D

var map_res = preload("Map.tscn")

func _on_Button_button_up():
	get_tree().change_scene("res://Map.tscn")
	GameVariables.map_on = true
