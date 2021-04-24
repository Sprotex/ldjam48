extends Node

var input_pressed = {}
onready var processed_inputs = ["ui_up", "ui_down", "ui_left", "ui_right", "bomb"]
onready var bomb_overlay = get_node("/root/BombOverlay")

signal on_input_pressed(action_mapping)

func process_action(event: InputEvent, action_mapping: String):
	if event.is_action_pressed(action_mapping):
		input_pressed[action_mapping] = true
		emit_signal("on_input_pressed",action_mapping)
	if event.is_action_released(action_mapping):
		input_pressed[action_mapping] = false

func _input(event):
	if not bomb_overlay.visible:
		for input in processed_inputs:
			process_action(event, input)

func _ready() -> void:
	for input in processed_inputs:
		input_pressed[input] = false
