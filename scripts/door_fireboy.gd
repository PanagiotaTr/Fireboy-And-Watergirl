extends Node2D

@export var allowed_group: String = "fireboy"

@onready var trigger: Area2D = $Trigger
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var front_parts: Node2D = $FrontParts

var is_opened = false

func _ready() -> void:
	trigger.body_entered.connect(_on_body_entered)
	trigger.body_exited.connect(_on_body_exited)
	anim.animation_finished.connect(_on_animation_finished)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group(allowed_group):
		anim.play("open")
		is_opened = false

func _on_body_exited(body: Node) -> void:
	if body.is_in_group(allowed_group):
		for n in range(7):
			front_parts.get_child(n).visible = false
		anim.play_backwards("close2")
		is_opened = false

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "open":
		is_opened = true
	elif anim_name == "close2":
		is_opened = false
