extends Node

onready var world_updater = get_node("/root/WorldUpdater")
onready var bomb_overlay = get_node("/root/BombOverlay")
onready var constants = get_node("/root/Constants")
onready var enviro_autoload = get_node("/root/EnviroAutoload")
export var explosion_scene = preload("res://Actor Scenes/Bomb/Explosion Tile.tscn")

var ticks_left = 3
var explosion_radius = 1

func _ready() -> void:
	bomb_overlay.visible = true
	bomb_overlay.set_bomb(self)
	world_updater.connect("on_world_update", self, "_process_world_update")

func setup():
	var additive_ticks = int(bomb_overlay.successful_step_count / 4)
	var additive_radius = int(bomb_overlay.successful_step_count / 4)
	ticks_left = min(7, ticks_left + additive_ticks)
	explosion_radius = min(5, explosion_radius + additive_radius)

func _process_world_update():
	ticks_left -= 1
	if ticks_left <= 0:
		_explode()

func _explode():
	var tile_size = constants.tile_size
	var _enviro = enviro_autoload.enviro
	var bomb = get_parent()
	var width = explosion_radius
	var depth = explosion_radius
	for x in range(-width, width + 1):
		for z in range(-depth, depth + 1):
			var final_x = bomb.translation.x + x * tile_size
			var final_z = bomb.translation.z + z * tile_size
			if x*x + z*z <= explosion_radius * explosion_radius and enviro_autoload.enviro.is_spot_explodable_or_free(final_x, final_z):
				var explosion = explosion_scene.instance()
				explosion.translation = Vector3(final_x, 0, final_z)
				enviro_autoload.enviro.add_child(explosion)
				var explodable = enviro_autoload.enviro.get_explodable_object(final_x, final_z)
				if explodable != null:
					enviro_autoload.enviro.spawn_floor(final_x / tile_size, final_z / tile_size)
					explodable.queue_free()
	bomb.queue_free()
