extends Control

@onready var button_sound = $ButtonSound
@onready var info_panel: Panel = $CanvasLayer/InfoPanel
@onready var close_button: Button = $CanvasLayer/InfoPanel/CloseButton

func _ready() -> void:
	$PlayButton.pressed.connect(_on_play_pressed)
	$InstructionsButton.pressed.connect(_on_instructions_pressed)
	$ExitButton.pressed.connect(_on_exit_pressed)

	$Fireboy.set_physics_process(false)
	$Fireboy.set_process(false)
	$Watergirl.set_physics_process(false)
	$Watergirl.set_process(false)

	info_panel.visible = false
	MusicManager.play_music("shared_music")

	for child in get_children():
		if child is Button or child is TextureButton:
			child.mouse_entered.connect(_play_hover_sound)

	close_button.mouse_entered.connect(_play_hover_sound)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/LevelSelect.tscn")

func _play_hover_sound() -> void:
	if info_panel.visible:
		var hovered = get_viewport().gui_get_hovered_control()
		if hovered != close_button:
			return

	button_sound.play()
	
func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_close_pressed() -> void:
	print("CLOSE")
	info_panel.hide()

func _on_instructions_pressed() -> void:
	info_panel.show()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and info_panel.visible:
		if get_viewport().gui_get_hovered_control() == close_button:
			info_panel.hide()
