extends CanvasLayer


export var secret_collected_text: String
export var secret_not_collected_text: String

const time_fade = 1

var coin_collected: bool = false

func _ready():
	SignalBus.connect(SignalBus.level_comleted_name, self, "show")
	SignalBus.connect(SignalBus.coin_took_name, self, "coin_collected")
	SignalBus.connect(SignalBus.on_level_started_name, self, "on_level_started")


func show():
	fade(true)
	
	if coin_collected:
		$EndUI/VBoxContainer2/Secret.text = secret_collected_text
	else:
		$EndUI/VBoxContainer2/CenterContainer/Coin.visible = false
		$EndUI/VBoxContainer2/Secret.text = secret_not_collected_text


func hide():
	fade(false)


func coin_collected():
	coin_collected = true


func on_level_started():
	coin_collected = false
	fade(false)


func fade(enable):
	$EndUI.visible = false
	
	var tween = $Tween
	var color_start = Color( 0, 0, 0, 0 ) if enable else Color( 0, 0, 0, 1 )
	var color_finish = Color( 0, 0, 0, 1 ) if enable else Color( 0, 0, 0, 0 )
	tween.interpolate_property( $TextureBlack, "self_modulate",
		color_start, color_finish, time_fade, Tween.TRANS_SINE, Tween.EASE_IN)
	
	tween.start()
	
	var timer : Timer = $Timer
	timer.start(tween.get_runtime())
	yield (timer, "timeout")
	
	if enable:
		$EndUI.visible = true


