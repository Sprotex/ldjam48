extends Node

onready var root = get_parent()
onready var movement_scaling = get_node("/root/Constants").tile_size
onready var enviro_autoload = get_node("/root/EnviroAutoload")

signal on_player_move

func move(x_diff, z_diff):
	var x = root.translation.x + x_diff * movement_scaling
	var z = root.translation.z + z_diff * movement_scaling
	if enviro_autoload.enviro.is_spot_free_to_move(x, z):
		root.translation = Vector3(x, 0, z)
		emit_signal("on_player_move")

func _on_Movement_Input_on_input_pressed(action_mapping) -> void:
	if action_mapping == "ui_left":
		move(1, 0)
	if action_mapping == "ui_right":
		move(-1, 0)
	if action_mapping == "ui_up":
		move(0, 1)
	if action_mapping == "ui_down":
		move(0, -1)
