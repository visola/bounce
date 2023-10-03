extends Node

var initial_lives : int = 3
var lives : int = initial_lives

func _ready():
	Events.listen("reached_bottom", self, "_on_ball_reached_bottom")

func _on_ball_reached_bottom():
	lives -= 1

	Events.emit("life_count_changed", [lives])

	if lives <= 0:
		Events.emit("game_over")
		return

func reset():
	lives = initial_lives
	Events.emit("life_count_changed", [lives])
