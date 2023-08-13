extends KinematicBody2D

var HitSound = preload("res://Assets/hit.wav")

var random = RandomNumberGenerator.new()
var speedi = 500
var velocity = Vector2(0, -1 * speedi)

var paused = false

signal reached_bottom

func _ready():
	random.randomize()
	velocity.x = random.randi_range(10, speedi)

func _physics_process(delta):
	if paused:
		return
		
	var viewPortY = get_viewport().get_visible_rect().size.y

	var multiplier = 1
	if abs(velocity.y) < 150 and position.y < 2 * viewPortY / 3:
		multiplier = 2

	var collision_info = move_and_collide(velocity * delta * multiplier)
	
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		play_hit_sound()
		if collision_info.collider.has_method('hit'):
			collision_info.collider.hit()
		
	if position.y >= viewPortY:
		emit_signal('reached_bottom')
		
func clean_streams():
	for child in get_children():
		if child.is_class('AudioStreamPlayer2D'):
			if !child.is_playing():
				remove_child(child)
				child.queue_free()

func play_hit_sound():
	var stream = AudioStreamPlayer2D.new()
	add_child(stream)
	stream.connect('finished', self, 'clean_streams')

	stream.stream = HitSound
	stream.play()

func reset_speed():
	velocity = Vector2(
		random.randi_range(10, 50),
		-1 * speedi
	)

func pause():
	paused = true

func unpause():
	paused = false
