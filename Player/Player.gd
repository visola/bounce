extends KinematicBody2D

var speed = 600

var stopped = true
var initial_y

func _ready():
	initial_y = position.y

func _physics_process(_delta):
	if stopped:
		return

	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1

	move_and_slide(velocity * speed)
	position.y = initial_y # avoid sliding down when ball hits and user is moving

func start():
	stopped = false

func stop():
	stopped = true
