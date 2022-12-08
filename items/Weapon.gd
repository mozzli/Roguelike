extends Items

class_name Weapons

var element = null
var passive_effect = null
var power

func _ready():
	set_item_type(GlobalItems.types_of_items.WEAPON)
#	print_name()

func set_element(new_element: int):
	element = new_element

func set_power(new_power: int):
	power = new_power

