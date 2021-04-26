extends Node

export (NodePath) var player_path
export var floor_tile = preload("res://Models/Floor Tile/Floor_Normal_inherited.tscn")
export var breakable_tiles = [
	preload("res://Actor Scenes/Placeholder/Breakable Tile 1.tscn"), 
	preload("res://Actor Scenes/Placeholder/Breakable Tile 2.tscn")
]
export var unbreakable_tile = preload("res://Actor Scenes/Placeholder/Unbreakable Tile.tscn")
export var exit_tile = preload("res://Models/Exit/EXIT_inherited.tscn")
export var enemy = preload("res://Actor Scenes/Enemy/Enemy.tscn")
export var width = 30
export var depth = 30
export var unbreakable_tile_inside_chance = 0.01
export var breakable_tile_chance = 0.5
onready var tree_root = get_tree().get_root()
onready var tile_size = get_node("/root/Constants").tile_size
onready var player = get_node(player_path)
onready var level_handler = get_node("/root/LevelHandler")
onready var explodables = []
onready var objects = []
var this_level_exit_x = 0
var this_level_enemy_positions = []

func _ready() -> void:
	randomize()
	level_handler.register_enviro(self)
	var enviro_autoload = get_node("/root/EnviroAutoload")
	enviro_autoload.register_enviro(self)
	
func _spawn_enemy(x, z):
	var enemy_instance = _spawn_tile(x, z, enemy)
	explodables.push_back(enemy_instance)
	objects.push_back(enemy_instance)
	enemy_instance.get_node("Movement Handler").set_player(player)

func _spawn_tile(x, z, tile):
	var tile_instance = tile.instance()
	call_deferred("add_child", tile_instance)
	if tile == breakable_tiles[0] or tile == breakable_tiles[1]:
		explodables.push_back(tile_instance)
	if tile != floor_tile:
		objects.push_back(tile_instance)
	tile_instance.translation = Vector3(x * tile_size, 0, z * tile_size)
	return tile_instance

func _generate_tile(x, z):
	var should_spawn_enemy = false
	for position in this_level_enemy_positions:
		if position.x == x and position.z == z:
			should_spawn_enemy = true
			break
	var should_spawn_exit = x == this_level_exit_x and z == depth - 2
	var should_spawn_unbreakable_tile_border = (x == 0 or z == 0 or -x == width - 1 or z == depth - 1)
	var should_spawn_unbreakable_tile_inside = randf() <= unbreakable_tile_inside_chance
	var is_first_row = z == 1
	should_spawn_unbreakable_tile_inside = should_spawn_unbreakable_tile_inside and not is_first_row
	var should_spawn_breakable_tile = randf() <= breakable_tile_chance
	should_spawn_breakable_tile = should_spawn_breakable_tile and not is_first_row
	_spawn_tile(x, z, floor_tile)
	if should_spawn_exit:
		_spawn_tile(x, z, exit_tile)
	elif should_spawn_unbreakable_tile_border or should_spawn_unbreakable_tile_inside:
		_spawn_tile(x, z, unbreakable_tile)
	elif should_spawn_enemy:
		_spawn_enemy(x, z)
	elif should_spawn_breakable_tile:
		var tile_scene_index = randi() % 2
		var tile = _spawn_tile(x, z, breakable_tiles[tile_scene_index])
		tile.rotation_degrees.y = (randi() % 4) * 90

func delete_objects():
	for child in get_children():
		child.queue_free()

func _generate_enemy_positions():
	this_level_enemy_positions.clear()
	for i in level_handler.current_level:
		var position
		var is_position_occupied = true
		while is_position_occupied:
			var position_x = -1 - randi() % (width - 2)
			var position_z = 1 + randi() % (depth - 2)
			position = Vector3(position_x, 0, position_z)
			is_position_occupied = false
			for generated_position in this_level_enemy_positions:
				if generated_position.x == position.x and generated_position.z == position.z:
					is_position_occupied = true
					break
		this_level_enemy_positions.push_back(position)
		print("GENERATED ", len(this_level_enemy_positions), " ENEMIES")

func generate_objects():
	this_level_exit_x = - 1 - (randi() % (depth - 2))
	_generate_enemy_positions()
	print("Maze size: ", width, " ", depth)
	for x in width:
		for z in depth:
			_generate_tile(-x, z)

func is_spot_explodable(final_x, final_z):
	for object in explodables:
		if object.translation.x == final_x and object.translation.z == final_z:
			return true
	return false

func is_spot_free_to_move(final_x, final_z):
	for object in objects:
		if object.translation.x == final_x and object.translation.z == final_z:
			return false
	return true
