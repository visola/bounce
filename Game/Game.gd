extends Node2D

var paused = false
var score = 0


func _on_Level_block_died(blocks_left):
	score += 1
	$Score.text = str(score)
	if blocks_left == 0:
		$Win.play()
		$Level.next_level()

func _ready():
	go_to_inital_menu()
	
func _process(delta):
	if Input.is_action_just_released("ui_select"):
		if !$Level.is_running():
			return

		if paused:
			unpause()
		else:
			pause()

func _on_Level_game_started():
	$PressSpaceToStart.hide()

func _on_InitialMenu_start_game():
	start()

func _on_Level_game_over():
	score = 0
	go_to_inital_menu()

func go_to_inital_menu():
	$InitialMenu.show()
	$PressSpaceToStart.hide()
	$Level.hide()
	$Pause.hide()
	$Score.hide()

func pause():
	paused = true
	$Level.pause()
	$Pause.show()
	
func start():
	$InitialMenu.hide()
	$PressSpaceToStart.show()
	$Level.show()
	$Level.start()
	$Score.show()

func unpause():
	paused = false
	$Level.unpause()
	$Pause.hide()
