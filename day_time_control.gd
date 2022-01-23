extends CanvasModulate

func _process(delta):
	if color.b > GameVariables.time_of_the_day.b: color.b -= 0.001
	elif color.b < GameVariables.time_of_the_day.b: color.b += 0.001
	if color.g > GameVariables.time_of_the_day.g: color.g -= 0.001
	elif color.g < GameVariables.time_of_the_day.g: color.g += 0.001
	if color.r > GameVariables.time_of_the_day.r: color.r -= 0.001
	elif color.r < GameVariables.time_of_the_day.r: color.r += 0.001
