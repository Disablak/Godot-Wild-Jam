extends Node


export var playerPositionChangedName = "playerPositionChanged"
signal playerPositionChanged(newPosition)

export var player_died_name = "player_died"
signal player_died

export var reloadLevelName = "reloadLevel"
signal reloadLevel

export var level_comleted_name = "level_completed"
signal level_completed

export var coin_took_name = "coin_took"
signal coin_took

export var gamePausedName = "gamePaused"
signal gamePaused

export var gameResumedName = "gameResumed"
signal gameResumed
