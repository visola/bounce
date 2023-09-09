extends StaticBody2D

signal died

var block_1 = load("res://Assets/block_1.png")
var block_2 = load("res://Assets/block_2.png")
var block_3 = load("res://Assets/block_3.png")
var block_4 = load("res://Assets/block_4.png")
var block_5 = load("res://Assets/block_5.png")

var block_textures = [block_1, block_2, block_3, block_4, block_5]

var block_indestructable = load("res://Assets/block_indesctructable.png")

var durability = 1
var hits = 0
var indestructible = false

func _ready():
	set_life(durability)
	add_to_group("blocks")

func hit():
	hits += 1
	set_life(durability - hits)
	
	if indestructible:
		return
	
	if hits >= durability:
		emit_signal("died")
		queue_free()

func set_life(new_life):
	$Durability.hide()
	
	if indestructible:
		$Sprite.texture = block_indestructable
		return
	
	var image_index = new_life - 1
	if new_life > 5:
		image_index = 4
		$Durability.show()
	$Durability.text = str(new_life)
	$Sprite.texture = block_textures[image_index]
