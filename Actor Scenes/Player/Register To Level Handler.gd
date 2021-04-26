extends Node

func _ready() -> void:
	get_node("/root/LevelHandler").register_player(get_parent())
	get_node("/root/WorldUpdater").register_player(get_parent())
