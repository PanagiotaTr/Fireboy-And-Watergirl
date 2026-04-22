extends Node2D

@onready var area: Area2D = $Area2D

@export var push_force: float = 1200.0
@export var max_up_speed: float = -300.0

func _physics_process(delta: float) -> void:
	for body in area.get_overlapping_bodies():
		if body is CharacterBody2D:
			body.velocity.y = max(body.velocity.y - push_force * delta, max_up_speed)
