extends Sprite

func _process(_delta):
	if get_tree().paused == true:
		visible = false
	else:
		visible = true
