extends Node2D


var coins_counter : int = 0


func _ready():
	SignalBus.connect(SignalBus.coin_took_for_level_name, self, "on_coin_took")


func on_coin_took():
	coins_counter += 1
	print("coins: {0}".format([coins_counter]))
