extends Control

@onready var button_sound = $ButtonSound

func _ready() -> void:
	$PlayButton.pressed.connect(_on_play_pressed)
	$InstructionsButton.pressed.connect(_on_instructions_pressed)

	$Fireboy.set_physics_process(false)
	$Fireboy.set_process(false)

	$Watergirl.set_physics_process(false)
	$Watergirl.set_process(false)

	for child in get_children():
		if child is Button or child is TextureButton:
			child.mouse_entered.connect(_play_hover_sound)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/LevelSelect.tscn")

func _on_instructions_pressed() -> void:
	print("Instructions")

func _play_hover_sound() -> void:
	button_sound.play()
