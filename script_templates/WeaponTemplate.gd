extends Weapons

class_name Weapon

var weapon_name = "weapon name"
var weapon_power = 0

func _ready():
	set_name(weapon_name)
	set_power(weapon_power)
