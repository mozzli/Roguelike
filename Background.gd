extends Node2D

func _ready():
	$ColorRect.margin_right = GameVariables.map_columns* 65 + 500
	$ColorRect.margin_bottom = GameVariables.map_columns* 48 + 500
