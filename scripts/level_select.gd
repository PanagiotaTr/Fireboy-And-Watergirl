extends Control

@export var grey_diamond: Texture2D
@export var green_diamond: Texture2D

@onready var button_sound = $ButtonSound

func _ready() -> void:
	for i in range(1, 11):
		var button: TextureButton = get_node("Level%dButton" % i)

		if GameManager.completed_levels.has(i):
			button.texture_normal = green_diamond
			button.texture_hover = green_diamond
			button.texture_pressed = green_diamond
			button.disabled = true
			button.modulate = Color(1, 1, 1)
		else:
			button.texture_normal = grey_diamond
			button.texture_hover = grey_diamond
			button.texture_pressed = grey_diamond
			button.disabled = !GameManager.is_level_unlocked(i)

			if button.disabled:
				button.modulate = Color(0.45, 0.45, 0.45)
			else:
				button.modulate = Color(1, 1, 1)

		button.pressed.connect(func(level_id := i): _go_to_level(level_id))
		button.mouse_entered.connect(func(b := button): _hover(b))
		button.mouse_exited.connect(func(b := button): _exit(b))


func _go_to_level(level_id: int) -> void:
	if !GameManager.is_level_unlocked(level_id):
		return
	
	if GameManager.completed_levels.has(level_id):
		return

	if level_id >= 1 and level_id <= 10:
		MusicManager.stop_music()
	else:
		MusicManager.play_music("shared_music")

	get_tree().change_scene_to_file("res://levels/level%d.tscn" % level_id)

func _hover(button: TextureButton) -> void:
	if button.disabled:
		return

	button_sound.play()

	button.modulate = Color(1.3, 1.3, 1.3)

func _exit(button: TextureButton) -> void:
	if button.disabled:
		return

	button.modulate = Color(1, 1, 1)
