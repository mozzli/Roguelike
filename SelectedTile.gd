extends Sprite

func _process(delta):
	if get_tree().paused == true:
		visible = false
	else:
		visible = true
