extends Node2D

var town_hall = true
var guild = false
var shop = false
var trainer = false
var object_body
var town_controller = GameVariables.current_map.get_node("TownsControl")

func _on_Town_body_entered(body):
	play_event(body)

func _on_Town_body_exited(_body):
	pass

func play_event(body):
	town_controller.show_town()
	print("it's everyday bro with a chicken nugget flo'")
