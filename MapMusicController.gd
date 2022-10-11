extends AudioStreamPlayer

const min_volume = -8
const max_volume = 0

var current_volume

func _ready():
	current_volume = max_volume

func _process(_delta):
	if volume_db != current_volume:
		if current_volume < volume_db:
			volume_db -= 0.1
		elif current_volume > volume_db:
			volume_db += 0.1

func volume_down():
	current_volume = min_volume

func volume_up():
	current_volume = max_volume


