extends Control

export(NodePath) var creditsRootPath
onready var creditsRoot : Control = get_node(creditsRootPath)
export(NodePath) var menuRootPath
onready var menuRoot : Control = get_node(menuRootPath)
export(NodePath) var scenesManagerRootPath
onready var scenesManager : ScenesManager = get_node(scenesManagerRootPath)

export(NodePath) var newGameButtonPath
onready var newGameButton : Button = get_node(newGameButtonPath)
export(NodePath) var continueGameButtonPath
onready var continueButton : Button = get_node(continueGameButtonPath)
export(NodePath) var closeCreditsButtonPath
onready var closeCreditsButton : Button = get_node(closeCreditsButtonPath)
export(NodePath) var openCreditsButtonPath
onready var openCreditsButton : Button = get_node(openCreditsButtonPath)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	openCreditsButton.connect("pressed", self, "openCreditsButtonPressed")
	closeCreditsButton.connect("pressed", self, "closeCreditsButtonPressed")
	newGameButton.connect("pressed", self, "newGameButtonPressed")
	continueButton.connect("pressed", self, "continueGameButtonPressed")
	SignalBus.connect(SignalBus.gamePausedName, self, "onGamePaused")
	SignalBus.connect(SignalBus.gameResumedName, self, "onGameResumed")


func openCreditsButtonPressed():
	menuRoot.visible = false
	creditsRoot.visible = true

func closeCreditsButtonPressed():
	menuRoot.visible = true
	creditsRoot.visible = false

func newGameButtonPressed():
	scenesManager.moveToScene(0)
	continueGameButtonPressed()

func continueGameButtonPressed():
	self.visible = false

	if scenesManager.hasActiveScene():
		return

	scenesManager.reloadScene()

func onGamePaused():
	closeCreditsButtonPressed()
	self.visible = true

func onGameResumed():
	continueGameButtonPressed()
