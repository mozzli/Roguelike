extends Control


var resolution


#
func _ready():
	resolution = get_viewport_rect().size
	rect_size.y = resolution.y
	$ColorRect.rect_size = resolution


func _on_EndTurnButton_pressed():
	GameVariables.new_turn()
