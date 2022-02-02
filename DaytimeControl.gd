extends CanvasModulate

var increment = 0.006


func _process(_delta):
	if color.b > GameVariables.time_of_the_day.b:
		color.b -= increment
	elif color.b < GameVariables.time_of_the_day.b:
		color.b += increment

	if color.g > GameVariables.time_of_the_day.g:
		color.g -= increment
	elif color.g < GameVariables.time_of_the_day.g:
		color.g += increment

	if color.r > GameVariables.time_of_the_day.r:
		color.r -= increment
	elif color.r < GameVariables.time_of_the_day.r:
		color.r += increment
