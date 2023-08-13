extends Node2D

signal block_died
signal game_over
signal game_started

var Ball = preload('res://Ball/Ball.tscn')

var ball_instance

var running = false
var level = 6

func _on_BlockContainer_block_died(blocks_left):
	emit_signal("block_died", blocks_left)

func _on_Ball_reached_bottom():
	level = 1
	game_over()

func _process(delta):
	if Input.is_action_just_released("ui_select"):
		if !ball_instance:
			ball_instance = Ball.instance()
			add_child(ball_instance)
			ball_instance.position = $Player.position
			ball_instance.position.y -= 50
			ball_instance.reset_speed()
			ball_instance.connect("reached_bottom", self, "_on_Ball_reached_bottom")
			emit_signal("game_started")
			running = true

func clear():
	ball_instance.queue_free()
	ball_instance = null

func game_over():
	clear()
	running = false
	emit_signal("game_over")

func is_running():
	return running
	
func next_level():
	level += 1
	running = false
	clear()
	start()
	
func pause():
	$Player.stop()
	ball_instance.pause()
	
func start():
	$Player.visible = true
	$Player.start()
	
	$BlockContainer.clear()
	$BlockContainer.generate_blocks(level)

func unpause():
	$Player.start()
	ball_instance.unpause()
