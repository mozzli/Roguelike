extends MapUnit

class_name Builder

var movement = 4
var vision = 3
var unit = StatEnums.unit_class.BUILDER

func _ready():
	image = load("res://images/Characters/builder/idle/Sprite-0002.png")
	gui_image = load("res://images/Characters/builder/GUI/gui_builder.png")
	movement_value = movement
	vision_rang = vision
	unit_class = unit
	GameVariables.active_units.append(self)
	$PlayerParty.add_unit(BattleEnums.BattleRows.SECOND_FRONT, EnemiesList.get_player_node(EnemiesList.player.BUILDER))
	$PlayerParty.add_unit(BattleEnums.BattleRows.FIRST_FRONT, EnemiesList.get_player_node(EnemiesList.player.BUILDER))
	$Items.equip_right_hand(IronSword.new())
