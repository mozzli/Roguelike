extends Control

func _on_OptionsButton_button_up():
	$MainPopup.hide()
	$OptionsPopup.popup()
	
func _on_ExitButton_button_up():
	get_tree().quit()

func _on_OptionsBackButton_button_up():
	$OptionsPopup.hide()
	$MainPopup.popup()

func _on_SoundBackButton_button_up():
	$SoundPopup.hide()
	$OptionsPopup.popup()

func _on_VolumeButton_button_up():
	$OptionsPopup.hide()
	$SoundPopup.popup()

func _on_AboutExitButton_button_up():
	$AboutPopup.hide()
	$MainPopup.popup()

func _on_AboutButton_button_up():
	$MainPopup.hide()
	$AboutPopup.popup()
