extends "res://party_nodes/BaseParty.gd"

var party = []
var enemies_nodes = []
var unit_formation = {BattleEnums.BattleRows.FIRST_BACK: null, BattleEnums.BattleRows.SECOND_BACK: null,
	BattleEnums.BattleRows.THIRD_BACK: null, BattleEnums.BattleRows.FIRST_FRONT: null,
	BattleEnums.BattleRows.SECOND_FRONT: null, BattleEnums.BattleRows.THIRD_FRONT: null }
var max_party_amount = 4
var party_monster_type = [EnemiesList.enemies.BOAR]
var rng = Utilities.rng

func get_random_party():
	rng.randomize()
	var party_amount = rng.randi_range(1,max_party_amount)
	for i in party_amount:
		rng.randomize()
		var monster = party_monster_type[rng.randi_range(0,party_monster_type.size() - 1)]
		party.append(monster)
	create_party()

func create_party():
	for monster in party:
		var monster_node = EnemiesList.get_enemy_node(monster)
		var new_monster = monster_node.instance()
		add_child(new_monster)
		enemies_nodes.append(new_monster)
		set_unit_position(new_monster.get_prefered_position(), new_monster)
	print(enemies_nodes)
	print(unit_formation)

func set_random_position(unit) -> void:
	rng.randomize()
	var free_pos = get_free_positions()
	var pos = free_pos[rng.randi_range(0, free_pos.size()-1)]
	unit_formation[pos] = unit

func set_unit_position(prefered_pos: Array, unit) -> void:
	var unit_set = false
	for pos in prefered_pos:
		if unit_formation.get(pos) == null:
			unit_set = true
			unit_formation[pos] = unit
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
