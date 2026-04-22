extends CharacterBody2D

@onready var ray_left: RayCast2D = $RayLeft
@onready var ray_right: RayCast2D = $RayRight
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hitbox: Area2D = $Hitbox

const SPEED = 60.0
var direction := -1

var is_dead := false

func die():
	if is_dead:
		return
	
	is_dead = true
	set_physics_process(false)

	collision_shape_2d.set_deferred("disabled", true)
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	
	sprite.visible = false
	death_sound.play()
	await death_sound.finished
	
	queue_free()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if direction == -1 and not ray_left.is_colliding():
		direction = 1
	elif direction == 1 and not ray_right.is_colliding():
		direction = -1

	velocity.x = direction * SPEED

	move_and_slide()

	if is_on_wall():
		direction *= -1
		
	if direction < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false


func _on_hitbox_body_entered(body: Node) -> void:
	if body is RigidBody2D:
		die()
		return
	
	if body.name == "Fireboy" or body.name == "Watergirl":
		if body.has_method("die"):
			body.die()
