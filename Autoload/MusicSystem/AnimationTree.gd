extends AnimationTree


onready var hihats = get_node("../AudioStreams/HH").get_children()
onready var kicks = get_node("../AudioStreams/KD").get_children()
onready var snares = get_node("../AudioStreams/SN").get_children()
onready var root_notes = get_node("../AudioStreams/Chord").get_children()
onready var current_intensity = 0
onready var intensity = 0

onready var bar_count = 0

onready var anim_tree = get_node("../AnimationTree")


signal on_beat

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func onBeat():
	emit_signal("on_beat")
	
func increaseIntensity():
	if intensity < 4:
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
		var state_machine = anim_tree.get("parameters/StateMachine/playback")
		state_machine.travel("drumTu")
	

	
	
func update_tracks():
	print("tree")
	var selected_root_note = bar_count%4
	current_intensity = intensity
	bar_count += 1
	print(bar_count)
	print(current_intensity)
	
	
	for hihat in hihats:
		hihat.volume_db = -60.0		
	for kick in kicks:
		kick.volume_db = -60.0		
	for snare in snares:
		snare.volume_db = -60.0
	for root in root_notes:
		root.volume_db = -60.0
		
	
	
	hihats[current_intensity%2].volume_db = 0.0
	kicks[current_intensity%2].volume_db = 0.0
	snares[current_intensity].volume_db = 0.0
	
	print(hihats[current_intensity%2].name)
	 
	root_notes[selected_root_note].volume_db = 0.0
	
	
	
	
	
	
	
	
	
	
	
	
	


