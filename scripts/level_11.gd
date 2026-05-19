extends Node2D

@onready var red_button = $Platforms/RedButton
@onready var blue_button = $Platforms/BlueButton

@onready var label1 = $LevelsText
@onready var label2 = $LevelsText2

@onready var official_fireboy = $Fireboy
@onready var official_watergirl = $Watergirl

@onready var fire_door_sound = $Doors/Door/AudioStreamPlayer2D
@onready var water_door_sound = $Doors/Door2/AudioStreamPlayer2D

@onready var fake_players = [
	$Fireboy1,
	$Fireboy2,
	$Fireboy3,
	$Fireboy4,
	$Fireboy5,

	$Watergirl1,
	$Watergirl2,
	$Watergirl3,
	$Watergirl4,
	$Watergirl5
]

var texts_shown := false

@onready var red_platforms = [
	$Platforms/RedPlat1,
	$Platforms/RedPlat2,
	$Platforms/RedPlat3,
	$Platforms/RedPlat4,
	$Platforms/RedPlat5
]

@onready var blue_platforms = [
	$Platforms/BluePlat1,
	$Platforms/BluePlat2,
	$Platforms/BluePlat3,
	$Platforms/BluePlat4,
	$Platforms/BluePlat5
]

func _ready() -> void:
	red_button.toggled.connect(_on_red_button_toggled)
	blue_button.toggled.connect(_on_blue_button_toggled)
	
	fire_door_sound.volume_db = -80
	water_door_sound.volume_db = -80

	label1.hide()
	label2.hide()

	official_fireboy.set_process(true)
	official_fireboy.set_physics_process(true)

	official_watergirl.set_process(true)
	official_watergirl.set_physics_process(true)

	for p in fake_players:
		p.set_process(false)
		p.set_physics_process(false)

func _on_red_button_toggled(state: bool) -> void:
	if state:
		await get_tree().create_timer(0.3).timeout

		for platform in red_platforms:
			platform.set_process(false)
			platform.set_physics_process(false)
			platform.visible = false
			platform.get_node("CollisionShape2D").set_deferred("disabled", true)

func _on_blue_button_toggled(state: bool) -> void:
	if state:
		await get_tree().create_timer(0.3).timeout

		for platform in blue_platforms:
			platform.set_process(false)
			platform.set_physics_process(false)
			platform.visible = false
			platform.get_node("CollisionShape2D").set_deferred("disabled", true)

func _process(_delta: float) -> void:
	if texts_shown:
		return

	if red_button.is_pressed and blue_button.is_pressed:
		texts_shown = true
		show_texts()

func show_texts() -> void:
	label1.show()

	await get_tree().create_timer(1.5).timeout

	label2.show()
