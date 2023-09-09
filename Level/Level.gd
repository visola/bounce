extends Node2D

signal block_died
signal game_over
signal game_started
signal life_count_changed

var Ball = preload('res://Ball/Ball.tscn')

var ball_instance

var initial_level = 1
var initial_lives = 3

var ready_to_start = false
var running = false

var level = initial_level
var lives = 0

func _on_BlockContainer_block_died(blocks_left):
	emit_signal("block_died", blocks_left)

func _on_Ball_reached_bottom():
	level = initial_level
	lives -= 1

	if lives == 0:
		game_over()
		return
		
	clear()
	running = false
	emit_signal("life_count_changed", lives)

func _process(delta):
	if !ready_to_start:
		return

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
	ready_to_start = false
	clear()
	running = false
	emit_signal("game_over")

func is_running():
	return running
	
func next_level():
	level += 1
	running = false
	clear()
	$BlockContainer.clear()
	$BlockContainer.generate_blocks(level)
	
func pause():
	$Player.stop()
	ball_instance.pause()
	
func start():
	lives = initial_lives

	$Player.visible = true
	$Player.start()
	
	$BlockContainer.clear()
	$BlockContainer.generate_blocks(level)
	
	ready_to_start = true

func unpause():
	$Player.start()
	ball_instance.unpause()
