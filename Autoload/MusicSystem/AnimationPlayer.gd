extends AnimationPlayer

onready var hihats = get_node("../AudioStreams/HH").get_children()
onready var kicks = get_node("../AudioStreams/Kick").get_children()
onready var snares = get_node("../AudioStreams/Snare").get_children()

onready var partA = get_node("../AudioStreams/PartA").get_children()
onready var partB = get_node("../AudioStreams/PartB").get_children()
onready var crash = get_node("../AudioStreams/Crash").get_children()


onready var current_intensity = 0
onready var intensity = 0

onready var bar_count = 0
onready var first_part = true
onready var half_time = 0

var send_signal = true
onready var change_part = false
onready var parts = [partA, partB]
onready var current_part = 0

var double_time = 0

signal on_beat

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func onBeat():
	if send_signal:
		emit_signal("on_beat")
	send_signal = true
	
func increaseIntensity():
	if intensity < 9:
		intensity += 1
	print(intensity)
func decreaseIntensity():
	if intensity > 0:
		intensity -= 1
	print(intensity)
	
func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_KP_ADD) and just_pressed:
		increaseIntensity()
	if Input.is_key_pressed(KEY_KP_SUBTRACT) and just_pressed:
		decreaseIntensity()
	if Input.is_key_pressed(KEY_P) and just_pressed:
		toggleChangePart()
	if Input.is_key_pressed(KEY_L) and just_pressed:
		halfTime()
	if Input.is_key_pressed(KEY_M) and just_pressed:
		print(current_animation) 

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
	current_intensity = intensity
	bar_count += 1
	print(bar_count%4)
	muteAll()
	var play_crash = false
	
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
