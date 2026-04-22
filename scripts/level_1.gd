extends Node2D

@onready var green_text = $GreenLiquidText
@onready var fire_text = $FireboyText
@onready var water_text = $WatergirlText
@onready var message_trigger: Area2D = $MessageTrigger

@onready var liquids_text: RichTextLabel = $LiquidsText
@onready var levels_text: RichTextLabel = $LevelsText
@onready var levers_1_text: RichTextLabel = $Levers1Text
@onready var message_trigger_1: Area2D = $MessageTrigger1
@onready var buttons_text: RichTextLabel = $ButtonsText
@onready var message_trigger_2: Area2D = $MessageTrigger2
@onready var message_trigger_3: Area2D = $MessageTrigger3
@onready var box_text: RichTextLabel = $BoxText
@onready var message_trigger_4: Area2D = $MessageTrigger4
@onready var enemy_text: RichTextLabel = $EnemyText
@onready var message_trigger_5: Area2D = $MessageTrigger5
@onready var doors_text: RichTextLabel = $DoorsText


var shown := false
var shown_2 := false
var shown_3 := false
var shown_4 := false
var shown_5 := false
var shown_6 := false

func _ready() -> void:
	green_text.visible = false
	levels_text.visible = false
	levers_1_text.visible = false
	buttons_text.visible = false
	box_text.visible = false
	enemy_text.visible = false
	doors_text.visible = false


func _on_message_trigger_body_entered(body: Node2D) -> void:
	if shown_2:
		return

	if body.name == "Fireboy" or body.name == "Watergirl":
		shown_2 = true
		
		fire_text.visible = false
		water_text.visible = false
		liquids_text.visible = false
		
		green_text.visible = true


func _on_message_trigger_1_body_entered(body: Node2D) -> void:
	if shown:
		return

	if body.name == "Fireboy" or body.name == "Watergirl":
		shown = true

		green_text.visible = false
		
		levels_text.visible = true
		levers_1_text.visible = true


func _on_message_trigger_2_body_entered(body: Node2D) -> void:
	if shown_3:
		return

	if body.name == "Fireboy" or body.name == "Watergirl":
		shown_3 = true

		levels_text.visible = false
		levers_1_text.visible = false
		
		buttons_text.visible = true


func _on_message_trigger_3_body_entered(body: Node2D) -> void:
	if shown_4:
		return

	if body.name == "Fireboy" or body.name == "Watergirl":
		shown_4 = true

		buttons_text.visible = false
		
		box_text.visible = true


func _on_message_trigger_4_body_entered(body: Node2D) -> void:
	if shown_5:
		return

	if body.name == "Fireboy" or body.name == "Watergirl":
		shown_5 = true

		box_text.visible = false
		
		enemy_text.visible = true


func _on_message_trigger_5_body_entered(body: Node2D) -> void:
	if shown_6:
		return

	if body.name == "Fireboy" or body.name == "Watergirl":
		shown_6 = true

		enemy_text.visible = false
		
		doors_text.visible = true
