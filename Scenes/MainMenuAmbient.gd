extends Node



func _ready():
	if not get_parent().get_node("ScenesManager").hasActiveScene():
		playAmbient()

	SignalBus.connect(SignalBus.on_level_started_name, self, "stopAmbient")


func playAmbient():
	$SimpleAmbient.play()

func stopAmbient():
	$SimpleAmbient.stop()
