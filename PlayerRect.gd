extends TextureRect

var selected_unit = null

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
