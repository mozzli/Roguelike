extends Node2D

class_name PlayerItems

var items = []
var money = 0

var item_box = {}

var equiped_items: Dictionary = {}

func _init():
	for i in range(1,30):
		item_box[i] = null
	equiped_items[GlobalItems.equipement_type.HEAD] = null
	equiped_items[GlobalItems.equipement_type.BODY] = null
	equiped_items[GlobalItems.equipement_type.LEFT_HAND] = null
	equiped_items[GlobalItems.equipement_type.RIGHT_HAND] = null
	equiped_items[GlobalItems.equipement_type.LEGS] = null
	equiped_items[GlobalItems.equipement_type.ACCESSORY] = null

func add_new_item(item: Items) -> bool:
	for slot in range(1,30):
		if item_box.get(slot) == null:
			item_box[slot] = item
			return true
	return false

func get_item(item: Items):
	add_child(item)
	items.append(item)

func equip_head(item):
	equiped_items[GlobalItems.equipement_type.HEAD] = item

func equip_body(item):
	equiped_items[GlobalItems.equipement_type.BODY] = item

func equip_left_hand(item):
	equiped_items[GlobalItems.equipement_type.LEFT_HAND] = item

func equip_right_hand(item):
	equiped_items[GlobalItems.equipement_type.RIGHT_HAND] = item

func equip_legs(item):
	equiped_items[GlobalItems.equipement_type.LEGS] = item

func equip_accessory(item):
	equiped_items[GlobalItems.equipement_type.ACCESSORY] = item

func add_money(amount: int) -> void:
	money += amount
