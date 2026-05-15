extends Node

@onready var music: AudioStreamPlayer = $AudioStreamPlayer

var current_music_id := ""

func play_music(id: String):
	if current_music_id == id and music.playing:
		return

	current_music_id = id
	music.play()

func stop_music():
	current_music_id = ""
	music.stop()
