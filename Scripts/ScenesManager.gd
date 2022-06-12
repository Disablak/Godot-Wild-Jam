extends Node


export(Array, PackedScene) var scenesOrder : Array
var currentLevelIndex: int = 0
var activeScene 
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect(SignalBus.level_comleted_name, self, "moveToNextScene")

func reloadScene():
	moveToScene(currentLevelIndex)

func moveToPreviousScene():
	if currentLevelIndex > 0:
		currentLevelIndex -= 1

	moveToScene(currentLevelIndex)
	pass

func moveToNextScene():
	if scenesOrder.size() - 2 > currentLevelIndex:
		currentLevelIndex += 1

	moveToScene(currentLevelIndex)
	pass

func moveToScene(index : int):
	if activeScene != null:
		activeScene.queue_free()

	activeScene = scenesOrder[index].instance()

	add_child(activeScene)
	pass