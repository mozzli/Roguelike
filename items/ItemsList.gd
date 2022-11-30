extends Node

enum types_of_items{
	WEAPON,
	ARMOR,
	CONSUMABLES
}

enum types_of_equipement{
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
	BRONZE_SWORD,
	SILVER_SWORD,
	LEATHER_GLOVES,
	LEATHER_ARMOR
}

enum elements {
	FIRE,
	ICE,
	ELECTRICITY,
	WATER,
	EARTH
}

var item_keys = {0:"Leather Boots",
	1:"Leather Cap",
	2:"Iron Sword",
	3:"Bronze Sword",
	4:"Silver Sword"
	}

func get_item_name(number):
	return item_keys.get(number)

func get_random_item_lvl1():
	return items.values()[randi()%items.size()]
