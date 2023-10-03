extends Node

var score : int = 0

func _ready():
	Events.listen('block_died', self, '_on_block_died')

func _on_block_died():
	score += 1
	Events.emit('score_changed', [score])

func reset():
	score = 0
	Events.emit('score_changed', [score])
