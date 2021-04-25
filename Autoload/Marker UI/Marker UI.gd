extends Control

onready var music = get_node("/root/Music")
onready var tick_synchronizer = get_node("/root/TickSynchronizer")
onready var scroll_container = get_node("ScrollContainer")
onready var constants = get_node("/root/Constants")
var scroll_amount = 0.0
var max_scroll = 0

func _ready() -> void:
	yield(get_tree(), "idle_frame")
	music.get_node("AnimationPlayer").connect("on_beat", self, "_process_beat")
	scroll_container.scroll_horizontal = 123456789
	max_scroll = scroll_container.scroll_horizontal
	scroll_container.scroll_horizontal = 0

func _process(delta: float) -> void:
	scroll_amount += delta
	var t = inverse_lerp(0, constants.beat_length, scroll_amount)
	scroll_container.scroll_horizontal = round(t * max_scroll)

func _process_beat():
	scroll_amount = 0
	scroll_container.scroll_horizontal = 0
