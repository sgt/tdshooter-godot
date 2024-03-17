class_name Player
extends CharacterBody2D

signal bullet_fired

const DEFAULT_SPEED: float = 300.0

@onready var bullet_timer: Timer = $BulletTimer

@export var speed: float = DEFAULT_SPEED
@export var slow_down_speed: float = DEFAULT_SPEED / 15
@export var is_active: bool = false

func _physics_process(_delta: float):

	move_and_slide()

	if not is_active:
		return

	# turn towards mouse
	look_at(get_global_mouse_position())

	# player movement
	var x_dir = Input.get_axis("left", "right")
	if x_dir:
		velocity.x = x_dir * speed
	else:
		velocity.x = move_toward(velocity.x, 0, slow_down_speed)

	var y_dir = Input.get_axis("up", "down")
	if y_dir:
		velocity.y = y_dir * speed
	else:
		velocity.y = move_toward(velocity.y, 0, slow_down_speed)

	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision:
		var body: Node = collision.get_collider()
		if body.is_in_group("enemies"):
			Events.game_over.emit()

	# shooting
	if Input.is_action_pressed("fire") and bullet_timer.is_stopped():
		bullet_timer.start()
		bullet_fired.emit()
