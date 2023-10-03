extends State

func _ready():
	Events.listen("start_game", self, "start_game")
	$Menu.hide()

func start_game():
	emit_signal("transitioned", self, "startgame")

func enter():
	$Menu.show()

func exit():
	$Menu.hide()
