extends Node

onready var root = get_parent()

func place_bomb():
	print("PLACE BOMB")

func move(x_diff, y_diff):
	root.translate(Vector3(x_diff, 0, y_diff))

func _on_Movement_Input_on_input_pressed(action_mapping) -> void:
	if action_mapping == "bomb":
		place_bomb()
	if action_mapping == "ui_left":
		move(1, 0)
	if action_mapping == "ui_right":
		move(-1, 0)
	if action_mapping == "ui_up":
		move(0, 1)
	if action_mapping == "ui_down":
		move(0, -1)
