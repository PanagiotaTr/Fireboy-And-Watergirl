extends Node2D

@onready var watergirl: CharacterBody2D = $Watergirl
@onready var fireboy: CharacterBody2D = $Fireboy
@onready var dark_rect = $DarknessLayer/ColorRect
@onready var camera : Camera2D = $Camera2D


func world_to_screen(pos: Vector2) -> Vector2:
	return get_viewport().get_canvas_transform() * pos


func _process(delta):

	var mat = dark_rect.material

	if is_instance_valid(watergirl) and !watergirl.is_dead:
		var watergirl_screen_pos = world_to_screen(watergirl.global_position) + Vector2(0, -15)
		mat.set_shader_parameter("light_pos_1", watergirl_screen_pos)

	if is_instance_valid(fireboy) and !fireboy.is_dead:
		var fireboy_screen_pos = world_to_screen(fireboy.global_position) + Vector2(0, -15)
		mat.set_shader_parameter("light_pos_2", fireboy_screen_pos)

	mat.set_shader_parameter("light_pos_3", Vector2(955, 20))
