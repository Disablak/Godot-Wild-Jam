extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event) -> void:
	if not (event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed):
		return

	var mousePosition = get_global_mouse_position()

	for i in get_child_count():
		var child = get_child(i)
		
		if child is StalkingEnemy:
			child.onTargetPositionChanged(mousePosition)


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
