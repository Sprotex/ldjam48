extends Node

onready var root = get_parent()

func _on_Movement_Input_on_input_pressed(action_mapping) -> void:
	print(action_mapping)
