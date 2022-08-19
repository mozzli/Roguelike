extends Node

enum types{
	HEAD,
	LEFT_HAND,
	RIGHT_HAND,
	BODY,
	LEGS,
	ACCESSORY
}

enum items{
	LEATHER_BOOTS,
LEATHER_CAP,
IRON_SWORD,
LEATHER_GLOVES,
LEATHER_ARMOR
}

var item_keys = {0:"Leather Boots",
	1:"Leather Cap",
	2:"Iron Sword",
	3:"Leather Gloves",
	4:"Leather Armor"
	}

func get_item_name(number):
	return item_keys.get(number)

func get_random_item_lvl1():
	return items.values()[randi()%items.size()]
