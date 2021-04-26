extends Control

onready var credits_tab = get_node("Credits Tab")
onready var game_tab = get_node("Game Tab")
onready var level_handler = get_node("/root/LevelHandler")

func _on_Start_Button_pressed() -> void:
	level_handler.set_next_level_from_menu()

func _on_Credits_Button_pressed() -> void:
	credits_tab.visible = true
	game_tab.visible = false

func _on_Return_pressed() -> void:
	credits_tab.visible = false
	game_tab.visible = true
