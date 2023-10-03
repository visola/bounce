extends HBoxContainer

var images

func _ready():
	images = [$"Life 1", $"Life 2", $"Life 3"]
	Events.listen('life_count_changed', self, '_on_life_count_changed')

func _on_life_count_changed(lives):
	for i in range(images.size()):
		var image = images[i]
		if i + 1 > lives:
			image.hide()
		else:
			image.show()
