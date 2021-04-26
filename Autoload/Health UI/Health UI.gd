extends MarginContainer

onready var hearts = get_node("HBoxContainer").get_children()

func set_heart_count(current_health):
	for heart in hearts:
		heart.visible = false
	for i in current_health:
		hearts[i].visible = true
