extends Node2D
@onready var watergirl: CharacterBody2D = $Watergirl
@onready var fireboy: CharacterBody2D = $Fireboy
@onready var dark_rect = $DarknessLayer/ColorRect
@onready var camera : Camera2D = $Camera2D

func _process(delta):
	if !is_instance_valid(fireboy):
		fireboy = get_node_or_null("Fireboy")

	if !is_instance_valid(watergirl):
		watergirl = get_node_or_null("Watergirl")

	var mat = dark_rect.material
	var screen_center = get_viewport_rect().size / 2

	if is_instance_valid(fireboy) and !fireboy.is_dead:
		var fireboy_screen_pos = fireboy.global_position - camera.global_position + screen_center
		mat.set_shader_parameter("light_pos_1", fireboy_screen_pos)
	else:
		mat.set_shader_parameter("light_pos_1", Vector2(-10000, -10000))

	if is_instance_valid(watergirl) and !watergirl.is_dead:
		var watergirl_screen_pos = watergirl.global_position - camera.global_position + screen_center
		mat.set_shader_parameter("light_pos_2", watergirl_screen_pos)
	else:
		mat.set_shader_parameter("light_pos_2", Vector2(-10000, -10000))
