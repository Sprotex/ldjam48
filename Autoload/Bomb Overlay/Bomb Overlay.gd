extends Control

onready var music = get_node("/root/Music")
onready var music_system = music.get_node("AnimationPlayer")
onready var arrow_setter = get_node("Arrow Setter")
onready var keyboard_handler = get_node("Keyboard Handler")
onready var tick_synchronizer = get_node("/root/TickSynchronizer")
onready var scroll_handler = get_node("Scroll Handler")
var successful_step_count = 0
var will_next_fail = false
var bomb

func _ready() -> void:
	music_system.connect("on_beat", self, "_process_beat")
	tick_synchronizer.connect("on_pre_beat", self, "_process_pre_beat")
	tick_synchronizer.connect("on_post_beat", self, "_process_post_beat")

func set_bomb(_bomb):
	bomb = _bomb

func _process_beat():
	pass

func _process_pre_beat():
	keyboard_handler.set_enabled(true)

func _process_post_beat():
	keyboard_handler.set_enabled(false)

func process_success_input():
	if not visible:
		return
	arrow_setter.generate_next_step()
	successful_step_count += 1

func process_fail_input():
	if not visible:
		return
	if will_next_fail:
		bomb.setup()
		will_next_fail = false
		visible = false
	else:
		will_next_fail = true

func _on_Bomb_Overlay_visibility_changed() -> void:
	successful_step_count = 0
	yield(get_tree(), "idle_frame")
	if visible:
		arrow_setter.generate_all_steps()
