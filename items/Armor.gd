extends Items

class_name Armor

var element = null
var passive_effect = null
var defence
var armor_type

func _init():
	set_item_type(GlobalItems.types_of_items.ARMOR)

func set_element(new_element: int):
	element = new_element

func set_defence(new_defence: int):
	defence = new_defence

func get_armor_type() -> int:
	return armor_type
