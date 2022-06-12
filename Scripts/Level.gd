extends Node


signal player_died

var lights_can_destroy = []
var need_keys_count

var player_die = false


func _ready():
	$CanvasModulate.visible = true
	$Background.visible = true
	
	find_all_keys()
	find_all_destroyable_lights()


#func _process(delta):


func _on_Finish_body_entered(body:Node):
	if need_keys_count > 0:
		print("find more keys ({0})".format([need_keys_count]))
	else:
		SignalBus.emit_signal(SignalBus.level_comleted_name)


func _on_Key_took(key, body):
	key.queue_free()
	print("taken key!")
	need_keys_count = need_keys_count - 1
	if need_keys_count <= 0:
		print("go to finish!")


func find_all_destroyable_lights():
	var lights = get_tree().get_nodes_in_group("light")
	for light in lights:
		if ( light.can_destroy):
			lights_can_destroy.append(light)
	
	print(lights_can_destroy)


func find_all_keys():
	var all_keys = get_tree().get_nodes_in_group("key")
	for key in all_keys:
		key.connect("key_took", self, "_on_Key_took")
	
	need_keys_count = all_keys.size()
	print("need {0} keys!".format([need_keys_count]))
