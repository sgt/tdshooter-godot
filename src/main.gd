extends Node2D

func _ready():
	Events.game_over.connect(_on_game_over)

func _on_game_over():
	print("game over")
