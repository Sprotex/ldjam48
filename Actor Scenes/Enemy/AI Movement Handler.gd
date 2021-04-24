extends Node

onready var root = get_parent()
onready var tile_size = get_node("/root/Constants").tile_size
var player
var random_movement_chance = 0.3

func set_player(_player):
	player = _player

func _ready() -> void:
	music.get_node("AnimationPlayer").connect("onBeat", self, "_process_beat")
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
	print("  RANDOM")
	var signum = sign(randf() - 0.5)
	if randf() > 0.5:
		_move(signum, 0)
	else:
		_move(0, signum)

func _process_beat():
	print("BEAT")
	if randf() >= random_movement_chance:
		_move_to_player()
	else:
		_move_random()
