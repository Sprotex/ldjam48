extends Node

onready var root = get_parent()
onready var tile_size = get_node("/root/Constants").tile_size
onready var constants = get_node("/root/Constants")
onready var bomb_overlay = get_node("/root/BombOverlay")
onready var world_updater = get_node("/root/WorldUpdater")
var player
var random_movement_chance = 0.3
var ignore_next_post_beat = false

func set_player(_player):
	player = _player

func _ready() -> void:
	world_updater.connect("on_world_update", self, "_process_move")
	randomize()

func _move_to_player():
	print("  TO PLAYER")
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
	root.translate(Vector3(x * tile_size, 0, z * tile_size))
	print("  ", x, " ", z)

func _move_random():
	var signum = sign(randf() - 0.5)
	if randf() > 0.5:
		_move(signum, 0)
	else:
		_move(0, signum)

func _process_move():
	print("ENEMY MOVE")
	if randf() >= random_movement_chance:
		_move_to_player()
	else:
		_move_random()
