extends Node2D

@onready var marker = $Marker2D
@onready var timer = $Timer

var villain_scenes = [
	preload("res://scene/Venom.tscn"),
	preload("res://scene/Sandman.tscn"),
	preload("res://scene/Doctor Octopus.tscn")
]
var web_cartridge_scene = preload("res://scene/web_cartridge.tscn")

func _ready():
	randomize()
	start_spawn_timer()

func _on_timer_timeout():
	if randf() < 0.75:
		var chosen_villain = villain_scenes.pick_random().instantiate()
		chosen_villain.position = marker.position
		get_parent().add_child(chosen_villain)
	else:
		var cartridge = web_cartridge_scene.instantiate()
		cartridge.position = marker.position + Vector2(0, -100)
		get_parent().add_child(cartridge)

	start_spawn_timer()

func start_spawn_timer():
	var speed_factor = 400.0 / Global.game_speed
	timer.wait_time = randf_range(1.4, 2.2) * clamp(speed_factor, 0.55, 1.0)
	timer.start()
