extends Node

func _ready() -> void:
	get_node("/root/Music").get_node("AnimationPlayer").connect("onBeat", self, "print_emit")

func print_emit():
	print("EMIT")
