extends Node

class_name BaseParty

var party = []
var rng = Utilities.rng
var unit_formation = {BattleEnums.BattleRows.FIRST_BACK: null, BattleEnums.BattleRows.SECOND_BACK: null,
	BattleEnums.BattleRows.THIRD_BACK: null, BattleEnums.BattleRows.FIRST_FRONT: null,
	BattleEnums.BattleRows.SECOND_FRONT: null, BattleEnums.BattleRows.THIRD_FRONT: null }

func set_random_position(unit) -> void:
	rng.randomize()
	var free_pos = get_free_positions()
	var pos = free_pos[rng.randi_range(0, free_pos.size()-1)]
	unit_formation[pos] = unit
	unit.set_current_battle_position(pos)	

func add_unit(_position, unit):
	var new_unit = unit.instance()
	add_child(new_unit)
	set_unit_position(new_unit.get_prefered_position(), new_unit)

func set_unit_position(prefered_pos: Array, unit) -> void:
	var unit_set = false
	for pos in prefered_pos:
		if unit_formation.get(pos) == null:
			unit_set = true
			unit_formation[pos] = unit
			unit.set_current_battle_position(pos)
			break
	if unit_set == false:
		set_random_position(unit)

func get_free_positions() -> Array:
	var free_keys = []
	for pos in unit_formation:
		if unit_formation[pos] == null:
			free_keys.append(pos)
	return free_keys

func get_party() -> Dictionary:
	return unit_formation
