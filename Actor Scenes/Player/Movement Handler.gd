extends Node

onready var root = get_parent()
onready var movement_scaling = get_node("/root/Constants").tile_size

func move(x_diff, y_diff):
	root.translate(Vector3(x_diff * movement_scaling, 0, y_diff * movement_scaling))

func _on_Movement_Input_on_input_pressed(action_mapping) -> void:
	if action_mapping == "ui_left":
		move(1, 0)
	if action_mapping == "ui_right":
		move(-1, 0)
	if action_mapping == "ui_up":
		move(0, 1)
	if action_mapping == "ui_down":
		move(0, -1)
