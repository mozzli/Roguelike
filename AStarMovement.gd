extends Node

func get_fastest_route(starting_cell: Node, goal_cell: Node):
	var cells_to_check = [starting_cell]
	var checked_cells = []
	
	while !checked_cells.has(goal_cell):
		var cell_to_check
		var lowest_f_value
		for cell in cells_to_check:
			var f_value = cell.f_value
			if lowest_f_value == null || lowest_f_value > f_value :
				lowest_f_value = f_value
				cell_to_check = cell
			elif f_value == lowest_f_value && cell.h_value < cell_to_check.h_value:
				lowest_f_value = f_value
				cell_to_check = cell
		
		if (cell_to_check == goal_cell):
			cell_to_check.road.append(cell_to_check.coordinates)
			var points: PoolVector2Array = PoolVector2Array()
			for point in cell_to_check.road:
				points.append(Vector2(point[0], point[1]))
			return(points)
		
		var neighbors = []
		neighbors = MovementUtils.get_neighbour_cells(cell_to_check)
		
		if cell_to_check.road.empty():
			cell_to_check.road.append(cell_to_check.coordinates)
		
		for cell in neighbors:
			if (!cell == null):
				if cell.f_value == null:
					cell.set_t_value(cell_to_check.t_value)
					cell.set_f_value(goal_cell)
					set_cell_road(cell, cell_to_check)
					if !checked_cells.has(cell) && !cells_to_check.has(cell):
						cells_to_check.append(cell)
				else:
					if cell.f_value > cell.get_new_f_value(cell_to_check.t_value, goal_cell):
						cell.set_t_value(cell_to_check.t_value)
						cell.f_value = cell.get_new_f_value(cell_to_check.t_value, goal_cell)
						set_cell_road(cell, cell_to_check)
		
		cells_to_check.erase(cell_to_check)
		checked_cells.append(cell_to_check)

func set_cell_road(new_cell: Node, cell_to_check):
	new_cell.road.clear()
	new_cell.road.append_array(cell_to_check.road)
	new_cell.road.append(new_cell.coordinates)
