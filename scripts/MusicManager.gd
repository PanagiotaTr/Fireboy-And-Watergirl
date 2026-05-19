extends Node

@onready var music: AudioStreamPlayer = $AudioStreamPlayer

var current_music_id := ""

func _ready() -> void:
	music.volume_db = -15


func play_music(music_name: String) -> void:
	if current_music_id == music_name and music.playing:
		return

	current_music_id = music_name
	
	if music_name == "shared_music":
		music.stream = preload("res://assets/sounds/menu.mp3")

	music.play()


func stop_music() -> void:
	current_music_id = ""
	music.stop()
