extends Line2D

func create_path(starting_point: Vector2, goal_point: Vector2) -> void:
	var starting_node = MovementUtils.cell_dictionary.get(starting_point)
	var goal_node = MovementUtils.cell_dictionary.get(goal_point)
	for cell in MovementUtils.cell_dictionary.values():
		cell.clear_cell()
	clear_points()
	var points: PoolVector2Array = AStarMovement.get_fastest_route(starting_node,goal_node)
	for i in range(0, points.size()):
		self.add_point(MovementUtils.map.map_to_world(points[i]) + Vector2(32,24))
