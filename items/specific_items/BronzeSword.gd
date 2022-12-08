extends Weapons

class_name BronzeSword

var weapon_name = "Bronze Sword"
var weapon_power = 6
var image = "res://images/items/weapons/bronze_sword.png"

func _ready():
	set_image(image)
	set_name(weapon_name)
	set_power(weapon_power)
