extends TextureRect

export (Texture) var pre_beat_set_texture
export (Texture) var post_beat_set_texture

func _ready() -> void:
	var tick_synchronizer = get_node("/root/TickSynchronizer")
	tick_synchronizer.connect("on_pre_beat", self, "_process_pre_beat")
	tick_synchronizer.connect("on_post_beat", self, "_process_post_beat")

func _process_pre_beat():
	texture = pre_beat_set_texture

func _process_post_beat():
	texture = post_beat_set_texture
