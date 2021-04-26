extends Node

export var main_scene = preload("res://Root.tscn")
onready var constants = get_node("/root/Constants")
onready var game_over_screen = get_node("Control")
var player
var current_level = 0
var enviro

func register_player(_player):
	player = _player

func register_enviro(_enviro):
	enviro = _enviro
	set_next_level()

func set_next_level_from_menu():
	get_tree().change_scene_to(main_scene)

func set_next_level():
	current_level += 1
	enviro.delete_objects()
	enviro.generate_objects()
	if player != null:
		player.translation = Vector3(-constants.tile_size, 0, constants.tile_size)

func game_over():
	game_over_screen.visible = true
	game_over_screen.get_node("VBoxContainer/Label").text = "Level reached: " + str(current_level)

func _on_Button_pressed() -> void:
	game_over_screen.visible = false
	current_level = 0
	set_next_level_from_menu()
