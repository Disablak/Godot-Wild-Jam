extends KinematicBody2D

export(float) var speed : float = 400

var velocity : Vector2 = Vector2.ZERO


func _ready():
	SignalBus.connect(SignalBus.player_died_name, self, "onPlayerDied")

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


func _physics_process(delta):
	move_and_slide(velocity)


func onPlayerDied():
	velocity = Vector2.ZERO
	$Sprite.visible = false
	$ExplosionParticle.play_particle()
	set_process(false)
