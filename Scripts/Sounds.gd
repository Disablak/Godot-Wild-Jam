extends AudioStreamPlayer


export var clip_coin : AudioStreamSample
export var clip_finish : AudioStreamSample


func _ready():
	SignalBus.connect(SignalBus.coin_took_name, self, "play_coin")
	SignalBus.connect(SignalBus.level_comleted_name, self, "play_finish")


func play_coin():
	stream = clip_coin
	play()
	print("sound coin")


func play_finish(is_final, is_good_ending):
	stream = clip_finish
	play()
	print("sound finish")
