extends Control

func open_treasure_event(item_name):
	$Popup/Sprite/Label.text = "You've got " + item_name + "!"
	$Popup/Sprite.scale.x = GameVariables.camera_zoom
	$Popup/Sprite.scale.y = GameVariables.camera_zoom
	$Popup.set_position(get_node("../Camera2D").position - Vector2(225,175))
	$Popup.popup()
	GameVariables.gui_is_on = true


func _on_Button_button_up():
	GameVariables.gui_is_on = false
	$Popup.hide()
	
