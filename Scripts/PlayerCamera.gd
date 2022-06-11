extends Camera2D

export var interpolatePosition : bool = true
export var interpolationSpeed : float = 2

var playerPosition : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerPosition = global_position
	current = true
	SignalBus.connect(SignalBus.playerPositionChangedName, self, "moveToPlayer")

func _process(delta) -> void:
	var cameraPosition = global_position
	var distance = playerPosition - cameraPosition

	cameraPosition = distance / interpolationSpeed
	
	global_position += cameraPosition * delta

func moveToPlayer(playerPosition : Vector2):
	self.playerPosition = playerPosition
