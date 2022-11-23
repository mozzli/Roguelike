extends BaseBattleUnit

class_name BaseMonsterUnit

var items_to_gain: Array = []
var money_to_gain = 0

func set_money_amount(min_amount: int, max_amount: int):
	money_to_gain = Utilities.rng.randi_range(min_amount, max_amount)

func set_items_to_gain(items: Dictionary) -> void:
	for item in items:
		var chance = Utilities.rng.randi_range(1, 100)
		if chance <= items[item]:
			items_to_gain.append(item)

func get_enemy_money() -> int:
	return money_to_gain

func get_enemy_items() -> Array:
	return items_to_gain
