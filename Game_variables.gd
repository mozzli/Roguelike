extends Node

enum day_cycle {MORNING = 0, NOON = 1, EVENING = 2, NIGHT = 3}

var selected_unit
var time_of_the_day = Color(1,1,1,1)

func change_day_color(day_enum):
	match day_enum:
		day_cycle.MORNING: time_of_the_day = Color(0.94, 1, 1, 1)
		day_cycle.NOON: time_of_the_day = Color(1, 1, 1, 1)
		day_cycle.EVENING: time_of_the_day = Color(1, 0.27, 0, 1)
		day_cycle.NIGHT: time_of_the_day = Color(0, 0, 0.55, 1)
