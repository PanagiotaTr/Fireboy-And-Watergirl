extends Node2D

signal toggled(state: bool)

@export var press_depth: float = 6.0
@export var press_duration: float = 0.1

var body_count: int = 0
var is_pressed: bool = false
var tween: Tween
var start_y: float

@onready var trigger_area: Area2D = $TriggerArea
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	start_y = sprite.position.y
	trigger_area.body_entered.connect(_on_body_entered)
	trigger_area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return

	body_count += 1

	if not is_pressed:
		is_pressed = true
		animate_button(start_y + press_depth)
		toggled.emit(true)

func _on_body_exited(body: Node) -> void:
	if not body.is_in_group("player"):
		return

	body_count = max(body_count - 1, 0)

	if body_count == 0 and is_pressed:
		is_pressed = false
		animate_button(start_y)
		toggled.emit(false)

func animate_button(target_y: float) -> void:
	if tween and tween.is_valid():
		tween.kill()

	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite, "position:y", target_y, press_duration)
