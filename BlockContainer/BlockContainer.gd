extends Node2D

var Block = preload('res://Block/Block.tscn')

signal block_died

var margin_x = 25
var margin_y = 25
var desired_padding_x = 15
var desired_padding_y = 15
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
	var block_size = Vector2(80, 23)
	
	var size_x = container_size.x - 2 * margin_x
	var block_count_x = floor(size_x / block_size.x)
	
	var total_size_x = desired_padding_x * (block_count_x - 1) + 2 * margin_x + block_count_x * block_size.x
	while total_size_x > container_size.x:
		block_count_x -= 1
		total_size_x = desired_padding_x * (block_count_x - 1) + 2 * margin_x + block_count_x * block_size.x

	var space_left_x = container_size.x - 2 * margin_x - block_count_x * block_size.x
	var this_padding_x = floor(space_left_x / (block_count_x - 1))

	var block_count_y = 3 * level
	if block_count_y > max_blocks_y:
		block_count_y = max_blocks_y

	for i in block_count_x:
		for j in block_count_y:

			var extraDurability = j - level
			if extraDurability < 0:
				extraDurability = 0

			var block_instance = Block.instance()
			block_instance.durability = extraDurability + 1

			blocks.push_back(block_instance)
			$ReferenceRect.add_child(block_instance)
			block_instance.connect("died", self, "_on_Block_died")

			block_instance.position.x = margin_x + i * (block_size.x + this_padding_x)
			block_instance.position.y = j * (block_size.y + desired_padding_y) + desired_padding_y
