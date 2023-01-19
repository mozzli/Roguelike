extends Button

var blocked_tiles: Array = [MovementUtils.tiles.LAKE,
 MovementUtils.tiles.MOUNTAINS,
 MovementUtils.tiles.MOUNTAINS_WITH_RIVER,
 MovementUtils.tiles.RIVER,
 MovementUtils.tiles.TOWN]

func _ready():
	blocked_tiles.append_array(MovementUtils.RIVER_TILES)

func _process(_delta):
	if (GameVariables.caravan != null && !blocked_tiles.has(MovementUtils.map.get_cell(GameVariables.caravan.get_tile().x, GameVariables.caravan.get_tile().y))):
		visible = true
	else:
		visible = false
