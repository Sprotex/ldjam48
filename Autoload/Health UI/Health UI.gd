extends MarginContainer

onready var constants = get_node("/root/Constants")
onready var hearts = get_node("HBoxContainer").get_children()

func set_heart_count(current_health):
	for heart in hearts:
		heart.visible = false
	for i in min(constants.max_health, current_health):
		hearts[i].visible = true
