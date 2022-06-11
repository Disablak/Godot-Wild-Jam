extends KinematicBody2D

export(float) var speed : float = 400
var velocity : Vector2 = Vector2.ZERO

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

	move_and_slide(velocity)
