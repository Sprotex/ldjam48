extends Camera

export (NodePath) var follow_node_path
onready var follow_node = get_node(follow_node_path)
var offset: Vector3

func _ready() -> void:
	offset = translation - follow_node.translation 

func _process(delta: float) -> void:
	var follow_speed_multiplier = 10
	var target_translation = follow_node.translation + offset
	translation = lerp(translation, target_translation, delta * follow_speed_multiplier)
