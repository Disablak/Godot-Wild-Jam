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
	SignalBus.connect(SignalBus.level_comleted_name, self, "level_completed")
	SignalBus.connect(SignalBus.coin_took_name, self, "coin_collected")
	SignalBus.connect(SignalBus.on_level_started_name, self, "on_level_started")
	
	$EndUI.visible = false
	$TextureBlack.visible = false
	$Outro.visible = false


func _process(delta):
	var is_key_pressed = Input.is_action_just_pressed("next_level")
	
	if $Outro.visible and is_key_pressed:
		print("todo go to menu")
		#move to menu
		return
	
	if not $EndUI.visible and not $FinalUI.visible:
		return
		
	if is_key_pressed:
		move_to_next_scene()

func move_to_next_scene():
	var is_pre_last = Globals.scenesManager.is_next_last_level()
	print( "is pre last {0}".format([is_pre_last]) )
	
	if $FinalUI.visible or not is_pre_last:
		if coin_collected:
			SignalBus.emit_signal(SignalBus.coin_took_for_level_name);
		
		Globals.scenesManager.moveToNextScene()
		return
	
	final()


func level_completed(is_final_level, is_good_ending):
	print("level_completed")
	
	if is_final_level:
		play_outro( is_good_ending )
	else:
		finish_level()


func finish_level():
	fade(true)
	$EndUI/VBoxContainer2/Secret.text = secret_collected_text if coin_collected else secret_not_collected_text


func hide():
	fade(false)


func coin_collected():
	coin_collected = true


func on_level_started( is_final_level ):
	coin_collected = false
	reset_coin_anim()
	fade(false)


func fade(enable, is_only_fade = false):
	$EndUI.visible = false
	$FinalUI.visible = false
	$TextureBlack.visible = true
	
	var tween = $Tween
	var color_start = Color( 0, 0, 0, 0 ) if enable else Color( 0, 0, 0, 1 )
	var color_finish = Color( 0, 0, 0, 1 ) if enable else Color( 0, 0, 0, 0 )
	
	tween.interpolate_property( $TextureBlack, "self_modulate",
		color_start, color_finish, time_fade, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()
	
	if is_only_fade:
		return
	
	var timer : Timer = $Timer
	timer.start(tween.get_runtime())
	yield (timer, "timeout")
	
	if enable:
		$EndUI.visible = true
		
		if coin_collected:
			tween_coin()


func fade_color(color_from, color_to):
	var tween = $Tween
	tween.interpolate_property( $TextureBlack, "self_modulate",
		color_from, color_to, time_fade, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()


func tween_coin():
	var tween = $Tween
	
	tween.interpolate_property( coin_empty, "self_modulate",
		color_empty, color_coin, 0.3, Tween.TRANS_SINE, Tween.EASE_IN)
	
	tween.interpolate_property( coin, "self_modulate",
		Color(0,0,0,0), color_coin, 0.3, Tween.TRANS_SINE, Tween.EASE_IN)
	
	tween.interpolate_property( coin, "rect_scale",
		Vector2(0.2, 0.2), Vector2(0.45, 0.45), 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	
	tween.start()


func final():
	$EndUI.visible = false
	$FinalUI.visible = true
	var coins_collected = get_parent().get_parent().find_node("CoinsCounter").coins_counter
	var coins_need = Globals.scenesManager.scenesOrder.size() - 1
	$FinalUI/LabelCount.text = "Coins Collected: {0} / {1}".format([coins_collected, coins_need])


func play_outro( is_good_ending ):
	$Outro.visible = true
	$Outro/LabelOutro.visible = false
	$TextureBlack.visible = true
	
	$Outro/LabelOutro.self_modulate = Color.white if not is_good_ending else Color.black
	fade_color( Color(0,0,0,0), Color.white if is_good_ending else Color.black )
	
	var timer : Timer = $Timer
	timer.start($Tween.get_runtime())
	yield (timer, "timeout")
	
	$Outro/LabelOutro.visible = true


func reset_coin_anim():
	coin.rect_scale = Vector2(0.20, 0.20)
	coin.self_modulate = Color(0,0,0,0)
	coin_empty.self_modulate = color_empty

