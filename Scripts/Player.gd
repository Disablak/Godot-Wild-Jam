extends KinematicBody2D


export var speed = 400
var velocity = Vector2.ZERO

var screen_size


func _ready():
	screen_size = get_viewport_rect().size

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
