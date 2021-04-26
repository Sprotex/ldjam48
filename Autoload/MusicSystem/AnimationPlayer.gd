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
onready var current_part_a = true


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
		changePart()
	if Input.is_key_pressed(KEY_L) and just_pressed:
		halfTime()
	if Input.is_key_pressed(KEY_M) and just_pressed:
		print(current_animation) 

func mute(array):
	for i in array:
		i.volume_db = -60.0
func unmute(array):
	for i in array:
		i.volume_db = 0.0	
		
func changePart():
	if current_part_a:
		current_part_a = false
	else:
		current_part_a = true
	
func halfTime():	
	half_time += 2
	half_time = half_time%2
	pass

func muteAll():
	mute(hihats)
	mute(kicks)
	mute(snares)
	mute(partA)
	mute(partB)	
	mute(crash)
	

	
func update_tracks():
	current_intensity = intensity
	bar_count += 1
	print(bar_count%4)
	muteAll()
	var play_crash = false
	hihats[half_time].volume_db = 0.0
	kicks[half_time].volume_db = 0.0
	snares[half_time].volume_db = 0.0
	
	
	for i in range(current_intensity):
		if current_part_a:
			partA[i].volume_db = 0.0
		else:
			partB[i].volume_db = 0.0
