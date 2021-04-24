extends AnimationPlayer

onready var hihats = get_node("../AudioStreams/HH").get_children()
onready var kicks = get_node("../AudioStreams/KD").get_children()
onready var snares = get_node("../AudioStreams/SN").get_children()




signal onBeat

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func onBeat():
	emit_signal("onBeat")
	

	
func update_tracks():
	for hihat in hihats:
		hihat.volume_db = -60.0
	for kick in kicks:
		kick.volume_db = -60.0
	for snare in snares:
		snare.volume_db = -60.0
	
	hihats[rand_range(0, hihats.size())].volume_db = 0.0
	kicks[rand_range(0, kicks.size())].volume_db = 0.0
	snares[rand_range(0, snares.size())].volume_db = 0.0
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
