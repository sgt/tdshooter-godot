extends Node2D

const GAME_OVER_PAUSE: float = 1.5

@onready var stage = $Stage
@onready var hud = $HUD

@export var score: int = 0:
	set(value):
		score = value
		hud.set_score(value)

func _ready():
	get_tree().paused = true

	Events.start_game.connect(_on_game_start, CONNECT_DEFERRED)
	Events.game_over.connect(_on_game_over, CONNECT_DEFERRED)
	Events.quit_game.connect(func(): get_tree().quit(), CONNECT_DEFERRED)
	Events.score_changed.connect(func(v: int): score += v)

func _on_game_start():
	hud.hide_screens()
	stage.reset()
	score = 0
	get_tree().paused = false

func _on_game_over():
	stage.deactivate()
	hud.show_game_over_screen()
	await get_tree().create_timer(GAME_OVER_PAUSE).timeout
	get_tree().paused = true
	hud.show_start_screen()
