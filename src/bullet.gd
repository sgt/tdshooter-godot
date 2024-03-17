class_name Bullet
extends RigidBody2D

@export var velocity: float = 500.0

func setup(player: Player):
	position = player.position + Vector2.from_angle(player.rotation) * 20
	linear_velocity = Vector2.from_angle(player.rotation) * velocity

func _ready():
	body_entered.connect(_on_collision)

func _on_collision(body: Node):
	if body.name == "Arena":
		queue_free()
	elif body.is_in_group("enemies"):
		queue_free()
		(body as Enemy).killed()
