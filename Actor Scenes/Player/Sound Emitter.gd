extends Node

onready var music = get_node("/root/Music")
onready var beat = get_parent().get_node("Movement Input")

func _ready() -> void:
	beat.connect("on_beat_input", music, "play_tick")
	
