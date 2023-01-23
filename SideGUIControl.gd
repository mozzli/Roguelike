extends Control

var resolution

func _process(_delta):
	if GameVariables.enemies_turn_on:
		$EndTurnButton.disabled = true
	else:
		$EndTurnButton.disabled = false

func _ready():
	resolution = get_viewport_rect().size
	rect_size.y = resolution.y
	$ColorRect.rect_size = resolution

func update_unit_panel():
	$UnitGUIControl.reset_panels()
	for unit in GameVariables.active_units:
		$UnitGUIControl.set_unit(unit)

func _on_EndTurnButton_pressed():
	GameVariables.new_turn()

func _on_BuildButton_pressed():
	GameVariables.caravan.create_town()
	$BaseGUIControl/BasePanel.visible = true

func _on_MenuButton_pressed():
	GameVariables.current_map.pause_on()
