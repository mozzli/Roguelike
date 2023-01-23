extends TextureButton

var party
var current_unit
var grid_pos
var default_texture = load("res://images/Battle/unit_box.png")

func _ready():
	add_to_group("PARTY")

func load_unit(unit: BaseBattleUnit):
	if unit != null:
		current_unit = unit
		texture_normal = unit.get_unit_picture()

func reset_box():
	current_unit = null
	texture_normal = default_texture

func get_drag_data(_position):
	if current_unit != null:
		var drag_texture = TextureRect.new()
		drag_texture.texture = texture_normal
		drag_texture.expand = true
		drag_texture.rect_size = rect_size
		drag_texture.modulate.a8 = 150
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.rect_position.x = -2 * drag_texture.rect_size.x
		drag_texture.rect_position.y = -1.8 * drag_texture.rect_size.y
		set_drag_preview(control)
		return self

func can_drop_data(_position, data):
	var can_drop: bool = data is Node && data.is_in_group("PARTY") || data is Node && data.is_in_group("POTION")
	return can_drop

func drop_data(_position, data):
	if data.is_in_group("PARTY"):
		if current_unit == null:
			party[grid_pos] = data.current_unit
			party.get(grid_pos).set_current_battle_position(grid_pos)
			party[data.grid_pos] = null
			load_unit(data.current_unit)
			data.reset_box()
		else:
			var new_unit = data.current_unit
			current_unit.set_current_battle_position(data.grid_pos)
			party[data.grid_pos] = current_unit
			new_unit.set_current_battle_position(grid_pos)
			party[grid_pos] = new_unit
			data.load_unit(current_unit)
			load_unit(new_unit)
	data.refresh_damage()
	refresh_damage()

func refresh_party():
	current_unit = null
	party = null
	texture_normal = default_texture

func refresh_damage():
	var percent
	if current_unit != null: percent = current_unit.get_percent_of_hp()
	else: percent = 0
	$DamageBar.margin_top = (rect_size.y * percent * -0.01)
