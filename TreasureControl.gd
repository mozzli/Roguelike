extends Control

func open_treasure_event(item: Items):
	var name: String = item.get_item_name()
	$Popup/Sprite/Label.text = "You've got " + name + "!"
	$Popup/Sprite/ItemImage.texture = item.get_image()
	$Popup.popup()
	GameVariables.gui_is_on = true

func _on_Button_button_up():
	GameVariables.gui_is_on = false
	$Popup.hide()
