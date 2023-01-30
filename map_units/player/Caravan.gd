extends MapUnit

class_name Caravan

var movement = 2
var vision = 3
var unit = StatEnums.unit_class.CARAVAN

func _ready():
	image = load("res://images/Characters/caravan/caravan.png")
	gui_image = load("res://images/Characters/caravan/gui_caravan.png")
	movement_value = movement
	vision_rang = vision
	unit_class = unit
	GameVariables.active_units.append(self)
	$PlayerParty.add_unit(BattleEnums.BattleRows.SECOND_FRONT, EnemiesList.get_player_node(EnemiesList.player.BUILDER))

func create_town():
	GameVariables.current_map.spawn_base(MovementUtils.movement_tiles.world_to_map(position))
	delete_unit()
	GameVariables.caravan = null
#	self.queue_free()

func get_map_cell():
	MovementUtils.map.get_cell(10,10)

func get_gui_image():
	return gui_image
