tool
extends Node2D

class_name StalkingEnemy


export var movementSpeed : float = 1.0
export var size = 1 setget set_size

var targetPosition : Vector2
var radius_pxl : int


func _ready():
	radius_pxl = (($Sprite.texture.get_size().x * $Sprite.scale.x) * size) / 2
	print(radius_pxl)


func _process(delta):
	if Engine.editor_hint:
		return
	
	var direction = targetPosition - position

	if direction.length() > 1.0:
		direction = direction.normalized()

	direction = direction * movementSpeed * delta
	position += direction


func onTargetPositionChanged( newPosition ):
	targetPosition = newPosition


func set_size(new_size):
	size = new_size
	scale = Vector2.ONE * size
