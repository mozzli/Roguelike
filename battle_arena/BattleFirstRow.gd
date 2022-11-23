extends HBoxContainer

func change_hp_back(percent: int):
	$BackRow/DamageBar.margin_top = (rect_size.y * percent * -0.01)

func change_hp_front(percent: int):
	$FrontRow/DamageBar.margin_top = (rect_size.y * percent * -0.01)

func show_selected_unit_front():
	$FrontRow/SelectedUnit.visible = true

func hide_selected_unit_front():
	$FrontRow/SelectedUnit.visible = false

func show_selected_unit_back():
	$BackRow/SelectedUnit.visible = true

func hide_selected_unit_back():
	$BackRow/SelectedUnit.visible = false
