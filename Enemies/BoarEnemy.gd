extends Node2D

var rng = Utilities.rng

var hp setget set_hp, get_hp
remote var min_hp = 15
remote var max_hp = 32
var strenght setget set_str, get_str
remote var min_strenght = 5 
remote var max_strenght = 8
var dexterity setget set_dex, get_dex
remote var min_dexterity = 5
remote var max_dexterity = 8
var agility setget set_agi, get_agi
remote var min_agility = 10
remote var max_agility = 15
var wisdom setget set_wis, get_wis
remote var min_wisdom = 0
remote var max_wisdom = 3

func _ready():
	set_status_points()
#	print("hp: ", hp, ", strenght: ", strenght, ", dex: ", dexterity, ", agi: ", agility, ", wis: ", wisdom)

func set_hp(amount):
	hp = amount

func get_hp():
	return hp

func set_dex(amount):
	dexterity = amount

func get_dex():
	return dexterity

func set_str(amount):
	strenght = amount

func get_str():
	return strenght

func set_agi(amount):
	agility = amount

func get_agi():
	return agility

func set_wis(amount):
	wisdom = amount

func get_wis():
	return wisdom

func set_random_hp():
	set_hp(rng.randi_range(min_hp,max_hp))

func set_random_str():
	set_str(rng.randi_range(min_strenght,max_strenght))

func set_random_dex():
	set_dex(rng.randi_range(min_dexterity,max_dexterity))

func set_random_agi():
	set_agi(rng.randi_range(min_agility,max_agility))

func set_random_wis():
	set_wis(rng.randi_range(min_wisdom,max_wisdom))

func set_status_points():
	set_random_hp()
	set_random_str()
	set_random_dex()
	set_random_agi()
	set_random_wis()
