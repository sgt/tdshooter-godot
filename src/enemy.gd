class_name Enemy
extends CharacterBody2D

@export var speed: float = 150.0
var player: Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float):
	if player:
		look_at(player.position)
		var direction = (player.position - position).normalized()
		velocity = (direction * speed)
		move_and_slide()
		# move_and_collide(direction * speed)


func killed():
	Events.score_changed.emit(1)
	queue_free()
