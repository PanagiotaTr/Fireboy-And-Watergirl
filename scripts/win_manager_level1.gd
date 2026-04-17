extends Node

@export var fire_door: NodePath
@export var water_door: NodePath
@export var next_scene: String = "res://next_level.tscn"

var won := false

func _process(_delta: float) -> void:
	if won:
		return

	var door1 = get_node(fire_door)
	var door2 = get_node(water_door)

	if door1.is_opened and door2.is_opened:
		won = true
		await get_tree().create_timer(1.0).timeout
		#get_tree().change_scene_to_file(next_scene)
		print("WINNERS")
