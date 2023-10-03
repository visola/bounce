extends Label

func _ready():
	Events.listen('score_changed', self, '_on_score_changed')

func _on_score_changed(new_score:int):
	text = str(new_score)
