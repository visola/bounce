extends KinematicBody2D

var random = RandomNumberGenerator.new()
var speedi = 350
var velocity = Vector2(0, -1 * speedi)

var paused = false

signal reached_bottom

func _ready():
	random.randomize()
	velocity.x = random.randi_range(10, speedi)

func _physics_process(delta):
	if paused:
		return

	var collision_info = move_and_collide(velocity * delta)
	
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		$Hit.play()
		if collision_info.collider.has_method('hit'):
			collision_info.collider.hit()
		
	if position.y >= get_viewport().get_visible_rect().size.y:
		emit_signal('reached_bottom')

func reset_speed():
	velocity = Vector2(
		random.randi_range(10, speedi),
		-1 * speedi
	)

func pause():
	paused = true

func unpause():
	paused = false
