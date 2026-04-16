extends Node2D

signal toggled(state: bool)

var players_in_range: Array[Node] = []
var is_on: bool = false

@onready var interaction_area: Area2D = $InteractionArea
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)
	_update_visual()

func _process(_delta: float) -> void:
	for player in players_in_range:
		if not is_instance_valid(player):
			continue

		if _player_pressed_interact(player):
			activate()
			break

func activate() -> void:
	is_on = not is_on
	_update_visual()
	toggled.emit(is_on)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and not players_in_range.has(body):
		players_in_range.append(body)

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		players_in_range.erase(body)

func _update_visual() -> void:
	sprite.flip_h = is_on

# Check if player has pressed the representing button
func _player_pressed_interact(player: Node) -> bool:
	if player.is_in_group("fireboy"):
		return Input.is_action_just_pressed("interact1") # input == interact1
	elif player.is_in_group("watergirl"):
		return Input.is_action_just_pressed("interact2") # input == interact 2

	return false
