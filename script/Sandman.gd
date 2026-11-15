extends CharacterBody2D

func _process(delta):
	position.x -= Global.game_speed * delta
	if position.x < -2000:
		queue_free()
