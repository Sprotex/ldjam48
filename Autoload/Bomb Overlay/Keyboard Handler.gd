extends Node

onready var parent = get_parent()
onready var lines = parent.get_node("ScrollContainer/Lines")
var is_enabled = false
var processed_this_tick = false

func set_enabled(_value):
	if not _value:
		if processed_this_tick:
			parent.process_success_input()
		else:
			parent.process_fail_input()
	else:
		processed_this_tick = false
	is_enabled = _value

func _input(event: InputEvent) -> void:
	if is_enabled:
		var keyboard_event = event as InputEventKey
		if keyboard_event and keyboard_event.pressed:
			var debug_key = OS.get_scancode_string(keyboard_event.get_scancode_with_modifiers())
			var current_line = lines.get_child(0)
			var is_success = false
			if current_line.up.texture == current_line.up.active_texture and keyboard_event.is_action("ui_up"):
				print("UP")
				is_success = true
			if current_line.left.texture == current_line.left.active_texture and keyboard_event.is_action("ui_left"):
				print("LEFT")
				is_success = true
			if current_line.right.texture == current_line.right.active_texture and keyboard_event.is_action("ui_down"):
				print("RIGHT")
				is_success = true
			if current_line.down.texture == current_line.down.active_texture and keyboard_event.is_action("ui_down"):
				print("DOWN")
				is_success = true
			if is_success:
				processed_this_tick = true
				current_line.queue_free()
