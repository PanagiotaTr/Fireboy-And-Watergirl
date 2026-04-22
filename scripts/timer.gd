extends Panel

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
@onready var minutes_text: Label = $MinutesText
@onready var seconds_text: Label = $SecondsText


func _process(delta: float) -> void:
	time += delta
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) /60
	minutes_text.text = "%02d" % minutes
	seconds_text.text = "%02d" % seconds

func stop() -> void:
	set_process(false)
