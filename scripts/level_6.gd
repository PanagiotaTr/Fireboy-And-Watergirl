extends Node2D

@onready var fireboy = $Fireboy
@onready var watergirl = $Watergirl
@onready var dark_rect = $DarknessLayer/ColorRect


func world_to_screen(pos: Vector2) -> Vector2:
	return get_viewport().get_canvas_transform() * pos


func _process(_delta):

	if !is_instance_valid(fireboy):
		fireboy = get_node_or_null("Fireboy")

	if !is_instance_valid(watergirl):
		watergirl = get_node_or_null("Watergirl")

	var mat = dark_rect.material

	# Timer light
	mat.set_shader_parameter("light_pos_3", Vector2(955, 20))

	# Fireboy light
	if is_instance_valid(fireboy) and !fireboy.is_dead:
		var fireboy_screen_pos = world_to_screen(fireboy.global_position) + Vector2(0, -15)
		mat.set_shader_parameter("light_pos_1", fireboy_screen_pos)
	else:
		mat.set_shader_parameter("light_pos_1", Vector2(-10000, -10000))

	# Watergirl light
	if is_instance_valid(watergirl) and !watergirl.is_dead:
		var watergirl_screen_pos = world_to_screen(watergirl.global_position) + Vector2(0, -15)
		mat.set_shader_parameter("light_pos_2", watergirl_screen_pos)
	else:
		mat.set_shader_parameter("light_pos_2", Vector2(-10000, -10000))
