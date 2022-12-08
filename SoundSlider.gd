extends HSlider


func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -30)
	print(AudioServer.get_bus_volume_db(0))
	value = AudioServer.get_bus_volume_db(0)

func _process(delta):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
