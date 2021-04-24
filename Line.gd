extends HBoxContainer

var left
var down
var up
var right

func setup():
	left = get_node("Left")
	down = get_node("Down")
	up = get_node("Up")
	right = get_node("Right")
