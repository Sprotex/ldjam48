extends Node

onready var bomb_overlay = get_node("/root/BombOverlay")

func _ready() -> void:
	bomb_overlay.visible = true
	
