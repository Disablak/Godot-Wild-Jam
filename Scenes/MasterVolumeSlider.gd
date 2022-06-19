extends VSlider


func _ready():
	connect("value_changed", self, "changeVolume")

func changeVolume(volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80.0 if volume == min_value else volume)
