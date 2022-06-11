extends Node2D

class_name StalkingEnemy

export var movementSpeed : float
var targetPosition : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var direction = targetPosition - position

	if direction.length() > 1.0:
		direction = direction.normalized()

	direction = direction * movementSpeed * delta

	position += direction
	pass

func onTargetPositionChanged( newPosition ):
	targetPosition = newPosition
	pass
