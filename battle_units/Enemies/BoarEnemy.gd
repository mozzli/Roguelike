extends BaseMonsterUnit

class_name BattleBoar
 
remote var monster_min_hp = 15
remote var monster_max_hp = 32
remote var monster_min_strenght = 5 
remote var monster_max_strenght = 8
remote var monster_min_dexterity = 5
remote var monster_max_dexterity = 9
remote var monster_min_agility = 5
remote var monster_max_agility = 8
remote var monster_min_wisdom = 0
remote var monster_max_wisdom = 3
var monster_unit_picture = "res://images/Enemies/Boar/boar2.png"
var type = "enemy"
var u_name ="Boar"
var attacks = [Attacks.attack_enums.BASIC_ATTACK]
var item_drop: Dictionary = {GlobalItems.items.SILVER_SWORD: 10, GlobalItems.items.BRONZE_SWORD: 50, GlobalItems.items.IRON_SWORD: 25}
var min_money_drop = 100
var max_money_drop = 134

var monster_prefered_position = [BattleEnums.BattleRows.SECOND_FRONT, 
	BattleEnums.BattleRows.FIRST_FRONT, 
	BattleEnums.BattleRows.THIRD_FRONT]

func _ready():
	set_unit_type(type)
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
	set_random_status_points()
	prefered_position = monster_prefered_position
	unit_picture = monster_unit_picture
	set_unit_name(u_name)
	set_money_amount(min_money_drop, max_money_drop)
	set_items_to_gain(item_drop)

func use_random_attack() -> int:
	randomize()
	var current_attack = attacks[rng.randi_range(0, attacks.size() - 1)]
	return Attacks.get_damage(current_attack, self)
