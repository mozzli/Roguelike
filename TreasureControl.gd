extends Control

func open_treasure_event(item: Items):
	var name: String = item.get_item_name()
	$Popup/Sprite/Label.text = "You've got " + name + "!"
	$Popup/Sprite.scale = GameVariables.camera_zoom
	$Popup/Sprite/ItemImage.texture = load(item.get_image())
	$Popup.popup()
	GameVariables.gui_is_on = true

func _on_Button_button_up():
	GameVariables.gui_is_on = false
	$Popup.hide()
	
func _process(_delta):
	$Popup.set_position(get_node("../Camera2D").get_camera_position() - Vector2(225,175))
	$Popup/Sprite.scale = GameVariables.camera_zoom
