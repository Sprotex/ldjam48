extends Node

onready var tick_synchronizer = get_node("/root/TickSynchronizer")
onready var bomb_overlay = get_node("/root/BombOverlay")

var ignore_next_post_beat = false
var player

signal on_world_update

func _ready() -> void:
	tick_synchronizer.connect("on_post_beat", self, "_process_post_beat")

func register_player(_player):
	player = _player
	player.get_node("Movement Handler").connect("on_player_move", self, "_process_player_move")

func _process_player_move():
	if bomb_overlay.visible or ignore_next_post_beat:
		return
	ignore_next_post_beat = true
	emit_signal("on_world_update")

func _process_post_beat():
	if bomb_overlay.visible:
		return
	if ignore_next_post_beat:
		ignore_next_post_beat = false
		return
	emit_signal("on_world_update")
