extends Control

var resolution
var pause_is_on = false
onready var music = $"../../Audio"
onready var camera = $"../../Camera2D"

func _ready():
	resolution = get_viewport_rect().size
	rect_size = resolution
	$MainMenu.rect_size = resolution

func pause_on():
	$MainMenu.popup_centered()
	$MainMenu/Popup.popup()
	GameVariables.gui_is_on = true
	pause_is_on = true
	get_tree().paused = true

func hideAllPopups() -> void:
	get_tree().paused = false
	$MainMenu.hide()
	$MainMenu/Popup.hide()
	$MainMenu/SoundOptions.hide()
	GameVariables.gui_is_on = false
	$Timer.start()
	
func _on_Button_button_up():
	get_tree().paused = false
	$MainMenu.hide()
	$MainMenu/Popup.hide()
	GameVariables.gui_is_on = false
	pause_is_on = false

func _on_OptionsButton_button_up():
	$MainMenu/Popup.hide()
	$MainMenu/SoundOptions.popup()

func _on_OptionsBackButton_button_up():
	$MainMenu/SoundOptions.hide()
	$MainMenu/Popup.popup()

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel") && pause_is_on:
			hideAllPopups()

func _on_Timer_timeout():
	pause_is_on = false

func _on_MainMenuButton_button_up():
	get_tree().paused = false
	GameVariables.map_on = false
	if (get_tree().change_scene_to(GameVariables.main_menu) == 0):
		print("Map loading successful")
	else:
		print("Map loading failed")

