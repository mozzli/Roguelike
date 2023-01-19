extends Control

onready var panels = get_tree().get_nodes_in_group("side_gui_units")

func get_free_space() -> Panel:
	for panel in panels:
		if !panel.get_is_on():
			return panel
	return null

func reset_panels():
	for panel in panels:
		panel.turn_panel_off()

func set_unit(unit: MapUnit):
	var free_panel = get_free_space()
	free_panel.turn_panel_on(unit)
