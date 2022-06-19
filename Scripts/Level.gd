extends Node

export var is_final = false
export var playerDeathTimeout : float = 1.5

var lights_can_destroy = []
var need_keys_count
var is_player_died = false


func _init():
	SignalBus.emit_signal(SignalBus.on_level_started_name, is_final)

func _ready():
	SignalBus.connect(SignalBus.player_died_name, self, "onPlayerDiedSignal")
	
	is_player_died = false
	
	$CanvasModulate.visible = true
	$Background.visible = true
	
	find_all_keys()
	find_all_destroyable_lights()
	boostEnemyLastLevel()


func _on_Finish_body_entered(body:Node):
	if not body.is_in_group("player") or is_player_died:
		return
	
	if need_keys_count > 0:
		print("find more keys ({0})".format([need_keys_count]))
	else:
		SignalBus.emit_signal(SignalBus.level_comleted_name, is_final, true )


func _on_Key_took(key, body):
	print("taken key!")
	
	key.queue_free()
	$Player.took_key()
	
	need_keys_count -= 1
	if need_keys_count <= 0:
		print("go to finish!")


func find_all_destroyable_lights():
	var lights = get_tree().get_nodes_in_group("light")
	for light in lights:
		if ( light.can_destroy):
			lights_can_destroy.append(light)


func find_all_keys():
	var all_keys = get_tree().get_nodes_in_group("key")
	for key in all_keys:
		key.connect("key_took", self, "_on_Key_took")
	
	need_keys_count = all_keys.size()
	
	for i in need_keys_count:
		$Finish/KeysFly.add_key()
	
	print("need {0} keys!".format([need_keys_count]))


func onPlayerDiedSignal():
	is_player_died = true

	yield(get_tree().create_timer(playerDeathTimeout), "timeout")
	
	if is_final:
		SignalBus.emit_signal(SignalBus.level_comleted_name, is_final, false )
	elif Globals.isIronManMode:
		Globals.scenesManager.moveToScene(0)
	else:
		SignalBus.emit_signal(SignalBus.reloadLevelName)
	
func boostEnemyLastLevel():
	if not is_final:
		return
	
	var speed_bonus = get_parent().get_parent().find_node("CoinsCounter").coins_counter
	
	$Enemy.movementSpeed -= speed_bonus

