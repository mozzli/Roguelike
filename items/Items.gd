extends Node

class_name Items

var type
var item_name
var picture

func print_name() -> void:
	print(item_name)

func set_name(new_name) -> void:
	item_name = new_name
	print(item_name)

func get_item_name() -> String:
	return item_name

func set_item_type(new_type: int) -> void:
	type = new_type

func get_item_type() -> int:
	return type

func set_image(image):
	picture = image

func get_image():
	return picture
