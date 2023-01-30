extends CanvasModulate

var increment = 0.006

func _process(_delta):
	if color.b > GameVariables.world_color.b:
		color.b -= increment
	elif color.b < GameVariables.world_color.b:
		color.b += increment

	if color.g > GameVariables.world_color.g:
		color.g -= increment
	elif color.g < GameVariables.world_color.g:
		color.g += increment

	if color.r > GameVariables.world_color.r:
		color.r -= increment
	elif color.r < GameVariables.world_color.r:
		color.r += increment
