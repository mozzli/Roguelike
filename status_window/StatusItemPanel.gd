extends Panel

func load_texture_box(item_box: Dictionary):
	$TextureButton.item_box = item_box

func load_slot_number():
	$TextureButton.slot_number = int(name.right(1))

func refresh_slot():
	$TextureButton.refresh_item()
