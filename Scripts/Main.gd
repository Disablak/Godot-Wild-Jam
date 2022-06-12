extends Node2D



func _ready():
	SignalBus.connect(SignalBus.level_comleted_name, self, "on_level_completed")
	SignalBus.connect(SignalBus.player_died_name, self, "on_player_died")


func on_level_completed():
	print("level completed!")


func on_player_died():
	print("player died!")
