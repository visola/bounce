extends State

var levelManager
var lifeManager
var scoreManager

func _ready():
	levelManager = owner.get_node("LevelManager")
	lifeManager = owner.get_node("LifeManager")
	scoreManager = owner.get_node("ScoreManager")

func enter():
	levelManager.reset()
	lifeManager.reset()
	scoreManager.reset()

func update(_delta):
	emit_signal("transitioned", self, "waitingtostart")
