extends Node


export(Array, PackedScene) var scenesOrder : Array
var currentLevelIndex: int = 0
var activeScene 

func _ready() -> void:
	SignalBus.connect(SignalBus.level_comleted_name, self, "moveToNextScene")
	SignalBus.connect(SignalBus.reloadLevelName, self, "reloadScene")

	if activeScene == null:
		reloadScene()

func reloadScene():
	moveToScene(currentLevelIndex)

func moveToPreviousScene():
	if currentLevelIndex > 0:
		currentLevelIndex -= 1

	moveToScene(currentLevelIndex)

func moveToNextScene():
	if scenesOrder.size() - 1 > currentLevelIndex:
		currentLevelIndex += 1

	moveToScene(currentLevelIndex)

func moveToScene(index : int):
	if activeScene != null:
		remove_child(activeScene)
		activeScene.queue_free()

	activeScene = scenesOrder[index].instance()

	add_child(activeScene)
