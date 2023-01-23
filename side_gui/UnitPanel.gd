extends Panel

class_name UnitGui

onready var status_window: StatusWindow = $"../../../../..".get_node("StatusWindowLayer/StatusWindow")
var is_on = false
var map_unit = null
var mouse_on = false

func turn_panel_on(unit: MapUnit):
	map_unit = unit
	$Panel.show()
	$Button.show()
	$Panel.texture = unit.get_gui_image()
	if unit.check_if_end_of_turn():
		player_moved()
	else:
		player_refreshed()
	is_on = true
	unit.gui_panel_placement = self

func turn_panel_off():
	map_unit = null
	$Panel.hide()
	$Button.hide()
	is_on = false

func get_is_on() -> bool:
	return is_on

func player_moved():
	$Panel.modulate.a8 = 140

func player_refreshed():
	$Panel.modulate.a8 = 255

func _input(event):
	if event.is_action_pressed("ui_down"):
		player_moved()
	if event.is_action_pressed("ui_up"):
		player_refreshed()

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_click_left") && is_on:
			map_unit.focus_camera()
			if !map_unit.check_if_end_of_turn():
				map_unit.select_player()

func _on_Button_pressed():
	status_window.load_box(map_unit)
