extends State

var ball
var player

var initial_run : bool = true
var distance_from_player: int = 30

func _ready():
	ball = owner.get_node("Ball")
	player = owner.get_node("Player")

	$Control.hide()

func enter():
	player.start()

	ball.position = player.position
	ball.position.y -= distance_from_player
	ball.reset_speed()
	ball.pause()

	$Control.show()

func exit():
	$Control.hide()

func update(_delta):
	if Input.is_action_just_released("ui_accept"):
		emit_signal("transitioned", self, "playing")
	
	ball.position = player.position
	ball.position.y -= distance_from_player
