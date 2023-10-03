extends State

func _ready():
	$Level.hide()
	Events.listen("game_over", self, "_on_game_over")
	
func enter():
	$Level.show()

func exit():
	$Level.hide()

func _on_game_over():
	emit_signal("transitioned", self, "initialmenu")
