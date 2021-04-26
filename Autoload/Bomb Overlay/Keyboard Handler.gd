extends Node

onready var parent = get_parent()
onready var lines = parent.get_node("ScrollContainer/Lines")
var is_enabled = false

func set_enabled(_value):
	if not _value: # disabling, postbeat
		var line = lines.get_child(0)
		if line.is_processed():
			parent.process_success_input()
		else:
			parent.process_fail_input()
	is_enabled = _value

func _process(_delta) -> void:
	if is_enabled:
		var current_line = lines.get_child(1)
		var inputs = ["ui_up", "ui_down", "ui_left", "ui_right"]
		for input in inputs:
			if Input.is_action_just_pressed(input):
				current_line.process_input(input)
