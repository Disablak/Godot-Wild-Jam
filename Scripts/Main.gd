extends Node2D


signal player_died

var player
var enemy


func _ready():
	player = find_node("Player")
	enemy = find_node("Enemy")


func _process(delta):
	check_distance()
	enemy.onTargetPositionChanged( player.position )
	

func check_distance():
	var player_pos : Vector2 = player.position
	var enemy_radius : int = enemy.radius_pxl
	var distance = player_pos.distance_to(enemy.position) - enemy_radius
	
	if distance <= 0:
		print("die")
		emit_signal("player_died")
