extends KinematicBody2D

class_name MapUnit

var gui_image
var image
var shadow_texture: Node2D
var mouse_floats = false
var selected = false
var fog_of_war_class = GameVariables.current_map.get_node("FogOfWar")
var path_creator = GameVariables.current_map.get_node("PathLineCreator")
var end_of_turn = false
var old_position
var fog_of_war_visibility = []
var movement_on = true
var mouse_cell
var current_cell
var movement_value
var vision_rang
var unit_class
var gui_panel_placement

func _input(event):
	if event.is_action_pressed("mouse_click_left") && not mouse_floats:
		left_click_check(event)
		GameVariables.current_map.update_minimap()
	if event is InputEventMouseButton && selected:
		if event.is_action_pressed("mouse_click_right"):
			reset_player_position()

func _process(_delta):
	mouse_cell = WalkCode.mouse_position
	var selected_cell
	var movement_tiles = MovementUtils.movement_tiles.get_cell(WalkCode.mouse_position[0], WalkCode.mouse_position[1])
	if(selected && mouse_cell != selected_cell && movement_tiles == 0):
		var builder_position_cell = MovementUtils.movement_tiles.world_to_map(global_position)
		path_creator.create_path(builder_position_cell,mouse_cell)
		selected_cell = mouse_cell
	fog_of_war_class.show_tiles(fog_of_war_visibility)
	GameVariables.current_map.update_minimap_visibility()

func left_click_check(event):
	if event.is_action_pressed("mouse_click_left") && selected && (MovementUtils.map.world_to_map(old_position) != WalkCode.mouse_position):
		if (WalkCode.get_movement_cell() == 0):
			move_player()
		elif (WalkCode.get_movement_cell() == -1):
			reset_player_position()

func new_turn():
	end_of_turn = false
	gui_panel_placement.player_refreshed()
	ColorManager.change_color_default($AnimatedSprite)

func play_object_event():
	GameVariables.object_under_player.play_event()
	
func move_player():
	if GameVariables.current_map.fog_on:
		fog_of_war_class.hide_tiles(fog_of_war_visibility)
	fog_of_war_class.set_visibility(mouse_cell.x, mouse_cell.y, self)
	global_position = MovementUtils.movement_tiles.map_to_world(WalkCode.mouse_position)+Vector2(32,24)
	end_turn()
	if GameVariables.object_under_player != null:
		play_object_event()

func reset_player_position():
	deselect_player()
	global_position = old_position
	ColorManager.change_color_default($AnimatedSprite)

func select_player():
	old_position = global_position
	selected = true
	path_creator.change_texture(image)
	GameVariables.map_selected_unit = self
	WalkCode.get_movement_distance(get_position_on_map(global_position),
	movement_value, null)
	ColorManager.change_color_selected($AnimatedSprite)
	input_pickable = false

func deselect_player():
	WalkCode.reset_movement_tiles()
	path_creator.clear_points()
	path_creator.hide_texture()
	selected = false
	GameVariables.map_selected_unit = null
	$AnimatedSprite.speed_scale = 1
	input_pickable = true

func delete_unit():
	GameVariables.active_units.erase(self)
	GameVariables.current_map.update_gui_units()
	fog_of_war_class.hide_tiles(fog_of_war_visibility)
	self.queue_free()

func gain_money(amount: int) -> void:
	$Items.add_money(amount)

func end_turn():
	deselect_player()
	gui_panel_placement.player_moved()
	end_of_turn = true
	ColorManager.change_color_end_turn($AnimatedSprite)

func focus_camera():
	GameVariables.current_map.change_camera_position(position)

func check_if_end_of_turn():
	return end_of_turn

func add_item(item: Items):
	return $Items.add_new_item(item)

func reset_visibility():
	var map_pos = MovementUtils.movement_tiles.world_to_map(global_position)
	fog_of_war_class.hide_tiles(fog_of_war_visibility)
	fog_of_war_class.set_visibility(map_pos.x, map_pos.y, self)

func get_vision():
	if GameVariables.daytime == GameVariables.day_cycle.NIGHT:
		return vision_rang - 1
	return vision_rang

func get_unit_class() -> int:
	return unit_class

func get_item_box():
	return $Items.item_box

func get_equipement_box():
	return $Items.equiped_items

func get_party() -> Dictionary:
	return $PlayerParty.get_party()

func get_position_on_map(pos):
	return MovementUtils.map.world_to_map(pos)

func get_tile():
	return MovementUtils.map.world_to_map(position)

func get_gui_image():
	return gui_image

func _on_KinematicBody2D_mouse_entered():
	mouse_floats = true

func _on_KinematicBody2D_mouse_exited():
	mouse_floats = false

func _on_KinematicBody2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_click_left") && not end_of_turn && not selected:
			select_player()
