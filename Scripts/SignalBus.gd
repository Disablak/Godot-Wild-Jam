extends Node


export var playerPositionChangedName = "playerPositionChanged"
signal playerPositionChanged(newPosition)

export var player_died_name = "player_died"
signal player_died

export var on_level_started_name = "on_level_started"
signal on_level_started(is_final_level)

export var reloadLevelName = "reloadLevel"
signal reloadLevel

export var level_comleted_name = "level_completed"
signal level_completed(is_final_level, is_good_ending)

export var coin_took_name = "coin_took"
signal coin_took

export var coin_took_for_level_name = "coin_took_for_level"
signal coin_took_for_level

export var gamePausedName = "gamePaused"
signal gamePaused

export var gameResumedName = "gameResumed"
signal gameResumed
