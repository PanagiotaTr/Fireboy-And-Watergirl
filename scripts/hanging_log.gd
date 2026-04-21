extends Node2D

@onready var log_sprite: Sprite2D = $LogPivot/Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $LogPivot/CollisionShape2D
@onready var stand_area: Area2D = $StandArea

@export var push_force: float = 1.2
@export var gravity_return: float = 4.0
@export var damping: float = 0.989
@export var max_angle: float = 2.1
@export var max_angular_velocity: float = 4.0

var player: Node2D = null
var angular_velocity: float = 0.0

func _physics_process(delta: float) -> void:
	var angle: float = log_sprite.rotation

	if player != null:
		var local_x: float = $LogPivot.to_local(player.global_position).x
		var side_strength: float = clampf(local_x / 80.0, -1.0, 1.0)

		var target_angle: float = side_strength * max_angle
		var angle_error: float = target_angle - angle

		angular_velocity += angle_error * push_force * 8.0 * delta
	else:
		angular_velocity += (-angle * gravity_return) * delta

	angular_velocity *= damping
	angular_velocity = clampf(angular_velocity, -max_angular_velocity, max_angular_velocity)

	angle += angular_velocity * delta

	if angle > max_angle:
		angle = max_angle
		angular_velocity = min(angular_velocity, 0.0)
	elif angle < -max_angle:
		angle = -max_angle
		angular_velocity = max(angular_velocity, 0.0)

	log_sprite.rotation = angle
	collision_shape_2d.rotation = angle
	stand_area.rotation = angle
