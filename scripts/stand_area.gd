extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_parent().player = body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") and get_parent().player == body:
		get_parent().player = null
