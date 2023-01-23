extends Weapons

class_name IronSword

var weapon_name = "Iron Sword"
var weapon_power = 10
var image = load("res://images/items/weapons/iron_sword.png")

func _init():
	weapon_type = GlobalItems.weapon_type.SWORD
	set_image(image)
	set_name(weapon_name)
	set_power(weapon_power)
