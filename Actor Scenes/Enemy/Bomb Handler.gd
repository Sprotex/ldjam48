extends Node

onready var root = get_parent()
onready var bomb_scene = preload("res://Actor Scenes/Bomb/Bomb.tscn")
onready var enviro_autoload = get_node("/root/EnviroAutoload")

func place_bomb():
	var bomb_instance = bomb_scene.instance()
	enviro_autoload.enviro.add_child(bomb_instance)
	bomb_instance.translation = root.translation

func _on_Movement_Input_on_input_pressed(action_mapping) -> void:
	if action_mapping == "bomb":
		place_bomb()
