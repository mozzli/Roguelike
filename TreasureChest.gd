extends Area2D

func _on_TreasureChest_body_entered(body):
	GameVariables.object_under_player = self
	print("don't stand on me!")

func _on_TreasureChest_body_exited(body):
	GameVariables.object_under_player = null
	print("now that's a relief")

func play_event():
	print("Event!!!")
	self.queue_free()
