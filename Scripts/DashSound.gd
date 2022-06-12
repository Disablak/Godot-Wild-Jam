extends Node

var audio_stream : AudioStreamPlayer2D

func _ready():
	audio_stream = get_node("AudioStreamPlayer2D")

func play_sound():
	audio_stream.play()
