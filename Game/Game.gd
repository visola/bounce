extends Node2D

var paused = false
var score = 0

func _on_blocks_finished():
	$Win.play()

func _ready():
	go_to_inital_menu()
	Events.listen("blocks_finished", self, "_on_blocks_finished")
	Events.listen("game_started", self, "_on_game_started")
	Events.listen("game_over", self, "_on_game_over")
	
func _process(delta):
	if Input.is_action_just_released("ui_select"):
		if !$Level.is_running():
			return

		if paused:
			unpause()
		else:
			pause()

func _on_game_started():
	$PressSpaceToStart.hide()

func _on_InitialMenu_start_game():
	start()

func _on_game_over():
	score = 0
	go_to_inital_menu()

func _on_Level_life_count_changed(lives):
	$PressSpaceToStart.show()

func go_to_inital_menu():
	$InitialMenu.show()
	$PressSpaceToStart.hide()
	$Level.hide()
	$UserInterface.hide()
	$Pause.hide()

func pause():
	paused = true
	$Level.pause()
	$Pause.show()
	
func start():
	$InitialMenu.hide()
	$PressSpaceToStart.show()
	$Level.show()
	$UserInterface.show()
	$Level.start()

func unpause():
	paused = false
	$Level.unpause()
	$Pause.hide()
