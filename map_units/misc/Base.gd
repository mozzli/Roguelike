extends Area2D

var vision_range = 3
var fog_of_war_visibility = []
var current_cell
var fog_of_war_class = GameVariables.current_map.get_node("FogOfWar")

func _process(_delta):
	current_cell = WalkCode.mouse_position
	fog_of_war_class.show_tiles(fog_of_war_visibility)
	GameVariables.current_map.update_minimap_visibility()

func focus_camera():
	GameVariables.current_map.change_camera_position(position)

func get_tile_position() -> Vector2:
	return MovementUtils.map.world_to_map(get_global_position())
