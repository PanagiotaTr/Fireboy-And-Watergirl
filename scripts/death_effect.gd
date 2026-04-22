extends Node2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	anim.play("default")
	await anim.animation_finished
	queue_free()
