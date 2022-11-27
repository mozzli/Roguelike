extends TextureRect

func reset_picture() -> void:
	texture = load("res://images/Battle/unit_box.png")

func reset_hp_box() -> void:
	$DamageBar.margin_top = 0
