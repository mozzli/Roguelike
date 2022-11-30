extends Node

enum attack_enums {BASIC_ATTACK, FIRE_BOLT}

func get_damage(attack: int, unit: BaseBattleUnit) -> int:
	match(attack):
		attack_enums.BASIC_ATTACK: return basic_attack(unit)
		_: return 0

func basic_attack(unit: BaseBattleUnit) -> int:
	return unit.get_stat(StatEnums.stat_enums.STR) + Utilities.rng.randi()%6
