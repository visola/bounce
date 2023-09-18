extends KinematicBody2D

var HitSound = preload("res://Assets/hit.wav")
var TemperatureGradient : GradientTexture = preload("res://Ball/temperature_gradient.tres")

var random:RandomNumberGenerator = RandomNumberGenerator.new()
var speedi:int = 500
var velocity:Vector2 = Vector2(0, -1 * speedi)

var paused = false

var max_hit_temperature = 100.0
var temperature_decrease_seconds = 0.4
var hit_count = 0

var time_last_subtract = 0

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
	$Smoke.process_material.direction = Vector3(- velocity.x, -velocity.y, 0)
	
	time_last_subtract += delta
	if time_last_subtract > temperature_decrease_seconds:
		hit_count -= 1
		time_last_subtract = 0

	if hit_count < 0:
		hit_count = 0
	
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		play_hit_sound()
		
		hit_count += 1

		if collision_info.collider.has_method('hit'):
			collision_info.collider.hit()

	if hit_count > max_hit_temperature:
		hit_count = max_hit_temperature

	var temperature = float(hit_count) / max_hit_temperature
	if temperature > 0.4:
		$Smoke.emitting = true
	else:
		$Smoke.emitting = false

	$Light2D.energy = temperature / 2
	$Sprite.modulate = TemperatureGradient.gradient.interpolate(temperature)
	
	if position.y >= viewPortY:
		Events.emit('reached_bottom')
		
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
