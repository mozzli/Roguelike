extends Armor

class_name LeatherShoes

var armor_name = "Leather Shoes"
var armor_defence = 3
var image = load("res://icon.png")

func _init():
	armor_type = GlobalItems.armor_type.LEGS
	set_image(image)
	set_name(armor_name)
	set_defence(armor_defence)
