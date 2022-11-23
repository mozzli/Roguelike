extends TextureRect

var selected_unit = null
var enemy_party

func _process(_delta):
	if get_parent().get_attack_mode():
		match(selected_unit):
			BattleEnums.BattleRows.FIRST_BACK:
				if enemy_party[selected_unit] != null:
					$Columns/FirstRow/BackRow/AttackSymbol.visible = true
					turn_other_targets_invincible(selected_unit)
			BattleEnums.BattleRows.FIRST_FRONT:
				if enemy_party[selected_unit] != null:
					$Columns/FirstRow/FrontRow/AttackSymbol.visible = true
					turn_other_targets_invincible(selected_unit)
			BattleEnums.BattleRows.SECOND_BACK:
				if enemy_party[selected_unit] != null:
					$Columns/SecondRow/BackRow/AttackSymbol.visible = true
					turn_other_targets_invincible(selected_unit)
			BattleEnums.BattleRows.SECOND_FRONT:
				if enemy_party[selected_unit] != null:
					$Columns/SecondRow/FrontRow/AttackSymbol.visible = true
					turn_other_targets_invincible(selected_unit)
			BattleEnums.BattleRows.THIRD_BACK:
				if enemy_party[selected_unit] != null:
					$Columns/ThirdRow/BackRow/AttackSymbol.visible = true
					turn_other_targets_invincible(selected_unit)
			BattleEnums.BattleRows.THIRD_FRONT:
				if enemy_party[selected_unit] != null:
					$Columns/ThirdRow/FrontRow/AttackSymbol.visible = true
					turn_other_targets_invincible(selected_unit)
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

func _on_FrontRow_mouse_entered():
	selected_unit = BattleEnums.BattleRows.FIRST_FRONT

func _on_FrontRow_mouse_exited():
	selected_unit = null

func _on_BackRow_mouse_entered():
	selected_unit = BattleEnums.BattleRows.FIRST_BACK

func _on_BackRow_mouse_exited():
	selected_unit = null

func _on_Second_FrontRow_mouse_entered():
	selected_unit = BattleEnums.BattleRows.SECOND_FRONT

func _on_Second_BackRow_mouse_entered():
	selected_unit = BattleEnums.BattleRows.SECOND_BACK

func _on_Third_FrontRow_mouse_entered():
	selected_unit = BattleEnums.BattleRows.THIRD_FRONT

func _on_Third_BackRow_mouse_entered():
	selected_unit = BattleEnums.BattleRows.THIRD_BACK

func turn_off_attack_selection():
	$Columns/FirstRow/FrontRow/AttackSymbol.visible = false
	$Columns/FirstRow/BackRow/AttackSymbol.visible = false
	$Columns/SecondRow/FrontRow/AttackSymbol.visible = false
	$Columns/SecondRow/BackRow/AttackSymbol.visible = false
	$Columns/ThirdRow/FrontRow/AttackSymbol.visible = false
	$Columns/ThirdRow/BackRow/AttackSymbol.visible = false

func turn_other_targets_invincible(self_pos):
	if self_pos != BattleEnums.BattleRows.FIRST_BACK:
		$Columns/FirstRow/BackRow/AttackSymbol.visible = false
	if self_pos != BattleEnums.BattleRows.FIRST_FRONT:
		$Columns/FirstRow/FrontRow/AttackSymbol.visible = false
	if self_pos != BattleEnums.BattleRows.SECOND_BACK:
		$Columns/SecondRow/BackRow/AttackSymbol.visible = false
	if self_pos != BattleEnums.BattleRows.SECOND_FRONT:
		$Columns/SecondRow/FrontRow/AttackSymbol.visible = false
	if self_pos != BattleEnums.BattleRows.THIRD_BACK:
		$Columns/ThirdRow/BackRow/AttackSymbol.visible = false
	if self_pos != BattleEnums.BattleRows.THIRD_FRONT:
		$Columns/ThirdRow/FrontRow/AttackSymbol.visible = false

func initiate_attack():
	get_parent().attack_mode = false
	selected_unit = null
	get_parent().attack_selected()

func _on_FrontRow_gui_input(event):
	if get_parent().get_attack_mode() && event.is_action_pressed("mouse_click_left"):
		get_parent().set_target(BattleEnums.BattleRows.FIRST_FRONT)
		initiate_attack()

func _on_BackRow_gui_input(event):
	if get_parent().get_attack_mode() && event.is_action_pressed("mouse_click_left"):
		get_parent().set_target(BattleEnums.BattleRows.FIRST_BACK)
		initiate_attack()

func _on_Second_FrontRow_gui_input(event):
	if get_parent().get_attack_mode() && event.is_action_pressed("mouse_click_left"):
		get_parent().set_target(BattleEnums.BattleRows.SECOND_FRONT)
		initiate_attack()

func _on_Second_BackRow_gui_input(event):
	if get_parent().get_attack_mode() && event.is_action_pressed("mouse_click_left"):
		get_parent().set_target(BattleEnums.BattleRows.SECOND_BACK)
		initiate_attack()

func _on_Third_FrontRow_gui_input(event):
	if get_parent().get_attack_mode() && event.is_action_pressed("mouse_click_left"):
		get_parent().set_target(BattleEnums.BattleRows.THIRD_FRONT)
		initiate_attack()

func _on_Third_BackRow_gui_input(event):
	if get_parent().get_attack_mode() && event.is_action_pressed("mouse_click_left"):
		get_parent().set_target(BattleEnums.BattleRows.THIRD_BACK)
		initiate_attack()
