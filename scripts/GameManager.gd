extends Node

var unlocked_levels := [1]
var completed_levels := []

var red_coins := 0
var blue_coins := 0
var green_coins := 0

func complete_level(level_id: int) -> void:
	if not completed_levels.has(level_id):
		completed_levels.append(level_id)

func unlock_levels(levels: Array[int]) -> void:
	for level in levels:
		if level not in unlocked_levels:
			unlocked_levels.append(level)

func is_level_unlocked(level_id: int) -> bool:
	return level_id in unlocked_levels

func reset_coins() -> void:
	red_coins = 0
	blue_coins = 0
	green_coins = 0
