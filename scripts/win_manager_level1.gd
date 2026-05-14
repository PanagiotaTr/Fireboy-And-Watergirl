extends Node

@export var fire_door: NodePath
@export var water_door: NodePath
@export var win_panel: NodePath
@export var level_id: int = 1
@onready var button_sound = get_node(win_panel).get_node("ButtonSound")
@onready var minutes_text: Label = $"../Timer/Panel/MinutesText"
@onready var seconds_text: Label = $"../Timer/Panel/SecondsText"
@export var lose_panel: NodePath

var won := false

func _ready() -> void:
	get_node(win_panel).visible = false
	get_node(win_panel).get_node("BackButton").pressed.connect(_on_back_pressed)

	get_node(lose_panel).visible = false
	get_node(lose_panel).get_node("BackButton").pressed.connect(_on_back_pressed)
	get_node(lose_panel).get_node("RetryButton").pressed.connect(_on_retry_pressed)

	var back_button = get_node(win_panel).get_node("BackButton")
	back_button.mouse_entered.connect(_play_hover_sound)

	GameManager.reset_coins()

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
		GameManager.unlock_levels([2, 3, 4, 5])

		#await get_tree().create_timer(1.0).timeout

		get_tree().paused = true
		
		var panel = get_node(win_panel)
		
		panel.get_node("RedCoinsLabel").text = "X  " + str(GameManager.red_coins)
		panel.get_node("BlueCoinsLabel").text = "X  " + str(GameManager.blue_coins)
		panel.get_node("GreenCoinsLabel").text = "X  " + str(GameManager.green_coins)
		panel.get_node("TimeLabel").text = minutes_text.text + " : " + seconds_text.text
		
		panel.visible = true
		panel.get_node("AnimationPlayer").play("show")

func _on_back_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/LevelSelect.tscn")

func _play_hover_sound() -> void:
	button_sound.play()

func show_lose_panel() -> void:
	if won:
		return

	won = true
	get_tree().paused = true

	var panel = get_node(lose_panel)
	panel.visible = true
	panel.get_node("AnimationPlayer").play("show")
	
func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
