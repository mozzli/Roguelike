extends Node2D

var party = []
var enemies_nodes = []
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
	print(enemies_nodes)
