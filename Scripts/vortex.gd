extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var tracktionPower : float = 2
export var tracktionRange : float = 20
var target : Node2D


func _process(delta):
	if target == null:
		return

	var vortexCenter = global_position
	var direction = vortexCenter - target.global_position
	var distanceFromRadius = tracktionRange - direction.length()

	if distanceFromRadius < 0:
		distanceFromRadius = 0

	var tracktionDirection = (direction.normalized() * distanceFromRadius) * tracktionPower * delta

	tracktionDirection = tracktionDirection.clamped(direction.length())
	
	target.global_position += tracktionDirection



func _on_Vortex_body_entered(body:Node):
	if not body.is_in_group("player") or not body is Node2D:
		return
	
	target = body as Node2D

func _on_Vortex_body_exited(body:Node):
	if target != null and body == target:
		target = null
