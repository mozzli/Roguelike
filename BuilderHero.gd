extends Node2D

var hp setget set_hp, get_hp
var strenght setget set_str, get_str
var dexterity setget set_dex, get_dex
var agility setget set_agi, get_agi
var wisdom setget set_wis, get_wis



func _ready():
	pass

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
