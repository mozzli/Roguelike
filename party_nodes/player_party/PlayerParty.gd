extends BaseParty

class_name PlayerParty

func change_unit_position(unit: int, placement: int):
	if unit_formation[placement] == null:
		unit_formation[placement] = unit_formation[unit]
	else:
		swap_units_position(unit, placement)

func swap_units_position(unit, swapped_unit) -> void:
	var unit_swap: int = unit_formation[swapped_unit]
	unit_formation[swapped_unit] = unit_formation[unit]
	unit_formation[unit] = unit_swap
