extends Node

@export var fire_door: NodePath
@export var water_door: NodePath
@export var win_panel: NodePath
@export var level_id: int = 1
@onready  var minutes_text: Label = $"../Timer/Panel/MinutesText"
@onready var seconds_text: Label = $"../Timer/Panel/SecondsText"
@export var lose_panel: NodePath
@export var levels_to_unlock: Array[int] = []
@export var required_completed_levels: Array[int] = []
@export var branch_unlock_levels: Array[int] = []
@onready var lose_music: AudioStreamPlayer = get_node(lose_panel).get_node("Music")
@onready var win_music: AudioStreamPlayer = get_node(win_panel).get_node("Music")

@onready var button_sound: AudioStreamPlayer = $ButtonSound
@onready var level_music: AudioStreamPlayer2D = $"../Music"

var won := false

func _ready() -> void:
	get_node(win_panel).self_modulate.a = 0.0
	get_node(lose_panel).self_modulate.a = 0.0
	get_node(win_panel).visible = false
	get_node(win_panel).get_node("BackButton").pressed.connect(_on_back_pressed)

	get_node(lose_panel).visible = false
	get_node(lose_panel).get_node("BackButton").pressed.connect(_on_back_pressed)
	get_node(lose_panel).get_node("RetryButton").pressed.connect(_on_retry_pressed)

	var win_back_button = get_node(win_panel).get_node("BackButton")
	win_back_button.mouse_entered.connect(_play_hover_sound)

	var lose_back_button = get_node(lose_panel).get_node("BackButton")
	lose_back_button.mouse_entered.connect(_play_hover_sound)

	var retry_button = get_node(lose_panel).get_node("RetryButton")
	retry_button.mouse_entered.connect(_play_hover_sound)

	GameManager.reset_coins()
	lose_music.stop()

func _process(_delta: float) -> void:
	if won:
		return

	var door1 = get_node(fire_door)
	var door2 = get_node(water_door)

	if door1.is_opened and door2.is_opened:
		won = true

		await get_tree().create_timer(1.0).timeout

		print("WINNERS")

		GameManager.complete_level(level_id)
		GameManager.unlock_levels(levels_to_unlock)
		
		if GameManager.are_levels_completed(required_completed_levels):
			GameManager.unlock_levels(branch_unlock_levels)

		#await get_tree().create_timer(1.0).timeout
		level_music.stop()
		get_tree().paused = true
		
		var panel = get_node(win_panel)
		
		panel.position = Vector2(-1000, 1000)
		
		panel.get_node("RedCoinsLabel").text = "X  " + str(GameManager.red_coins)
		panel.get_node("BlueCoinsLabel").text = "X  " + str(GameManager.blue_coins)
		panel.get_node("GreenCoinsLabel").text = "X  " + str(GameManager.green_coins)
		panel.get_node("TimeLabel").text = minutes_text.text + " : " + seconds_text.text
		
		panel.visible = true
		panel.get_node("AnimationPlayer").play("show")
		panel.get_node("BackgroundImage").position = Vector2(200, 0)

		var offset_x = 380
		var offset_y = 120

		panel.get_node("TitleLabel").position.x += offset_x
		panel.get_node("TitleLabel").position.y += offset_y

		panel.get_node("TitleLabel2").position.x += offset_x
		panel.get_node("TitleLabel2").position.y += offset_y
		
		panel.get_node("TimeLabel").position.x += offset_x
		panel.get_node("TimeLabel").position.y += offset_y

		panel.get_node("RedCoinsLabel").position.x += offset_x
		panel.get_node("RedCoinsLabel").position.y += offset_y

		panel.get_node("BlueCoinsLabel").position.x += offset_x
		panel.get_node("BlueCoinsLabel").position.y += offset_y

		panel.get_node("GreenCoinsLabel").position.x += offset_x
		panel.get_node("GreenCoinsLabel").position.y += offset_y

		panel.get_node("BackButton").position.x += offset_x
		panel.get_node("BackButton").position.y += offset_y

		panel.get_node("Red_Coin").position.x += offset_x
		panel.get_node("Red_Coin").position.y += offset_y

		panel.get_node("Blue_Coin").position.x += offset_x
		panel.get_node("Blue_Coin").position.y += offset_y

		panel.get_node("Green_Coin").position.x += offset_x
		panel.get_node("Green_Coin").position.y += offset_y

func _on_back_pressed() -> void:
	get_tree().paused = false

	win_music.stop()
	lose_music.stop()

	get_tree().change_scene_to_file("res://levels/LevelSelect.tscn")
	
	
func _play_hover_sound() -> void:
	button_sound.play()

func show_lose_panel() -> void:
	if won:
		return

	won = true
	get_tree().paused = true

	var panel = get_node(lose_panel)
	panel.position = Vector2(-1000, 1000)
	panel.visible = true
	win_music.stop()
	lose_music.play()
	panel.get_node("AnimationPlayer").play("show")
	
	panel.get_node("BackgroundImage").position = Vector2(200, 0)

	var offset_x = 380
	var offset_y = 120

	panel.get_node("TitleLabel").position.x += offset_x
	panel.get_node("TitleLabel").position.y += offset_y

	panel.get_node("BackButton").position.x += offset_x
	panel.get_node("BackButton").position.y += offset_y

	panel.get_node("RetryButton").position.x += offset_x
	panel.get_node("RetryButton").position.y += offset_y
	
	level_music.stop()
	
func _on_retry_pressed() -> void:
	get_tree().paused = false
	lose_music.stop()
	get_tree().reload_current_scene()
	
