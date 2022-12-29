extends CanvasLayer

func play_shader():
	$ColorRect/AnimationPlayer.play("Fade_out")

func _on_AnimationPlayer_animation_finished(_anim_name):
	pass # Replace with function body.
