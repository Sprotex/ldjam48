extends AnimationPlayer

onready var hihats = get_node("../AudioStreams/HH").get_children()
onready var kicks = get_node("../AudioStreams/Kick").get_children()
onready var snares = get_node("../AudioStreams/Snare").get_children()

onready var partA = get_node("../AudioStreams/PartA").get_children()
onready var partB = get_node("../AudioStreams/PartB").get_children()
onready var crash = get_node("../AudioStreams/Crash").get_children()


onready var current_intensity_arr = [0,0,0,1,1,1,1,1,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,6,6,6,6,6,6,6,6,6,6,6,6,6,7,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9]
onready var intensity = 0
onready var current_intensity = 0

onready var bar_count = 0
onready var first_part = true
onready var half_time = 0

var send_signal = true
onready var change_part = false
onready var parts = [partA, partB]
onready var current_part = 0

var double_time = 0

signal on_beat

func onBeat():
	if send_signal:
		emit_signal("on_beat")
	send_signal = true
	
func increaseIntensity():
	if intensity < 89:
		intensity += 1
	
func decreaseIntensity():
	if intensity > 0:
		intensity -= 1

func mute(array):
	for i in array:
		i.volume_db = -60.0
	
		
func toggleChangePart():
	if change_part:
		change_part = false
	else:
		change_part = true

func halfTime():	
	half_time += 1
	half_time = half_time%2
	pass

func muteAll():
	mute(hihats)
	mute(kicks)
	mute(snares)
	mute(partA)
	mute(partB)	
	mute(crash)

func unmute(part):
	for i in range(current_intensity):
		part[i].volume_db = 0.0

	
func update_tracks():
	current_intensity = current_intensity_arr[intensity]
	bar_count += 1
	print(bar_count%4)
	muteAll()
	var _play_crash = false
	
	if current_intensity > 5:
		double_time = 1
	else:
		double_time = 0
	
	hihats[double_time].volume_db = 0.0
	kicks[double_time].volume_db = 0.0
	snares[double_time].volume_db = 0.0
	
	
	
	if change_part and bar_count%4 == 1:
		current_part += 1
		unmute(parts[current_part%2])		
		toggleChangePart()
	else:
		unmute(parts[current_part%2])
