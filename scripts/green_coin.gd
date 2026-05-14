extends Area2D

@onready var animation_player = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	GameManager.green_coins += 1
	animation_player.play("pickup")
