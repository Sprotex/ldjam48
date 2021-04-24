extends Node

export (NodePath) var player_path
export var floor_tile = preload("res://Models/Floor_Normal_inherited.tscn")
export var enemy = preload("res://Actor Scenes/Enemy/Enemy.tscn")
export var width = 30
export var depth = 30
onready var tree_root = get_tree().get_root()
onready var tile_size = get_node("/root/Constants").tile_size
onready var player = get_node(player_path)

func _ready() -> void:
	generate_maze()

func _spawn_enemy(x, z):
	var enemy_instance = enemy.instance()
	tree_root.call_deferred("add_child", enemy_instance)
	enemy_instance.translation = Vector3(x * tile_size, 0, z * tile_size)
	enemy_instance.get_node("Movement Handler").set_player(player)

func _generate_tile(x, z):
	var should_spawn_enemy = (x == -15 and z == 15)
	var floor_instance = floor_tile.instance()
	tree_root.call_deferred("add_child", floor_instance)
	floor_instance.translation = Vector3(x * tile_size, 0, z * tile_size)
	if should_spawn_enemy:
		_spawn_enemy(x, z)

func generate_maze():
	for x in width:
		for z in depth:
			_generate_tile(-x, z)
