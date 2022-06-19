extends Node2D

class_name ScenesManager

export(Array, PackedScene) var scenesOrder : Array

const delay_before_next_scene = 1.0

var currentLevelIndex: int = 0
var activeScene 


func _ready() -> void:
	set_process(false)

	Globals.scenesManager = self
	SignalBus.connect(SignalBus.level_comleted_name, self, "on_level_completed")
	SignalBus.connect(SignalBus.reloadLevelName, self, "reloadScene")

	#if activeScene == null:
	#	reloadScene()


func _process(delta):
	if Input.is_action_just_pressed("restart_level"):
		reloadScene()
	elif Input.is_action_just_pressed("next_level"):
		moveToNextScene()


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
	set_process(false)


func on_level_completed():
	set_process(true)

func hasActiveScene() -> bool:
	return activeScene != null
