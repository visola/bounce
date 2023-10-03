extends CanvasLayer

var score = 0

var score_label

var lives:Array

func _on_block_died():
	score += 1
	score_label.text = str(score)
	
func _on_life_count_changed(life_count):
	for i in range(lives.size()):
		lives[i].visible = life_count > i

func _ready():
	Events.listen("block_died", self, "_on_block_died")
	Events.listen("life_count_changed", self, "_on_life_count_changed")
	
	score_label = $Control/ScoreContainer/Score
	lives = [
		get_node("Control/LivesContainer/Life 1"),
		get_node("Control/LivesContainer/Life 2"),
		get_node("Control/LivesContainer/Life 3"),
	]
