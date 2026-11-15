extends Area2D

func _process(delta):
	position.x -= Global.game_speed * delta
	if position.x < -100:
		queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		Global.score += 15
		queue_free()
