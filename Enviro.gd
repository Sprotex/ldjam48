extends Node

export (NodePath) var player_path
export var floor_tile = preload("res://Models/Floor_Normal_inherited.tscn")
export var breakable_tile = preload("res://Actor Scenes/Placeholder/Breakable Tile.tscn")
export var unbreakable_tile = preload("res://Actor Scenes/Placeholder/Unbreakable Tile.tscn")
export var enemy = preload("res://Actor Scenes/Enemy/Enemy.tscn")
export var width = 30
export var depth = 30
export var unbreakable_tile_inside_chance = 0.01
export var breakable_tile_chance = 0.5
onready var tree_root = get_tree().get_root()
onready var tile_size = get_node("/root/Constants").tile_size
onready var player = get_node(player_path)

func _ready() -> void:
	generate_maze()

func _set_position_of_instance(x, z, instance):
	instance.translation = Vector3(x * tile_size, 0, z * tile_size)

func _spawn_enemy(x, z):
	var enemy_instance = enemy.instance()
	tree_root.call_deferred("add_child", enemy_instance)
	_set_position_of_instance(x, z, enemy_instance)
	enemy_instance.get_node("Movement Handler").set_player(player)

func _spawn_tile(x, z, tile):
	var tile_instance = tile.instance()
	tree_root.call_deferred("add_child", tile_instance)
	_set_position_of_instance(x, z, tile_instance)

func _generate_tile(x, z):
	var should_spawn_enemy = (x == -15 and z == 15)
	var should_spawn_unbreakable_tile_border = (x == 0 or z == 0 or -x == width - 1 or z == depth - 1)
	var should_spawn_unbreakable_tile_inside = randf() <= unbreakable_tile_inside_chance
	var should_spawn_breakable_tile = randf() <= breakable_tile_chance
	var floor_instance = floor_tile.instance()
	tree_root.call_deferred("add_child", floor_instance)
	floor_instance.translation = Vector3(x * tile_size, 0, z * tile_size)
	if should_spawn_unbreakable_tile_border or should_spawn_unbreakable_tile_inside:
		_spawn_tile(x, z, unbreakable_tile)
	elif should_spawn_enemy:
		_spawn_enemy(x, z)
	elif should_spawn_breakable_tile:
		_spawn_tile(x, z, breakable_tile)

func generate_maze():
	print("Maze size: ", width, " ", depth)
	for x in width:
		for z in depth:
			_generate_tile(-x, z)
