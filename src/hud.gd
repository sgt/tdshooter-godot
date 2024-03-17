extends Node2D

@onready var start_screen = $CanvasLayer/StartScreen
@onready var game_over_screen = $CanvasLayer/GameOverScreen
@onready var start_button = $CanvasLayer/StartScreen/StartButton
@onready var quit_button = $CanvasLayer/StartScreen/QuitButton
@onready var score_label = $CanvasLayer/ScoreLabel

func _ready():
	start_button.pressed.connect(func(): Events.start_game.emit())
	quit_button.pressed.connect(func(): Events.quit_game.emit())

	show_start_screen()

func hide_screens():
	start_screen.hide()
	game_over_screen.hide()

func show_start_screen():
	start_screen.show()
	game_over_screen.hide()

func show_game_over_screen():
	start_screen.hide()
	game_over_screen.show()

func set_score(score:int):
	score_label.text = str(score)
