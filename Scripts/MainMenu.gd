extends Control

export(NodePath) var creditsRootPath
onready var creditsRoot : Control = get_node(creditsRootPath)
export(NodePath) var menuRootPath
onready var menuRoot : Control = get_node(menuRootPath)
var scenesManager

export(NodePath) var ironmanGameButtonPath
onready var ironmanButton : Button = get_node(ironmanGameButtonPath)
export(NodePath) var continueGameButtonPath
onready var continueButton : Button = get_node(continueGameButtonPath)
export(NodePath) var closeCreditsButtonPath
onready var closeCreditsButton : Button = get_node(closeCreditsButtonPath)
export(NodePath) var openCreditsButtonPath
onready var openCreditsButton : Button = get_node(openCreditsButtonPath)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	scenesManager = Globals.scenesManager
	
	openCreditsButton.connect("pressed", self, "openCreditsButtonPressed")
	closeCreditsButton.connect("pressed", self, "closeCreditsButtonPressed")
	continueButton.connect("pressed", self, "newGameButtonPressed")
	ironmanButton.connect("pressed", self, "ironmanGameButtonPressed")
	SignalBus.connect(SignalBus.gamePausedName, self, "onGamePaused")
	SignalBus.connect(SignalBus.gameResumedName, self, "onGameResumed")

	
	yield(get_tree().create_timer(0.2), "timeout")
	Globals.pauseActivator.pauseGame()

func openCreditsButtonPressed():
	menuRoot.visible = false
	creditsRoot.visible = true

func closeCreditsButtonPressed():
	menuRoot.visible = true
	creditsRoot.visible = false

func newGameButtonPressed():
	Globals.isIronManMode = false	
	scenesManager.moveToScene(0)
	yield(get_tree().create_timer(0.2), "timeout")
	
	continueGameButtonPressed()

func continueGameButtonPressed():
	Globals.pauseActivator.resumeGame()
	
func ironmanGameButtonPressed():
	newGameButtonPressed()
	Globals.isIronManMode = true

func onGamePaused():
	closeCreditsButtonPressed()
	self.visible = true

func onGameResumed():
	self.visible = false

	if scenesManager.hasActiveScene():
		return

	scenesManager.reloadScene()
