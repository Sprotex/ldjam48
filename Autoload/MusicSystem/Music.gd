extends Spatial

onready var explosion = get_node("Explosion")
onready var tick = get_node("Tick")

func play_explosion():
	explosion.play()

func play_tick():
	tick.play()
