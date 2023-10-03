extends AudioStreamPlayer2D

func _ready():
	Events.listen('level_changed', self, '_on_level_changed')

func _on_level_changed(level):
	if level > 1:
		play()
