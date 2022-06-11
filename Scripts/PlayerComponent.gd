extends Node2D

var previousPosition: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emitPosition()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if global_position == previousPosition:
		pass
	
	emitPosition()

	pass

func emitPosition():
	previousPosition = global_position

	SignalBus.emit_signal(SignalBus.playerPositionChangedName, global_position)
	pass
