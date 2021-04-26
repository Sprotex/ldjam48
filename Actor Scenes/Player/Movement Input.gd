extends Node

var is_on_beat = false
onready var processed_inputs = ["ui_up", "ui_down", "ui_left", "ui_right", "bomb"]
onready var bomb_overlay = get_node("/root/BombOverlay")
onready var level_handler = get_node("/root/LevelHandler")

signal on_input_pressed(action_mapping)
signal on_beat_input
signal off_beat_input

func _input(event):
	if not bomb_overlay.visible and not level_handler.game_over_screen.visible:
		for input in processed_inputs:
			process_action(event, input)

func _ready() -> void:
	var tick_synchronizer = get_node("/root/TickSynchronizer")
	tick_synchronizer.connect("on_pre_beat", self, "_process_pre_beat")
	tick_synchronizer.connect("on_post_beat", self, "_process_post_beat")

func _process_pre_beat():
	is_on_beat = true

func _process_post_beat():
	is_on_beat = false

func process_action(event: InputEvent, action_mapping: String):
	if event.is_action_pressed(action_mapping):
		emit_signal("on_input_pressed",action_mapping)
		if is_on_beat:
			emit_signal("on_beat_input")
		else:
			emit_signal("off_beat_input")
