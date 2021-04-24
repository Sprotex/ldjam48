extends Node

export var floor_tile = preload("res://Models/Floor_Normal_inherited.tscn")
export var width = 30
export var depth = 30
onready var tree_root = get_tree().get_root()
onready var tile_size = get_node("/root/Constants").tile_size

func _ready() -> void:
	generate_maze()

func _generate_tile(x, z):
	var floor_instance = floor_tile.instance()
	tree_root.call_deferred("add_child", floor_instance)
	floor_instance.translation = Vector3(x * tile_size, 0, z * tile_size)

func generate_maze():
	for x in width:
		for z in depth:
			_generate_tile(-x, z)
