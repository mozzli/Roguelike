extends Node

var boar = preload("res://battle_units/Enemies/BoarEnemy.tscn")
var builder = preload("res://battle_units/Heroes/BuilderHero.tscn")

enum enemies {
	BOAR,
	WOLF,
	FLYING_DEMON
	}

enum player {
	BUILDER,
	SWORDSMAN,
	MAGICIAN
}

func get_enemy_node(enemy):
	match(enemy):
		enemies.BOAR: return load("res://battle_units/Enemies/BoarEnemy.tscn")

func get_player_node(unit):
	match(unit):
		player.BUILDER: return load("res://battle_units/Heroes/BuilderHero.tscn")
