extends Node

onready var level_handler = get_node("/root/LevelHandler")

func _on_Area_area_entered(area: Area) -> void:
	if area is ExitArea:
		level_handler.set_next_level()
