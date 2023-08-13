extends Node2D

var Block = preload('res://Block/Block.tscn')

signal block_died

var margin_x = 20
var margin_y = 10
var padding_x = 10
var padding_y = 10
var max_blocks_y = 16

var blocks = []
var blocks_dead = 0

func _on_Block_died():
	blocks_dead += 1
	emit_signal("block_died", blocks.size() - blocks_dead)

func clear():
	blocks_dead = 0
	for block in blocks:
		if is_instance_valid(block):
			block.queue_free()
	blocks = []

func generate_blocks(level):
	var container_size = $ReferenceRect.get_rect().size
	
	var reference_instance = Block.instance()
	var block_size = reference_instance.get_node("Sprite").get_rect().size

	var block_count_x = ceil((container_size.x - 2 * margin_x) / block_size.x - 1)
	var block_count_y = level
	if block_count_y > max_blocks_y:
		block_count_y = max_blocks_y

	for i in block_count_x:
		for j in block_count_y:
			var block_instance = Block.instance()
			blocks.push_back(block_instance)
			$ReferenceRect.add_child(block_instance)
			block_instance.connect("died", self, "_on_Block_died")
			block_instance.position.x = i * (block_size.x + padding_x) + padding_x
			block_instance.position.y = j * (block_size.y + padding_y) + padding_y
