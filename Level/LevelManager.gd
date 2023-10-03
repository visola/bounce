extends Node

var block_container

var initial_level : int = 1
var level : int = initial_level

func _ready():
	block_container = owner.get_node("BlockContainer")
	block_container.clear()
	block_container.generate_blocks(level)
	
	Events.listen('blocks_finished', self, '_on_blocks_finished')

func _on_blocks_finished():
	level += 1
	block_container.clear()
	block_container.generate_blocks(level)
	
	Events.emit('level_changed', [level])

func reset():
	level = initial_level
	Events.emit('level_changed', [level])
