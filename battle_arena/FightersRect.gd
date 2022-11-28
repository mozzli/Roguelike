extends TextureRect

var selected_unit = null
var enemy_party
onready var enemy_pics = get_tree().get_nodes_in_group("Enemy_GUI_Pictures")

func _process(_delta):
	if get_parent().get_attack_mode():
		change_attack_button_visibility(selected_unit)

func change_attack_button_visibility(unit):
	match(unit):
		BattleEnums.BattleRows.FIRST_BACK:
			if enemy_party[unit] != null:
				if enemy_party[unit].get_if_alive():
					turn_off_attack_selection()
					$Columns/FirstRow/BackRow.show_attack_button()
		BattleEnums.BattleRows.FIRST_FRONT:
			if enemy_party[unit] != null:
				if enemy_party[unit].get_if_alive():
					turn_off_attack_selection()
					$Columns/FirstRow/FrontRow.show_attack_button()
		BattleEnums.BattleRows.SECOND_BACK:
			if enemy_party[unit] != null:
				if enemy_party[unit].get_if_alive():
					turn_off_attack_selection()
					$Columns/SecondRow/BackRow.show_attack_button()
		BattleEnums.BattleRows.SECOND_FRONT:
			if enemy_party[unit] != null:
				if enemy_party[unit].get_if_alive():
					turn_off_attack_selection()
					$Columns/SecondRow/FrontRow.show_attack_button()
		BattleEnums.BattleRows.THIRD_BACK:
			if enemy_party[unit] != null:
				if enemy_party[unit].get_if_alive():
					turn_off_attack_selection()
					$Columns/ThirdRow/BackRow.show_attack_button()
		BattleEnums.BattleRows.THIRD_FRONT:
			if enemy_party[unit] != null:
				if enemy_party[unit].get_if_alive():
					turn_off_attack_selection()
					$Columns/ThirdRow/FrontRow.show_attack_button()
		_: turn_off_attack_selection()


func change_hp(unit_position, percent):
	match(unit_position):
		BattleEnums.BattleRows.FIRST_BACK:
			$Columns.change_hp_first_back(percent)
		BattleEnums.BattleRows.FIRST_FRONT:
			$Columns.change_hp_first_front(percent)
		BattleEnums.BattleRows.SECOND_BACK:
			($Columns as VBoxContainer).change_hp_second_back(percent)
		BattleEnums.BattleRows.SECOND_FRONT:
			$Columns.change_hp_second_front(percent)
		BattleEnums.BattleRows.THIRD_BACK:
			$Columns.change_hp_third_back(percent)
		BattleEnums.BattleRows.THIRD_FRONT:
			$Columns.change_hp_third_front(percent)

func change_selected_unit(gui_position: int):
	if enemy_party[gui_position] == null:
		selected_unit = null
	else:
		selected_unit = gui_position
	

func _on_FrontRow_mouse_entered():
	change_selected_unit(BattleEnums.BattleRows.FIRST_FRONT)

func _on_FrontRow_mouse_exited():
	selected_unit = null

func _on_BackRow_mouse_entered():
	change_selected_unit(BattleEnums.BattleRows.FIRST_BACK)

func _on_BackRow_mouse_exited():
	selected_unit = null

func _on_Second_FrontRow_mouse_entered():
	change_selected_unit(BattleEnums.BattleRows.SECOND_FRONT)

func _on_Second_BackRow_mouse_entered():
	change_selected_unit(BattleEnums.BattleRows.SECOND_BACK)

func _on_Third_FrontRow_mouse_entered():
	change_selected_unit(BattleEnums.BattleRows.THIRD_FRONT)

func _on_Third_BackRow_mouse_entered():
	change_selected_unit(BattleEnums.BattleRows.THIRD_BACK)

func turn_off_attack_selection():
	for pic in enemy_pics:
		pic.hide_attack_button()

func initiate_attack():
	get_parent().attack_mode = false
	selected_unit = null
	get_parent().attack_selected()

func _on_FrontRow_gui_input(event):
	if enemy_party[BattleEnums.BattleRows.FIRST_FRONT] != null:
		if get_parent().get_attack_mode() && event.is_action_pressed("mouse_click_left") && enemy_party[BattleEnums.BattleRows.FIRST_FRONT].get_if_alive():
			get_parent().set_target(BattleEnums.BattleRows.FIRST_FRONT)
			initiate_attack()

func _on_BackRow_gui_input(event):
	if enemy_party[BattleEnums.BattleRows.FIRST_BACK] != null:
		if get_parent().get_attack_mode() && event.is_action_pressed("mouse_click_left") && enemy_party[BattleEnums.BattleRows.FIRST_BACK].get_if_alive():
			get_parent().set_target(BattleEnums.BattleRows.FIRST_BACK)
			initiate_attack()

func _on_Second_FrontRow_gui_input(event):
	if enemy_party[BattleEnums.BattleRows.SECOND_FRONT] != null:
		if get_parent().get_attack_mode() && event.is_action_pressed("mouse_click_left") && enemy_party[BattleEnums.BattleRows.SECOND_FRONT].get_if_alive():
			get_parent().set_target(BattleEnums.BattleRows.SECOND_FRONT)
			initiate_attack()

func _on_Second_BackRow_gui_input(event):
	if enemy_party[BattleEnums.BattleRows.SECOND_BACK] != null:
		if get_parent().get_attack_mode() && event.is_action_pressed("mouse_click_left") && enemy_party[BattleEnums.BattleRows.SECOND_BACK].get_if_alive():
			get_parent().set_target(BattleEnums.BattleRows.SECOND_BACK)
			initiate_attack()

func _on_Third_FrontRow_gui_input(event):
	if enemy_party[BattleEnums.BattleRows.THIRD_FRONT] != null:
		if get_parent().get_attack_mode() && event.is_action_pressed("mouse_click_left") && enemy_party[BattleEnums.BattleRows.THIRD_FRONT].get_if_alive():
			get_parent().set_target(BattleEnums.BattleRows.THIRD_FRONT)
			initiate_attack()

func _on_Third_BackRow_gui_input(event):
	if enemy_party[BattleEnums.BattleRows.THIRD_BACK] != null:
		if get_parent().get_attack_mode() && event.is_action_pressed("mouse_click_left") && enemy_party[BattleEnums.BattleRows.THIRD_BACK].get_if_alive():
			get_parent().set_target(BattleEnums.BattleRows.THIRD_BACK)
			initiate_attack()
