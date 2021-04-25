extends Node

const SYNC_BEATS = 5
var last_beats = []
var usec_avg_diff = 0
onready var pre_beat_timer = get_node("Pre Beat Timer")
onready var post_beat_timers = [get_node("Post Beat Timer 1"), get_node("Post Beat Timer 2")]
onready var constants = get_node("/root/Constants")
onready var post_beat_timer_index = 0

signal on_pre_beat
signal on_post_beat

func _ready() -> void:
	print("Tick sync ready")
	var music = get_node("/root/Music").get_node("AnimationPlayer")
	music.connect("on_beat", self, "_process_beat")
	pre_beat_timer.wait_time = constants.beat_length - constants.beat_tolerance_sec
	pre_beat_timer.connect("timeout", self, "_process_pre_beat")
	for post_beat_timer in post_beat_timers:
		post_beat_timer.wait_time = constants.beat_length + constants.beat_tolerance_sec
		post_beat_timer.connect("timeout", self, "_process_post_beat")

func _process_beat():
	pre_beat_timer.start()
	post_beat_timers[post_beat_timer_index].start()
	post_beat_timer_index = (post_beat_timer_index + 1) % post_beat_timers.size()
	var current_ticks = OS.get_ticks_usec()
	last_beats.append(current_ticks)
	if last_beats.size() > 1:
		usec_avg_diff = 0
		for i in range(1, last_beats.size()):
			usec_avg_diff += last_beats[i] - last_beats[i - 1]
		usec_avg_diff /= last_beats.size() - 1
	if last_beats.size() > SYNC_BEATS:
		last_beats.pop_front()

func _process_pre_beat():
	emit_signal("on_pre_beat")

func _process_post_beat():
	emit_signal("on_post_beat")
