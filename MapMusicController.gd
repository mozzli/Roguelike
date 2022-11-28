extends AudioStreamPlayer

class_name Music

const min_volume = -40
const max_volume = 0
var active = false

var current_volume

func _process(_delta):
	if volume_db != current_volume && active == true:
		if current_volume < volume_db:
			volume_db -= 0.1
		elif current_volume > volume_db:
			volume_db += 0.1
		elif current_volume == volume_db:
			active = false
			if current_volume == min_volume:
				stop()

func volume_down():
	current_volume = min_volume

func volume_up():
	current_volume = max_volume

func music_fade_in():
	volume_db = min_volume
	play()
	current_volume = max_volume
	active = true

func music_fade_out():
	current_volume = min_volume
	active = true


