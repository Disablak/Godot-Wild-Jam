extends Node


var audio_stream : AudioStreamPlayer2D

export var min_aplify : float = -24.0
export var max_aplify : float = 20.0

export var min_aplify_distance : float = 2000
export var max_aplify_distance : float = 50

var enemy


func _ready():
	audio_stream = get_node("AudioStreamPlayer2D")
	audio_stream.play()
	enemy = get_parent()
	SignalBus.connect(SignalBus.player_died_name, self, "mute_sound")
	

func _process(delta):
	audio_stream.position = enemy.position
	var aplify_percent = enemy.distance / (min_aplify_distance - max_aplify_distance) * 100.0
	if aplify_percent > 100.0:
		aplify_percent = 100.0
	elif aplify_percent < 0.0:
		aplify_percent = 0.0
	else:
		print(aplify_percent)
		var temp = (abs(min_aplify) + abs(max_aplify)) / 100.0
		print(temp)
		audio_stream.volume_db = (min_aplify + (temp * (100 - aplify_percent)))
		print(audio_stream.volume_db)


func mute_sound():
	audio_stream.volume_db = -80.0
