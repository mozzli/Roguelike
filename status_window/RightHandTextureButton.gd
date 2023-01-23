extends TextureButton

var current_item
var current_equipement

func _ready():
	add_to_group("ITEM")
	add_to_group("EQUIPEMENT")

func get_drag_data(_position):
	if current_item != null:
		var drag_texture = TextureRect.new()
		drag_texture.texture = texture_normal
		drag_texture.expand = true
		drag_texture.rect_size = rect_size
		drag_texture.modulate.a8 = 150
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.rect_position = -3.7 * drag_texture.rect_size
		set_drag_preview(control)
		return self

func can_drop_data(_position, data):
	var can_drop: bool = false
	if data is Node && data.is_in_group("ITEM"):
		can_drop = data.current_item.get_item_type() == GlobalItems.types_of_items.WEAPON
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
	current_equipement[GlobalItems.equipement_type.RIGHT_HAND] = item

func reset_item() -> void:
	texture_normal = null
	current_item = null
	current_equipement[GlobalItems.equipement_type.RIGHT_HAND] = null

func refresh_equipement():
	current_item = null
	current_equipement = null
	texture_normal = null
