extends AnimatableBody2D

@export var move_offset: Vector2 = Vector2(64, 0)
@export var move_duration: float = 1.0

var start_position: Vector2
var target_position: Vector2
var is_moved: bool = false
var tween: Tween
var active_count: int = 0

@onready var move_sound: AudioStreamPlayer2D = $MoveSound

func _ready() -> void:
	start_position = global_position
	target_position = start_position + move_offset

func move_platform() -> void:
	if is_moved:
		return

	_start_tween(target_position)
	is_moved = true

func reset_platform() -> void:
	if not is_moved:
		return

	_start_tween(start_position)
	is_moved = false

func set_active(state: bool) -> void:
	if state:
		active_count += 1
	else:
		active_count = max(active_count - 1, 0)

	if active_count > 0:
		move_platform()
	else:
		reset_platform()

func _start_tween(destination: Vector2) -> void:
	if tween and tween.is_valid():
		tween.kill()

	if move_sound:
		if not move_sound.playing:
			move_sound.play()

	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", destination, move_duration)
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished() -> void:
	if move_sound and move_sound.playing:
		move_sound.stop()
