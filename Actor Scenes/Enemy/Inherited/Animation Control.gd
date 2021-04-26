extends Spatial

onready var animator = get_node("AnimationPlayer")

func play_attack():
	animator.play("monster_attack")
	animator.queue("monster_idle")
