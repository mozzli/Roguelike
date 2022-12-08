extends BaseParty

class_name BaseMonsterParty

var max_party_amount = 4
var party_monster_type = [EnemiesList.enemies.BOAR]

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
		set_unit_position(new_monster.get_prefered_position(), new_monster)

func set_max_party_amount(amount):
	max_party_amount = amount

func set_monster_party_units(units: Array):
	party_monster_type = units

func get_party_money() -> int:
	var money: int = 0
	var party = get_party()
	for unit in party:
		if party[unit] != null:
			money += party[unit].get_enemy_money()
	return money

func get_party_items() -> Array:
	var items: Array = []
	var party = get_party()
	for unit in party:
		if party[unit] != null:
			items.append_array(party[unit].get_enemy_items())
	return items
