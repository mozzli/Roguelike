extends HSlider


func _ready():
	value = AudioServer.get_bus_volume_db(0)

func _process(delta):
	if value == -40:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -70)
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
