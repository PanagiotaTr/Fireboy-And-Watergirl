extends CharacterBody2D

const SPEED = 160.0
const JUMP_VELOCITY = -360.0

@onready var body_sprite = $Body
@onready var head_sprite = $Head
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var collision_shape_2d_2: CollisionShape2D = $CollisionShape2D2

const DEATH_EFFECT = preload("res://scenes/death_effect.tscn")

var is_dead := false

func die():
	if is_dead:
		return
	
	is_dead = true
	set_physics_process(false)
	visible = false
	collision_shape_2d_2.set_deferred("disabled", true)
	
	var effect = DEATH_EFFECT.instantiate()
	effect.global_position = global_position
	get_parent().add_child(effect)
	
	death_sound.play()
	
	await effect.get_node("AnimatedSprite2D").animation_finished
	
	var win_manager = get_parent().get_node("WinManager")
	win_manager.show_lose_panel()
	
	await death_sound.finished
	queue_free()

func check_tile():
	var tilemap = get_parent().get_node("Blocks")

	var feet_pos = global_position + Vector2(0, 14)
	var local_pos = tilemap.to_local(feet_pos)
	var cell = tilemap.local_to_map(local_pos)
	var tile_data = tilemap.get_cell_tile_data(cell)

	if tile_data == null:
		return

	var tile_type = tile_data.get_custom_data("type")
	var kill_height = tile_data.get_custom_data("kill_height")

	if tile_type == null or kill_height == null:
		print("MISSING CUSTOM DATA")
		return

	var tile_origin = tilemap.map_to_local(cell)
	var y_in_tile = local_pos.y - tile_origin.y


	if tile_type in ["lava", "green", "purple"] and y_in_tile >= 0 and y_in_tile <= kill_height:
		print("DIE")
		die()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("watergirl_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	var direction := Input.get_axis("watergirl_left", "watergirl_right")

	if direction < 0:
		body_sprite.flip_h = true
		head_sprite.flip_h = true
	else:
		body_sprite.flip_h = false
		head_sprite.flip_h = false

	if is_on_floor():
		if direction == 0:
			body_sprite.play("idle")
			head_sprite.play("idle")
		else:
			body_sprite.play("run")
			head_sprite.play("run")
	else:
		if velocity.y < 0:
			
			if direction != 0:
				body_sprite.play("run")
				head_sprite.play("jump_up")
			else:
				body_sprite.play("idle")
				head_sprite.play("jump_idle")
		else:
			if direction != 0:
				body_sprite.play("run")
				head_sprite.play("run") #"fall"
			else:
				body_sprite.play("idle")
				head_sprite.play("fall")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is RigidBody2D and not is_dead:
			if abs(collision.get_normal().x) > 0.7 and direction != 0:
				collider.linear_velocity.x = direction * 80.0
		
	check_tile()
