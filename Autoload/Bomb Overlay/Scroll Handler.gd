extends Node

onready var parent = get_parent()
onready var scroll_container = parent.get_node("ScrollContainer")
onready var lines = parent.get_node("ScrollContainer/Lines")
onready var tick_synchronizer = get_node("/root/TickSynchronizer")
onready var constants = get_node("/root/Constants")
onready var music_system = get_node("/root/Music")
onready var music = music_system.get_node("AnimationPlayer")
var max_scroll = 0
var current_scroll = 0.0

func _ready():
	yield(get_tree(), "idle_frame")
	music.connect("on_beat", self, "process_beat")
	scroll_container.scroll_vertical = 123456789
	max_scroll = scroll_container.scroll_vertical
	print("MAX SCROLL: ", max_scroll)
	scroll_container.scroll_vertical = 0

func _process(delta: float) -> void:
	current_scroll += delta
	var t = inverse_lerp(0, constants.beat_length, current_scroll)
	scroll_container.scroll_vertical = round(t * max_scroll)

func process_beat():
	var current_line = lines.get_child(0)
	lines.move_child(current_line, lines.get_child_count() - 1)
	scroll_container.scroll_vertical = 0
	current_scroll = 0
