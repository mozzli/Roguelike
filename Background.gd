extends Node2D

func _ready():
	$ColorRect.margin_right = GameVariables.map_columns* 65 + 1000
	$ColorRect.margin_bottom = GameVariables.map_rows* 45 + 500
