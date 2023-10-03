extends Node
class_name StateMachine

var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready():
	get_parent().connect('visibility_changed', self, '_on_visibility_changed')

func _on_visibility_changed():
	if get_parent().visible:
		load_states()
		start()
		return
		
	if current_state:
		current_state.exit()

func load_states():
	for child in get_children():
		if child is State:
			# Set initial state to the first state child
			if !initial_state:
				initial_state = child

			states[child.name.to_lower()] = child
			child.connect('transitioned', self, '_on_state_transition')

func start():
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func reset_states():
	for state in states:
		state.reset()

func _process(delta):
	if !get_parent().visible:
		return

	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if !get_parent().visible:
		return

	if current_state:
		current_state.update_physics(delta)

func _on_state_transition(state:State, new_state_name:String):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return

	if current_state:
		current_state.exit()

	current_state = new_state
	new_state.enter()
