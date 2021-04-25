extends Node

onready var player = get_parent()
onready var health = player.get_node("Health")
onready var constants = get_node("/root/Constants")
var on_beat_inputs = 0
var beat_combo = 0

func _ready() -> void:
	var tick_synchronizer = get_node("/root/TickSynchronizer")
	var input = player.get_node("Movement Input")
	input.connect("off_beat_input", self, "_process_off_beat_input")
	input.connect("on_beat_input", self, "_process_on_beat_input")
	tick_synchronizer.connect("on_pre_beat", self, "_process_pre_beat")
	tick_synchronizer.connect("on_post_beat", self, "_process_post_beat")

func _fail_bonus():
	beat_combo = 0

func _increase_beat_combo():
	beat_combo += 1
	if beat_combo % constants.combo_bonus_beats:
		_apply_bonus()

func _apply_bonus():
	beat_combo = 0
	#health.call("TODO")

func _process_off_beat_input():
	_fail_bonus()

func _process_on_beat_input():
	on_beat_inputs += 1
	if on_beat_inputs != 1:
		_fail_bonus()

func _process_pre_beat():
	on_beat_inputs = 0

func _process_post_beat():
	if on_beat_inputs != 1:
		_fail_bonus()
	else:
		_increase_beat_combo()
