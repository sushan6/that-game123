extends CharacterBody2D

const JUMP_VELOCITY = -850.0
const GRAVITY = 1000.0

@onready var anim = $AnimatedSprite2D
var is_dead = false

func _physics_process(delta):
	if is_dead:
		return

	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if anim.animation != "jump":
			anim.play("jump")
	else:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
		elif anim.animation != "run":
			anim.play("run")

	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.is_in_group("enemy"):
			die()
			break

func die():
	if is_dead:
		return
	is_dead = true
	Global.game_speed = 0.0
	velocity = Vector2.ZERO # Stops all movement instantly
	$CollisionShape2D.set_deferred("disabled", true) # Disables collision so he doesn't push against the enemy
	anim.play("dead")
	await get_tree().create_timer(1.2).timeout
	Global.reset()
	get_tree().reload_current_scene()
