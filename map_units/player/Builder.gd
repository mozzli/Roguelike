extends MapUnit

class_name Builder

var movement = 4
var vision = 3
var unit = StatEnums.unit_class.BUILDER
var gui_image = load("res://images/Characters/builder/GUI/gui_builder.png")

func _ready():
	movement_value = movement
	vision_range = vision
	unit_class = unit
	GameVariables.active_units.append(self)
	$PlayerParty.add_unit(BattleEnums.BattleRows.SECOND_FRONT, EnemiesList.get_player_node(EnemiesList.player.BUILDER))
	get_item(GlobalItems.iron_sword.instance())
	$Items.equip_left_hand($Items/IronSword)

func get_gui_image():
	return gui_image
