extends Node2D


var player
var enemy


func _ready():
	player = find_node("PlayerKinematicBody")
	enemy = find_node("Enemy")


func _process(delta):
	enemy.onTargetPositionChanged( player.position )
