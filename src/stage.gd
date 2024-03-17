extends Node2D

@onready var enemy_spawn_spots: Array[Node] = $EnemySpawnSpots.get_children()
@onready var bullets_folder = $Bullets
@onready var enemies_folder = $Enemies
@onready var player: Player = $Player
@onready var camera:Camera2D = $Camera2D
@onready var bullet_scene: PackedScene = preload ("bullet.tscn")
@onready var enemy_scene: PackedScene = preload ("enemy.tscn")

func _ready():
	$EnemySpawnTimer.timeout.connect(_on_enemy_spawn_timer_timeout)
	player.bullet_fired.connect(_on_player_bullet_fired)

func _physics_process(_delta:float):
	camera.position = player.position

func reset():
	for e in enemies_folder.get_children():
		e.queue_free()
	
	for b in bullets_folder.get_children():
		b.queue_free()
	
	player.position = Vector2(576,324)
	player.is_active = true

func deactivate():
	player.is_active = false

func _on_enemy_spawn_timer_timeout():
	var spot = enemy_spawn_spots.pick_random()
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.position = spot.position
	enemy.player = player
	enemies_folder.add_child(enemy)

func _on_player_bullet_fired():
	var bullet: Bullet = bullet_scene.instantiate()
	bullet.setup(player)
	bullets_folder.add_child(bullet)
