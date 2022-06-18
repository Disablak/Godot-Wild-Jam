extends Node


var audio_stream : AudioStreamPlayer2D
var audio_stream_simple : AudioStreamPlayer

var play_simple : bool = true

export(PackedScene) var simple_ambient

export var min_aplify : float = -24.0
export var max_aplify : float = 20.0

export var min_aplify_distance : float = 2000
export var max_aplify_distance : float = 50

var enemy


func _ready():
	SignalBus.connect(SignalBus.level_comleted_name, self, "mute_sound")

	play_simple = get_parent().simple_ambient

	if play_simple:
		audio_stream_simple = simple_ambient.instance()
		add_child(audio_stream_simple)
		audio_stream_simple.play()
		set_process(false)
	else:
		audio_stream = get_node("AudioStreamPlayer2D")
		audio_stream.play()
		enemy = get_parent()



func _process(delta):
	audio_stream.position = enemy.position
	var aplify_percent = enemy.distance / (min_aplify_distance - max_aplify_distance) * 100.0
	if aplify_percent > 100.0:
		aplify_percent = 100.0
	elif aplify_percent < 0.0:
		aplify_percent = 0.0
	else:
		audio_stream.volume_db = (min_aplify + ((abs(min_aplify) + abs(max_aplify)) / 100.0 * (100 - aplify_percent)))


func mute_sound():
	set_process(false)
	
	if play_simple:
		audio_stream_simple.volume_db = -80.0
	else:
		audio_stream.volume_db = -80.0
