extends Line2D

var new_texture = load("res://icon.png")
var texture_node: TextureRect

func _ready():
	texture_node = TextureRect.new()
	texture_node.texture = new_texture
	self.add_child(texture_node)
	texture_node.visible = false
	texture_node.modulate.a8 = 155
	texture_node.expand = true
	texture_node.rect_size = Vector2(32,32)

func create_path(starting_point: Vector2, goal_point: Vector2) -> void:
	var starting_node = MovementUtils.cell_dictionary.get(starting_point)
	var goal_node = MovementUtils.cell_dictionary.get(goal_point)
	for cell in MovementUtils.cell_dictionary.values():
		cell.clear_cell()
	clear_points()
	var points: PoolVector2Array = AStarMovement.get_fastest_route(starting_node,goal_node)
	for i in range(0, points.size()):
		self.add_point(MovementUtils.map.map_to_world(points[i]) + Vector2(32,24))
	texture_node.visible = true
	print(MovementUtils.map.map_to_world(points[points.size() - 1]) + Vector2(32,24))
	texture_node.rect_position = MovementUtils.map.map_to_world(points[points.size() - 1]) + Vector2(16,8)

func hide_texture():
	texture_node.visible = false

func change_texture(texture):
	texture_node.texture = texture
