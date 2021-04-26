extends Node

onready var health_ui = get_node("/root/HealthUi")
var current_health = 1

func _ready() -> void:
	health_ui.set_heart_count(current_health)

func take_damage():
	current_health -= 1
	if current_health <= 0:
		game_over()
	health_ui.set_heart_count(current_health)

func add_heart():
	if current_health < 5:
		current_health += 1
	health_ui.set_heart_count(current_health)

func game_over():
	get_node("/root/LevelHandler").game_over()
