extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -350.0

@onready var body_sprite = $Body
@onready var head_sprite = $Head
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

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
