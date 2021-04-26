extends Node

onready var parent = get_parent()
onready var lines = parent.get_node("ScrollContainer/Lines")

func _annulate_step(step_index):
	var line = lines.get_child(step_index)
	line.set_inactive()

func _generate_step(step_index):
	var line = lines.get_child(step_index)
	line.set_inactive()
	var chance = randf()
	if chance <= 0.25:
		line.up.texture = line.up.active_texture
	elif chance <= 0.5:
		line.right.texture = line.right.active_texture
	elif chance <= 0.75:
		line.down.texture = line.down.active_texture
	else:
		line.left.texture = line.left.active_texture
	return line

func generate_all_steps():
	for step_index in range(0, 3):
		_annulate_step(step_index)
	for step_index in range(3, lines.get_child_count()):
		_generate_step(step_index)

func generate_next_step():
	_generate_step(lines.get_child_count() - 1)
