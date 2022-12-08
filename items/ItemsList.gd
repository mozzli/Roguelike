extends Node

var iron_sword = preload("res://items/specific_items/IronSword.tscn")
var bronze_sword = preload("res://items/specific_items/BronzeSword.tscn")
var silver_sword = preload("res://items/specific_items/SilverSword.tscn")

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

var item_keys = {items.LEATHER_BOOTS:"Leather Boots",
	items.LEATHER_CAP:"Leather Cap",
	items.IRON_SWORD:"Iron Sword",
	items.BRONZE_SWORD:"Bronze Sword",
	items.SILVER_SWORD:"Silver Sword"
	}

func get_item_instance(item: int) -> Object:
	match (item):
		items.BRONZE_SWORD: return bronze_sword.instance()
		items.IRON_SWORD: return iron_sword.instance()
		items.SILVER_SWORD: return silver_sword.instance()
		_: return iron_sword.instance()


func get_item_name(number):
	return item_keys.get(number)

func get_random_item_lvl1():
	Utilities.rng.randomize()
	return get_item_instance(get_random_lvl1_item())

func get_random_lvl1_item():
	var chest_items = [items.BRONZE_SWORD, items.SILVER_SWORD, items.IRON_SWORD]
	return chest_items[randi()%chest_items.size()]
