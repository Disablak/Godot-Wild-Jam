extends Node

var isInPauseState : bool = false


func _init():
	Globals.pauseActivator = self

func _process(delta: float) -> void:
	if not Input.is_action_just_pressed("return"):
		return

	if isInPauseState:
		resumeGame()
	else:
		pauseGame()

func pauseGame():
	if isInPauseState:
		return

	isInPauseState = true;
	SignalBus.emit_signal(SignalBus.gamePausedName)

func resumeGame():
	if not isInPauseState:
		return

	isInPauseState = false;
	SignalBus.emit_signal(SignalBus.gameResumedName)
