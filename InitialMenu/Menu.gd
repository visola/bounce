extends Node2D

func _on_Button_pressed():
	Events.emit("start_game")
