extends CanvasLayer


export var secret_collected_text: String
export var secret_not_collected_text: String

export(NodePath) var coin_empty_path
onready var coin_empty : TextureRect = get_node(coin_empty_path)
export(NodePath) var coin_path
onready var coin : TextureRect = get_node(coin_path)

const color_empty = Color(0.870588, 0.745098, 0.478431, 0.27451)
const color_coin = Color(0.870588, 0.745098, 0.478431)

const time_fade = 1
const time_tween_coin = 1

var coin_collected: bool = false

func _ready():
	SignalBus.connect(SignalBus.level_comleted_name, self, "show")
	SignalBus.connect(SignalBus.coin_took_name, self, "coin_collected")
	SignalBus.connect(SignalBus.on_level_started_name, self, "on_level_started")
	
	$EndUI.visible = false
	$TextureBlack.visible = false

func show():
	fade(true)
	
	if coin_collected:
		$EndUI/VBoxContainer2/Secret.text = secret_collected_text
	else:
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
	$TextureBlack.visible = true
	
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
		
		if coin_collected:
			tween_coin()



func tween_coin():
	var tween = $Tween
	
	tween.interpolate_property( coin_empty, "self_modulate",
		color_empty, color_coin, 0.3, Tween.TRANS_SINE, Tween.EASE_IN)
	
	tween.interpolate_property( coin, "self_modulate",
		Color(0,0,0,0), color_coin, 0.3, Tween.TRANS_SINE, Tween.EASE_IN)
	
	tween.interpolate_property( coin, "rect_scale",
		Vector2(0.2, 0.2), Vector2(0.45, 0.45), 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	
	tween.start()

