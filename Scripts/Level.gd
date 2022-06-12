extends Node


signal player_died

var lights_can_destroy = []
var player
var enemy


func _ready():
	find_all_destroyable_lights()
	player = find_node("Player")
	enemy = find_node("Enemy")


func _process(delta):
	check_distance_enemy_and_player()
	check_distance_enemy_and_lights()
	
	enemy.onTargetPositionChanged( player.position )


func _on_Finish_body_entered(body:Node):
	SignalBus.emit_signal(SignalBus.level_comleted_name)


func find_all_destroyable_lights():
	var lights = get_tree().get_nodes_in_group("light")
	for light in lights:
		if ( light.can_destroy):
			lights_can_destroy.append(light)
	
	print(lights_can_destroy)


func check_distance_enemy_and_player():
	var player_pos : Vector2 = player.position
	var enemy_radius : int = enemy.radius_pxl
	var distance = player_pos.distance_to(enemy.position) - enemy_radius
	
	if distance <= 0:
		SignalBus.emit_signal(SignalBus.player_died_name)


func check_distance_enemy_and_lights():
	for light in lights_can_destroy:
		var light_pos : Vector2 = light.position
		var enemy_radius : int = enemy.radius_pxl
		var distance = light_pos.distance_to(enemy.position) - enemy_radius
		
		if distance <= 0:
			light.destroy_light()
