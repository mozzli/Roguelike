extends VBoxContainer

func change_hp_first_back(percent: int):
	$FirstRow.change_hp_back(percent)

func change_hp_first_front(percent: int):
	$FirstRow.change_hp_front(percent)

func change_hp_second_back(percent: int) -> void:
	($SecondRow as HBoxContainer).change_hp_back(percent)

func change_hp_second_front(percent: int):
	$SecondRow.change_hp_front(percent)

func change_hp_third_back(percent: int):
	$ThirdRow.change_hp_back(percent)

func change_hp_third_front(percent: int):
	$ThirdRow.change_hp_front(percent)

func change_visibility(unit):
	match(unit.get_current_battle_position()):
		BattleEnums.BattleRows.FIRST_BACK:
			if $FirstRow/BackRow/SelectedUnit.visible == false:
				$FirstRow/BackRow/SelectedUnit.visible = true
			else: $FirstRow/BackRow/SelectedUnit.visible = false
		BattleEnums.BattleRows.FIRST_FRONT:
			if $FirstRow/FrontRow/SelectedUnit.visible == false:
				$FirstRow/FrontRow/SelectedUnit.visible = true
			else: $FirstRow/FrontRow/SelectedUnit.visible = false
		BattleEnums.BattleRows.SECOND_BACK:
			if $SecondRow/BackRow/SelectedUnit.visible == false:
				$SecondRow/BackRow/SelectedUnit.visible = true
			else: $SecondRow/BackRow/SelectedUnit.visible = false
		BattleEnums.BattleRows.SECOND_FRONT:
			if $SecondRow/FrontRow/SelectedUnit.visible == false:
				$SecondRow/FrontRow/SelectedUnit.visible = true
			else: $SecondRow/FrontRow/SelectedUnit.visible = false
		BattleEnums.BattleRows.THIRD_BACK:
			if $ThirdRow/BackRow/SelectedUnit.visible == false:
				$ThirdRow/BackRow/SelectedUnit.visible = true
			else: $ThirdRow/BackRow/SelectedUnit.visible = false
		BattleEnums.BattleRows.THIRD_FRONT:
			if $ThirdRow/FrontRow/SelectedUnit.visible == false:
				$ThirdRow/FrontRow/SelectedUnit.visible = true
			else: $ThirdRow/FrontRow/SelectedUnit.visible = false
