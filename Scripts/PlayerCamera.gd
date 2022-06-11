extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect(SignalBus.playerPositionChangedName, self, "moveToPlayer")

func moveToPlayer(playerPosition : Vector2):
	global_position = playerPosition
