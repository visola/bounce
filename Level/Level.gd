extends Node2D

signal game_over
signal blocks_changed

var Ball = preload('res://Ball/Ball.tscn')

var ball_instance

var score = 0

func _on_BlockContainer_block_died(blocks_left):
	score += 1
	$Score.text = str(score)
	emit_signal("blocks_changed", blocks_left,  $BlockContainer.blocks.size())
	if blocks_left == 0:
		$Win.play()
		clear()
		start()

func _on_Ball_reached_bottom():
	game_over()

func _process(delta):
	if Input.is_action_just_released("ui_select"):
		$PressSpaceToStart.visible = false
		$Score.visible = true
		if !ball_instance:
			ball_instance = Ball.instance()
			add_child(ball_instance)
			ball_instance.position = $Player.position
			ball_instance.position.y -= 50
			ball_instance.reset_speed()
			ball_instance.connect("reached_bottom", self, "_on_Ball_reached_bottom")
		else:
			if $Pause.visible:
				unpause()
			else:
				pause()

func clear():
	ball_instance.queue_free()
	ball_instance = null

func game_over():
	clear()
	emit_signal("game_over")
	
func pause():
	$Pause.visible = true
	$Player.stop()
	ball_instance.pause()
	
func start():
	$PressSpaceToStart.visible = true
	$Player.visible = true
	$Score.visible = false
	$Pause.visible = false
	
	$Player.start()
	
	$BlockContainer.clear()
	$BlockContainer.generate_blocks()

func unpause():
	$Pause.visible = false
	$Player.start()
	ball_instance.unpause()
