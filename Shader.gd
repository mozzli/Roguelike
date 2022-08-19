extends ColorRect

func _ready():
	$AnimationPlayer.play("Fade_out")
	$Timer.start()

func _on_Timer_timeout():
	get_parent().layer = -2
	$Timer.stop()
