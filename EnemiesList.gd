extends Node

var boar = preload("res://Enemies/BoarEnemy.tscn")

enum enemies {
	BOAR,
	WOLF,
	FLYING_DEMON
	}
	

func get_enemy_node(enemy):
	match(enemy):
		enemies.BOAR: return boar
