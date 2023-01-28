extends Weapons

class_name SilverSword

var weapon_name = "Silver Sword"
var weapon_power = 15
var image = "res://images/items/weapons/silver_sword.png"

func _init():
	weapon_type = GlobalItems.weapon_type.SWORD
	set_image(image)
	set_name(weapon_name)
	set_power(weapon_power)
