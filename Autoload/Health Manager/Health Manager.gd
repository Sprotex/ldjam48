extends Node

onready var health_ui = get_node("/root/HealthUi")
onready var constants = get_node("/root/Constants")
var current_health = 1

func _ready() -> void:
	reinit()

func reinit():
	health_ui.set_heart_count(current_health)

func take_damage():
	current_health -= 1
	if current_health <= 0:
		game_over()
	reinit()

func add_heart():
	current_health = min(constants.max_health, current_health + 1)
	reinit()

func game_over():
	get_node("/root/LevelHandler").game_over()
