extends BaseMonsterParty

class_name BoarParty

var max_units = 4
var party_units = [EnemiesList.enemies.BOAR]

func _ready():
	set_max_party_amount(max_units)
	set_monster_party_units(party_units)
