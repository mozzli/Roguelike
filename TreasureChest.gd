extends Area2D

var object_body

func _on_TreasureChest_body_entered(body):
	GameVariables.object_under_player = self
	object_body = body
	print("don't stand on me!")

func _on_TreasureChest_body_exited(_body):
	GameVariables.object_under_player = null
	object_body = null
	print("now that's a relief")

func play_event():
	var item_get = ItemsList.get_random_item_lvl1()
	object_body.get_node("Equipment").equipment.append(item_get)
	print(object_body.get_node("Equipment").equipment)
	print("you've got ", ItemsList.get_item_name(item_get), "!")
	self.queue_free()
