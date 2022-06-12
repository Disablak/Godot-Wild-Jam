extends Node

var audio_stream : AudioStreamPlayer

func _ready():
	audio_stream = get_node("AudioStreamPlayer")
	play_sound()



func play_sound():
	print("play")
	audio_stream.play()
