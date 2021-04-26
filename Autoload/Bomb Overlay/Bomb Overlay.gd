extends Control

onready var music = get_node("/root/Music")
onready var music_system = music.get_node("AnimationPlayer")
onready var arrow_setter = get_node("Arrow Setter")
onready var keyboard_handler = get_node("Keyboard Handler")
onready var tick_synchronizer = get_node("/root/TickSynchronizer")
onready var scroll_handler = get_node("Scroll Handler")

func _ready() -> void:
	music_system.connect("on_beat", self, "_process_beat")
	tick_synchronizer.connect("on_pre_beat", self, "_process_pre_beat")
	tick_synchronizer.connect("on_post_beat", self, "_process_post_beat")

func _process_beat():
	pass

func _process_pre_beat():
	keyboard_handler.set_enabled(true)

func _process_post_beat():
	keyboard_handler.set_enabled(false)

func process_success_input():
	arrow_setter.generate_next_step()

func process_fail_input():
	visible = false

func _on_Bomb_Overlay_visibility_changed() -> void:
	yield(get_tree(), "idle_frame")
	if visible:
		arrow_setter.generate_all_steps()
