extends KinematicBody2D

class_name Player

export(PackedScene) var particle_temple
export(float) var speed : float = 400

const time_tween = 0.1

var velocity : Vector2 = Vector2.ZERO
var previousPosition: Vector2
var additionalVelocity : Vector2 = Vector2.ZERO


func _ready():
	emitPosition()
	SignalBus.connect(SignalBus.player_died_name, self, "onPlayerDied")
	SignalBus.connect(SignalBus.level_comleted_name, self, "on_level_completed")


func _process(delta):
	velocity = Vector2.ZERO	
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	if global_position != previousPosition:
		emitPosition()


func emitPosition():
	previousPosition = global_position
	SignalBus.emit_signal(SignalBus.playerPositionChangedName, global_position)


func onPlayerDiedSignal():
	set_process(false)


func _physics_process(delta):
	move_and_slide(velocity + additionalVelocity)
	additionalVelocity = Vector2.ZERO


func onPlayerDied():
	velocity = Vector2.ZERO
	$Light2D.enabled = false
	$OrbSprite.visible = false
	play_particle_die()
	set_process(false)


func on_level_completed():
	set_physics_process(false)
	play_tween_finish()


func took_key():
	$Keys.add_key()


func play_particle_die():
	var particle = particle_temple.instance() as CPUParticles2D
	get_parent().add_child(particle)
	particle.position = position
	particle.color = $OrbSprite.self_modulate
	particle.play_particle()
	print(get_parent().name)
	print(particle.z_index)


func play_tween_finish():
	var tween = $Tween
	
	#tween.interpolate_property($Light2D, "texture_scale", 
	#	$Light2D.texture_scale, 5, time_tween)
	
	tween.interpolate_property(self, "position",
		position, get_parent().find_node("Finish").position , time_tween)
	
	tween.start()
