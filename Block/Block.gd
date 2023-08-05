extends StaticBody2D

signal died

var durability = 1
var hits = 0

func _ready():
	add_to_group("blocks")

func hit():
	hits += 1
	if hits >= durability:
		emit_signal("died")
		queue_free()
