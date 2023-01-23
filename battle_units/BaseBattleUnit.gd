extends Node

class_name BaseBattleUnit

var rng = Utilities.rng

var hp
var current_hp
var min_hp: int
var max_hp: int
var strenght
var min_strenght: int
var max_strenght: int
var dexterity
var min_dexterity: int
var max_dexterity: int
var agility
var min_agility: int
var max_agility: int
var wisdom
var min_wisdom: int
var max_wisdom: int
var unit_picture: Texture
var unit_type
var current_battle_position
var unit_name
var alive = true

const TICK_BASE_COUNTER = 1000
var tick_value

var prefered_position: Array

func _ready():
	set_random_status_points()

func set_stat(amount: int, stat: int) -> void:
	match(stat):
		StatEnums.stat_enums.HP: hp = amount
		StatEnums.stat_enums.CURRENT_HP: current_hp = amount
		StatEnums.stat_enums.STR: strenght = amount
		StatEnums.stat_enums.WIS: wisdom = amount
		StatEnums.stat_enums.AGI: agility = amount
		StatEnums.stat_enums.DEX: dexterity = amount

func get_stat(stat: int) -> int:
	match(stat):
		StatEnums.stat_enums.HP: return hp
		StatEnums.stat_enums.CURRENT_HP: return current_hp
		StatEnums.stat_enums.STR: return strenght
		StatEnums.stat_enums.WIS: return wisdom
		StatEnums.stat_enums.AGI: return agility
		StatEnums.stat_enums.DEX: return dexterity
		_: return -9999

func lower_stat(amount: int, stat: int) -> void:
	match(stat):
		StatEnums.stat_enums.HP: hp -= amount
		StatEnums.stat_enums.CURRENT_HP: current_hp -= amount
		StatEnums.stat_enums.STR: strenght -= amount
		StatEnums.stat_enums.WIS: wisdom -= amount
		StatEnums.stat_enums.AGI: agility -= amount
		StatEnums.stat_enums.DEX: dexterity -= amount
	if current_hp <= 0:
		alive = false

func raise_stat(amount: int, stat: int) -> void:
	match(stat):
		StatEnums.stat_enums.HP: hp += amount
		StatEnums.stat_enums.CURRENT_HP: current_hp += amount
		StatEnums.stat_enums.STR: strenght += amount
		StatEnums.stat_enums.WIS: wisdom += amount
		StatEnums.stat_enums.AGI: agility += amount
		StatEnums.stat_enums.DEX: dexterity += amount

func set_random_hp() -> void:
	set_stat(rng.randi_range(min_hp,max_hp), StatEnums.stat_enums.HP)
	current_hp = hp

func set_random_str() -> void:
	set_stat(rng.randi_range(min_strenght,max_strenght), StatEnums.stat_enums.STR)

func set_random_dex() -> void:
	set_stat(rng.randi_range(min_dexterity,max_dexterity), StatEnums.stat_enums.DEX)

func set_random_agi() -> void:
	set_stat(rng.randi_range(min_agility,max_agility), StatEnums.stat_enums.AGI)

func set_random_wis() -> void:
	set_stat(rng.randi_range(min_wisdom,max_wisdom), StatEnums.stat_enums.WIS)

func set_random_status_points() -> void:
	set_random_hp()
	set_random_str()
	set_random_dex()
	set_random_agi()
	set_random_wis()

func get_prefered_position() -> Array:
	return prefered_position

func get_unit_picture() -> Texture:
	return unit_picture

func set_max_hp(value):
	max_hp = value

func set_max_str(value):
	max_strenght = value

func set_max_dex(value):
	max_dexterity = value

func set_max_agi(value):
	max_agility = value

func set_max_wis(value):
	max_wisdom = value

func set_min_hp(value):
	min_hp = value

func set_min_str(value):
	min_strenght = value

func set_min_dex(value):
	min_dexterity = value

func set_min_agi(value):
	min_agility = value

func set_min_wis(value):
	min_wisdom = value

func get_unit_type() -> String:
	return unit_type

func set_unit_type(type: String) -> void:
	unit_type = type

func get_current_battle_position() -> int:
	return current_battle_position

func set_current_battle_position(position: int):
	current_battle_position = position

func get_tick_value() -> int:
	return tick_value

func get_base_tick_value() -> int:
	return TICK_BASE_COUNTER/agility

func get_next_tick_value() -> int:
	return get_tick_value() + get_base_tick_value()

func set_next_tick_value() -> void:
	tick_value = get_next_tick_value()

func reset_ticks():
	tick_value = get_base_tick_value()

func set_unit_name(name: String):
	unit_name = name

func get_unit_name() -> String:
	return unit_name

func get_if_alive() -> bool:
	return alive

func get_percent_of_hp() -> int:
	if current_hp <= 0:
		return 100
	else:
		return 100 - ((current_hp*100)/hp)

func use_attack(attack: int) -> int:
	var damage = Attacks.get_damage(attack, self)
	return damage
	
