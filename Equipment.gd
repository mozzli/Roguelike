extends Node2D

var items = []
var money = 0

var equiped_items = {GlobalItems.types_of_equipement.HEAD: null, 
GlobalItems.types_of_equipement.BODY: null, 
GlobalItems.types_of_equipement.LEFT_HAND: null, 
GlobalItems.types_of_equipement.RIGHT_HAND: null, 
GlobalItems.types_of_equipement.LEGS: null, 
GlobalItems.types_of_equipement.ACCESSORY: null }

func get_item(item: Items):
	add_child(item)
	items.append(item)

func equip_head(item):
	equiped_items[GlobalItems.types_of_equipement.HEAD] = item

func equip_body(item):
	equiped_items[GlobalItems.types_of_equipement.BODY] = item

func equip_left_hand(item):
	equiped_items[GlobalItems.types_of_equipement.LEFT_HAND] = item

func equip_right_hand(item):
	equiped_items[GlobalItems.types_of_equipement.RIGHT_HAND] = item

func equip_legs(item):
	equiped_items[GlobalItems.types_of_equipement.LEGS] = item

func equip_accessory(item):
	equiped_items[GlobalItems.types_of_equipement.ACCESSORY] = item

func add_money(amount: int) -> void:
	money += amount
