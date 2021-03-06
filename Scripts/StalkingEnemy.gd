tool
extends Node2D

class_name StalkingEnemy

export var simple_ambient : bool = false

export var movementSpeed : float = 1.0
export var size = 1 setget set_size

export var dash : bool = true
export var dashSpeed : float = 10.0
export var dashDistance : float = 30.0

signal on_dash()

var player
var level

var targetPosition : Vector2
var distance : float = 2000
var radius_pxl : int

var killedPlayer : bool = false
var is_dashed = false


func _ready():
	radius_pxl = (($Sprite.texture.get_size().x * $Sprite.scale.x) * size) / 2
	
	level = get_parent()
	player = level.find_node("Player")
	
	SignalBus.connect(SignalBus.player_died_name, self, "on_player_died")
	SignalBus.connect(SignalBus.level_comleted_name, self, "on_level_completed")
	SignalBus.connect(SignalBus.gamePausedName, self, "onGamePaused")
	SignalBus.connect(SignalBus.gameResumedName, self, "onGameResumed")


func _process(delta):
	if Engine.editor_hint:
		return

	check_distance_enemy_and_player()
	check_distance_enemy_and_lights()

	targetPosition = player.position

	var direction : Vector2 = targetPosition - position
	var distanceToPlayer = direction.length()

	if  distanceToPlayer > 1.0:
		direction = direction.normalized()

	direction = direction * movementSpeed * delta
	direction = direction.clamped(distanceToPlayer)
	position += direction
 


func set_size(new_size):
	size = new_size
	scale = Vector2.ONE * size
	
func check_distance_enemy_and_player():
	var player_pos : Vector2 = player.position
	var enemy_radius : int = radius_pxl
	distance = player_pos.distance_to(position) - enemy_radius

	if not killedPlayer:
		if distance <= 0:
			SignalBus.emit_signal(SignalBus.player_died_name)
		elif distance <= dashDistance and not is_dashed and dash:
			dash()


func dash():
	movementSpeed = dashSpeed
	is_dashed = true
	emit_signal("on_dash")


func check_distance_enemy_and_lights():
	for light in level.lights_can_destroy:
		var light_pos : Vector2 = light.position
		var enemy_radius : int = radius_pxl
		var distance = light_pos.distance_to(position) - radius_pxl
		
		if distance <= 0:
			light.destroy_light()


func on_player_died():
	killedPlayer = true
	
	var tween = $Tween
	tween.interpolate_property($Sprite, "scale",
		$Sprite.scale, $Sprite.scale * 10, 1)
	tween.start()
	print("start tween")


func on_level_completed(is_final, is_good_ending):
	set_process(false)

func onGamePaused():
	set_physics_process(false)
	set_process(false)

func onGameResumed():
	set_process(true)
	set_physics_process(true)
