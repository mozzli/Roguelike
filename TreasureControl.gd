extends Control

func open_treasure_event(item_name):
	$Popup/Sprite/Label.text = "You've got " + item_name + "!"
	$Popup/Sprite.scale = GameVariables.camera_zoom
	$Popup.popup()
	GameVariables.gui_is_on = true


func _on_Button_button_up():
	GameVariables.gui_is_on = false
	$Popup.hide()
	
func _process(_delta):
	$Popup.set_position(get_node("../Camera2D").get_camera_position() - Vector2(225,175))
	$Popup/Sprite.scale = GameVariables.camera_zoom
