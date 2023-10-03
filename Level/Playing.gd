extends State

var ball
var player

func _ready():
	ball = owner.get_node("Ball")
	player = owner.get_node("Player")
	
	Events.listen('level_changed', self, '_on_level_changed')
	Events.listen('life_count_changed', self, '_on_life_count_changed')
	

func enter():
	player.start()
	ball.unpause()

func update(_delta):
	if Input.is_action_just_released("ui_accept"):
		emit_signal("transitioned", self, "paused")

func _on_level_changed(_level):
	emit_signal("transitioned", self, "waitingtostart")

func _on_life_count_changed(_lives):
	emit_signal("transitioned", self, "waitingtostart")
