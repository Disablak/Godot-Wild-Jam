extends Node


signal player_died

var lights_can_destroy = []
var player
var enemy
var need_keys_count

var player_die = false


func _ready():
	$CanvasModulate.visible = true
	$Background.visible = true
	
	find_all_keys()
	find_all_destroyable_lights()
	player = find_node("Player")
	enemy = find_node("Enemy")


func _process(delta):
	check_distance_enemy_and_player()
	check_distance_enemy_and_lights()
	
	enemy.onTargetPositionChanged( player.position )


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


func check_distance_enemy_and_player():
	var player_pos : Vector2 = player.position
	var enemy_radius : int = enemy.radius_pxl
	var distance = player_pos.distance_to(enemy.position) - enemy_radius
	
	if distance <= 0 and not player_die:
		SignalBus.emit_signal(SignalBus.player_died_name)
		player_die = true


func check_distance_enemy_and_lights():
	for light in lights_can_destroy:
		var light_pos : Vector2 = light.position
		var enemy_radius : int = enemy.radius_pxl
		var distance = light_pos.distance_to(enemy.position) - enemy_radius
		
		if distance <= 0:
			light.destroy_light()
