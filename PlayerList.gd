extends Node

var boar = preload("res://Enemies/BoarEnemy.tscn")

enum heroes {
	BUILDER,
	ARCHER,
	SWORDMAN
	}
	

func get_hero_node(hero):
	match(hero):
		heroes.BUILDER: return boar
