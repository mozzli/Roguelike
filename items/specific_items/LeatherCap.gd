extends Armor

class_name LeatherCap

var armor_name = "Leather Cap"
var armor_defence = 6
var image = load("res://icon.png")

func _init():
	armor_type = GlobalItems.armor_type.HEAD
	set_image(image)
	set_name(armor_name)
	set_defence(armor_defence)
