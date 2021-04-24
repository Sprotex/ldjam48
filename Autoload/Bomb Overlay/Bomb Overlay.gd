extends Control

const DEFAULT_PREPARE_BEATS = 3
onready var music_system = get_node("/root/Music").get_node("AnimationPlayer")
onready var countdown_text = get_node("Countdown Label")
onready var arrow_generator = get_node("Arrow Generator")
onready var keyboard_handler = get_node("Keyboard Handler")
onready var tick_synchronizer = get_node("/root/TickSynchronizer")
var prepare_beats

func _ready() -> void:
	music_system.connect("onBeat", self, "_process_beat")
	tick_synchronizer.connect("on_pre_beat", self, "_process_pre_beat")
	tick_synchronizer.connect("on_post_beat", self, "_process_post_beat")

func _process_pre_beat():
	if not countdown_text.visible:
		keyboard_handler.set_enabled(true)

func _process_post_beat():
	if not countdown_text.visible:
		keyboard_handler.set_enabled(false)

func _process_beat():
	if visible:
		if prepare_beats == 0:
			countdown_text.visible = false
		else:
			prepare_beats -= 1
			countdown_text.text = str(prepare_beats)
			if prepare_beats == 0:
				countdown_text.visible = false

func process_success_input():
	print("SUCCESS")
	arrow_generator.generate_next_step()

func process_fail_input():
	print("FAIL")
	visible = false

func _on_Bomb_Overlay_visibility_changed() -> void:
	prepare_beats = DEFAULT_PREPARE_BEATS
	countdown_text.visible = true
	countdown_text.text = str(prepare_beats)
	if visible:
		arrow_generator.generate_next_step()
