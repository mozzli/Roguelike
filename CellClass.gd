extends Node
var cube_coordinates: Vector3
var coordinates: Vector2
var type
var t_value
var h_value
var f_value
var road =[]

func _init(vector2, vector3):
	cube_coordinates = vector3
	coordinates = vector2
	type = MovementUtils.map.get_cell(coordinates.x, coordinates.y)
	t_value = MovementUtils.get_movement_value_by_index(type)

func get_h_value(goal_cell):
	var goal = goal_cell.get_cubed_coordinates()
	var vector_list = []
	vector_list.append(abs(cube_coordinates.x - goal.x))
	vector_list.append(abs(cube_coordinates.y - goal.y))
	vector_list.append(abs(cube_coordinates.z - goal.z))
	return vector_list.max()

func get_cubed_coordinates():
	return cube_coordinates

func get_new_f_value(old_t_value, goal_cell):
	var new_h_value = get_h_value(goal_cell)
	var new_t_value = old_t_value + MovementUtils.get_movement_value_by_index(type)
	return new_t_value + new_h_value

func set_f_value(goal_cell):
	h_value = get_h_value(goal_cell)
	f_value = t_value + h_value

func get_f_value(goal_cell):
	h_value = get_h_value(goal_cell)
	return (t_value + h_value)

func set_t_value(base_value):
	t_value = base_value + MovementUtils.get_movement_value_by_index(type)

func get_t_value(base_value):
	return base_value + MovementUtils.get_movement_value_by_index(type)

func clear_cell():
	f_value = null
	h_value = null
	t_value = MovementUtils.get_movement_value_by_index(type)
	road.clear()
