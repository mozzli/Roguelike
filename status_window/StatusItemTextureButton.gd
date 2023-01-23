extends TextureButton

var current_item: Items
var item_box
var slot_number: int

func _ready():
	add_to_group("ITEM")
	add_to_group("BOX")

func get_drag_data(_position):
	if texture_normal != null:
		var drag_texture = TextureRect.new()
		drag_texture.texture = texture_normal
		drag_texture.expand = true
		drag_texture.rect_size = rect_size
		drag_texture.modulate.a8 = 150
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.rect_position = -4.4 * drag_texture.rect_size
		set_drag_preview(control)
		return self

func can_drop_data(_position, data):
	var can_drop: bool = data is Node and data.is_in_group("ITEM")
	if data.is_in_group("EQUIPEMENT") && current_item != null:
		can_drop = data.current_item.get_item_type() == current_item.get_item_type()
	return can_drop

func drop_data(_position, data):
	if current_item == null:
		load_item(data.current_item)
		data.reset_item()
	else:
		var new_item = data.current_item
		data.load_item(current_item)
		load_item(new_item)

func load_item(item: Items) -> void:
	texture_normal = item.get_image()
	current_item = item
	item_box[slot_number] = item

func reset_item() -> void:
	texture_normal = null
	current_item = null
	item_box[slot_number] = null

func refresh_item():
	texture_normal = null
	current_item = null
	item_box = null
