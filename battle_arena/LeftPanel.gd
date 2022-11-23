extends Panel

func change_hp_view(unit):
	match(unit):
		BattleUtilities.unit_row.BACK_ROW_ONE:
			$BackRow1/DamageBar
