extends Items

class_name Weapons

var element = null
var passive_effect = null
var power
var weapon_type

func _init():
	set_item_type(GlobalItems.types_of_items.WEAPON)

func set_element(new_element: int):
	element = new_element

func set_power(new_power: int):
	power = new_power

