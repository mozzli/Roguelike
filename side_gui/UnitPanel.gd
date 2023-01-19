extends Panel

var is_on = false
var map_unit = null
var mouse_on = false

func turn_panel_on(unit: MapUnit):
	map_unit = unit
	$Panel.show()
	$Button.show()
	$Panel.texture = unit.get_gui_image()
	is_on = true

func turn_panel_off():
	map_unit = null
	$Panel.hide()
	$Button.hide()
	is_on = false

func get_is_on() -> bool:
	return is_on


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_click_left") && is_on:
			map_unit.focus_camera()
