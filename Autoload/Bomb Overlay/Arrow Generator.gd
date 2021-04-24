extends Node

export var line_scene = preload("res://Actor Scenes/Arrows Line/Arrows Line.tscn")
onready var parent = get_parent()
onready var lines = parent.get_node("ScrollContainer/Lines")

func _generate_step():
	var line = line_scene.instance()
	line.setup()
	line.up.texture = line.up.inactive_texture
	line.right.texture = line.right.inactive_texture
	line.down.texture = line.down.inactive_texture
	line.left.texture = line.left.inactive_texture
	return line

func generate_empty_step():
	var line = _generate_step()
	lines.add_child(line)

func generate_next_step():
	var line = _generate_step()
	var chance = randf()
	if chance <= 0.25:
		line.up.texture = line.up.active_texture
	elif chance <= 0.5:
		line.right.texture = line.right.active_texture
	elif chance <= 0.75:
		line.down.texture = line.down.active_texture
	else:
		line.left.texture = line.left.active_texture
	lines.add_child(line)
