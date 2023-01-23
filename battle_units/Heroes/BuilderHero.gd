extends BaseBattleUnit

class_name BuilderHero

remote var unit_min_hp = 100
remote var unit_max_hp = 105
remote var unit_min_strenght = 10
remote var unit_max_strenght = 15
remote var unit_min_dexterity = 5
remote var unit_max_dexterity = 8
remote var unit_min_agility = 7
remote var unit_max_agility = 9
remote var unit_min_wisdom = 0
remote var unit_max_wisdom = 3
var player_unit_picture = load("res://images/Enemies/Boar/boar.png")
var type = "player"
var u_name = "Mark"

var unit_prefered_position = [BattleEnums.BattleRows.SECOND_FRONT, 
	BattleEnums.BattleRows.FIRST_FRONT, 
	BattleEnums.BattleRows.THIRD_FRONT]

func _init():
	set_unit_type(type)
	set_max_hp(unit_max_hp)
	set_max_str(unit_max_strenght)
	set_max_dex(unit_max_dexterity)
	set_max_agi(unit_max_agility)
	set_max_wis(unit_max_wisdom)
	set_min_hp(unit_min_hp)
	set_min_str(unit_min_strenght)
	set_min_dex(unit_min_dexterity)
	set_min_agi(unit_min_agility)
	set_min_wis(unit_min_wisdom)
	set_random_status_points()
	prefered_position = unit_prefered_position
	unit_picture = player_unit_picture
	set_unit_name(u_name)
