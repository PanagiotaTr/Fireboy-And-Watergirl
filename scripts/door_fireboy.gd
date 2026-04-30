extends Node2D

@export var allowed_group: String = "fireboy"
@export var open_delay: float = 1.5

@onready var trigger: Area2D = $Trigger
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var front_parts: Node2D = $FrontParts

var is_opened := false
var player_inside := false
var opening_pending := false

func _ready() -> void:
	trigger.body_entered.connect(_on_body_entered)
	trigger.body_exited.connect(_on_body_exited)
	anim.animation_finished.connect(_on_animation_finished)

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group(allowed_group):
		return
	
	player_inside = true
	
	if is_opened or anim.current_animation == "open":
		return
	
	opening_pending = true
	await get_tree().create_timer(open_delay).timeout
	
	if player_inside and opening_pending and not is_opened:
		anim.play("open")
		opening_pending = false

func _on_body_exited(body: Node) -> void:
	if not body.is_in_group(allowed_group):
		return
	
	player_inside = false
	opening_pending = false
	
	if not is_opened and anim.current_animation != "open":
		return
	
	for n in range(min(7, front_parts.get_child_count())):
		front_parts.get_child(n).visible = false
	
	anim.play("close2")
	is_opened = false

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "open":
		is_opened = true
	elif anim_name == "close2":
		is_opened = false
