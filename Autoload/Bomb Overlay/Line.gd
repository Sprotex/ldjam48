extends HBoxContainer

var left
var down
var up
var right

func _ready():
	left = get_node("Left")
	down = get_node("Down")
	up = get_node("Up")
	right = get_node("Right")
	set_inactive()

func set_inactive():
	up.texture = up.inactive_texture
	right.texture = right.inactive_texture
	down.texture = down.inactive_texture
	left.texture = left.inactive_texture

func is_processed():
	return left.texture == left.inactive_texture \
		and right.texture == right.inactive_texture \
		and down.texture == down.inactive_texture \
		and up.texture == up.inactive_texture

func process_input(ui_code):
	if ui_code == "ui_left" and left.texture == left.active_texture:
		left.texture = left.inactive_texture
		print("left")
	if ui_code == "ui_right" and right.texture == right.active_texture:
		right.texture = right.inactive_texture
		print("right")
	if ui_code == "ui_down" and down.texture == down.active_texture:
		down.texture = down.inactive_texture
		print("down")
	if ui_code == "ui_up" and up.texture == up.active_texture:
		up.texture = up.inactive_texture
		print("up")
