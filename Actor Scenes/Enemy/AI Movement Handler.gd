extends Node

onready var root = get_parent()
onready var tile_size = get_node("/root/Constants").tile_size
onready var constants = get_node("/root/Constants")
onready var bomb_overlay = get_node("/root/BombOverlay")
onready var world_updater = get_node("/root/WorldUpdater")
onready var enviro_autoload = get_node("/root/EnviroAutoload")
var player
var random_movement_chance = 0.3
var ignore_next_post_beat = false

func set_player(_player):
	player = _player

func _ready() -> void:
	world_updater.connect("on_world_update", self, "_process_move")
	randomize()

func _move_to_player():
	var player_translation = player.translation
	if root.translation.x > player_translation.x:
		_move(-1, 0)
	elif root.translation.x < player_translation.x:
		_move(1, 0)
	elif root.translation.z > player_translation.z:
		_move(0, -1)
	elif root.translation.z < player_translation.z:
		_move(0, 1)
	else:
		print("  ALREADY ON PLAYER")

func _move(x, z):
	var final_x = root.translation.x + x * tile_size
	var final_z = root.translation.z + z * tile_size
	if enviro_autoload.enviro.is_spot_free_to_move(final_x, final_z):
		root.translation = Vector3(final_x, 0, final_z)

func _move_random():
	var signum = sign(randf() - 0.5)
	if randf() > 0.5:
		_move(signum, 0)
	else:
		_move(0, signum)

func _process_move():
	if randf() >= random_movement_chance:
		_move_to_player()
	else:
		_move_random()
