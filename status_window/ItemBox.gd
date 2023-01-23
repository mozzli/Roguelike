extends Control

var item_box

func load_item_box(player_item_box: Dictionary): 
	for box in get_tree().get_nodes_in_group("status_items_boxes"):
		box.load_slot_number()
		box.load_texture_box(player_item_box)
	item_box = player_item_box
	for i in range(1,30):
		if player_item_box.get(i) != null:
			get_node("GridContainer/ItemBox" + String(i)).get_node("TextureButton").load_item(player_item_box.get(i))

func refresh_item_box():
	for box in get_tree().get_nodes_in_group("status_items_boxes"):
		box.refresh_slot()

