extends TextureRect

func reset_picture() -> void:
	texture = load("res://images/Battle/unit_box.png")

func reset_hp_box() -> void:
	$DamageBar.margin_top = 0

func hide_attack_button():
	$AttackSymbol.visible = false

func show_attack_button():
	if has_node("AttackSymbol"):
		$AttackSymbol.visible = true
