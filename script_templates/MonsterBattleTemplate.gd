extends BaseBattleUnit

class_name MonsterName
 
remote var monster_min_hp: int = 0
remote var monster_max_hp: int = 0
remote var monster_min_strenght: int = 0 
remote var monster_max_strenght: int = 0
remote var monster_min_dexterity: int = 0
remote var monster_max_dexterity: int = 0
remote var monster_min_agility: int = 0
remote var monster_max_agility: int = 0
remote var monster_min_wisdom: int = 0
remote var monster_max_wisdom: int = 0
var monster_unit_picture: String = "path to picture"

var monster_prefered_position: Array = [BattleEnums.BattleRows.SECOND_FRONT]

func _ready():
	set_max_hp(monster_max_hp)
	set_max_str(monster_max_strenght)
	set_max_dex(monster_max_dexterity)
	set_max_agi(monster_max_agility)
	set_max_wis(monster_max_wisdom)
	set_min_hp(monster_min_hp)
	set_min_str(monster_min_strenght)
	set_min_dex(monster_min_dexterity)
	set_min_agi(monster_min_agility)
	set_min_wis(monster_min_wisdom)
	prefered_position = monster_prefered_position
	unit_picture = monster_unit_picture
	set_status_points()

func set_hp(amount) -> void:
	hp = amount

func get_hp() -> int:
	return hp

func set_dex(amount) -> void:
	dexterity = amount

func get_dex() -> int:
	return dexterity

func set_str(amount) -> void:
	strenght = amount

func get_str() -> int:
	return strenght

func set_agi(amount) -> void:
	agility = amount

func get_agi() -> int:
	return agility

func set_wis(amount) -> void:
	wisdom = amount

func get_wis() -> int:
	return wisdom

func set_random_hp() -> void:
	set_hp(rng.randi_range(min_hp,max_hp))

func set_random_str() -> void:
	set_str(rng.randi_range(min_strenght,max_strenght))

func set_random_dex() -> void:
	set_dex(rng.randi_range(min_dexterity,max_dexterity))

func set_random_agi() -> void:
	set_agi(rng.randi_range(min_agility,max_agility))

func set_random_wis() -> void:
	set_wis(rng.randi_range(min_wisdom,max_wisdom))

func set_status_points() -> void:
	set_random_hp()
	set_random_str()
	set_random_dex()
	set_random_agi()
	set_random_wis()

func get_prefered_position() -> Array:
	return prefered_position

func get_unit_picture() -> String:
	return unit_picture
