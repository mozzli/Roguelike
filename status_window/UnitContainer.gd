extends GridContainer

var default_texture =  load("res://images/Battle/unit_box.png")

var grid_position = {}

func _ready():
	grid_position[BattleEnums.BattleRows.FIRST_BACK] = $TextureButton1
	grid_position[BattleEnums.BattleRows.FIRST_FRONT] = $TextureButton2
	grid_position[BattleEnums.BattleRows.SECOND_BACK] = $TextureButton3
	grid_position[BattleEnums.BattleRows.SECOND_FRONT] = $TextureButton4
	grid_position[BattleEnums.BattleRows.THIRD_BACK] = $TextureButton5
	grid_position[BattleEnums.BattleRows.THIRD_FRONT] = $TextureButton6
	reset_grid()

func load_unit_texture(party: Dictionary):
	print(party)
	for unit in range(0,6):
		grid_position.get(unit).load_unit(party.get(unit))
		grid_position.get(unit).party = party
		grid_position.get(unit).grid_pos = unit
		grid_position.get(unit).refresh_damage()

func reset_grid():
	for pic in grid_position:
		grid_position.get(pic).texture_normal = default_texture

func refresh_party():
	for unit in get_tree().get_nodes_in_group("status_unit_boxes"):
		unit.refresh_party()


