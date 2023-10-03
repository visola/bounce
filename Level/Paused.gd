extends State

var ball
var player

func _ready():
	ball = owner.get_node("Ball")
	player = owner.get_node("Player")
	$Control.hide()
	
func enter():
	ball.pause()
	player.stop()
	$Control.show()
	
func exit():
	$Control.hide()

func update(_delta):
	if Input.is_action_just_released("ui_accept"):
		emit_signal("transitioned", self, "playing")
