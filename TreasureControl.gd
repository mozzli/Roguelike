extends Control

func open_treasure_event(item_name):
	$Popup/Label.text = "You've got " + item_name + "!"
	$Popup.popup_centered()


func _on_Button_button_up():
	$Popup.hide()
