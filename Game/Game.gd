extends Node2D

func _ready():
	start()

func _on_InitialMenu_start_game():
	$InitialMenu.hide()
	$Level.show()
	$Level.start()

func _on_Level_game_over():
	start()

func start():
	$InitialMenu.show()
	$Level.hide()
