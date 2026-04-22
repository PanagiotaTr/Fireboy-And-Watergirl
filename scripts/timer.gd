extends Panel

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
@onready var minutes_text: Label = $MinutesText
@onready var seconds_text: Label = $SecondsText
@onready var colon_text: Label = $Label

func _ready() -> void:
	var gold = Color("#f2c94c")
	var black = Color("#000000")

	minutes_text.label_settings = LabelSettings.new()
	seconds_text.label_settings = LabelSettings.new()
	colon_text.label_settings = LabelSettings.new()

	minutes_text.label_settings.font_color = gold
	minutes_text.label_settings.outline_color = black
	minutes_text.label_settings.outline_size = 6

	seconds_text.label_settings.font_color = gold
	seconds_text.label_settings.outline_color = black
	seconds_text.label_settings.outline_size = 6

	colon_text.label_settings.font_color = gold
	colon_text.label_settings.outline_color = black
	colon_text.label_settings.outline_size = 6
	
	minutes_text.label_settings.font_size = 35
	seconds_text.label_settings.font_size = 35
	colon_text.label_settings.font_size = 35

func _process(delta: float) -> void:
	time += delta
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) /60
	minutes_text.text = "%02d" % minutes
	seconds_text.text = "%02d" % seconds

func stop() -> void:
	set_process(false)
