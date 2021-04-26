extends Node

onready var player = get_parent()
onready var constants = get_node("/root/Constants")
onready var music = get_node("/root/Music")
onready var dynamic_music = music.get_node("AnimationPlayer")
onready var movement = player.get_node("Movement Input")
onready var health_manager = get_node("/root/HealthManager")
onready var tick_synchronizer = get_node("/root/TickSynchronizer")

var good_input_count = 0
var bad_input_count = 0
var health_increase_count = 20
var ignore_post_beat_fail = false

func _ready() -> void:
	movement.connect("on_beat_input", self, "_process_on_beat_input")
	movement.connect("off_beat_input", self, "_process_off_beat_input")
	tick_synchronizer.connect("on_post_beat", self, "_process_post_beat")

func _process_on_beat_input():
	good_input_count += 1
	ignore_post_beat_fail = true
	if good_input_count >= constants.combo_bonus_beats:
		good_input_count = 0
		health_manager.add_heart()
		dynamic_music.increaseIntensity()

func _fail():
	good_input_count = 0
	bad_input_count += 1
	if bad_input_count >= constants.combo_fail_beats:
		dynamic_music.increaseIntensity()
		bad_input_count = 0

func _process_off_beat_input():
	ignore_post_beat_fail = false
	_fail()

func _process_post_beat():
	if ignore_post_beat_fail:
		ignore_post_beat_fail = false
	else:
		_fail()
