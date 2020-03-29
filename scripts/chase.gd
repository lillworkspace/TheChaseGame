extends RigidBody2D

onready var state = StartingState.new(self)

var speed = 100
var fall = 120
var jump = -200

const STATE_STARTING = 0
const STATE_RUNNING = 1
const STATE_JUMPING = 2
const STATE_HIT = 3

signal state_changed

func _ready():
	set_process_input(true)
	set_physics_process(true)
	
	add_to_group(game.GROUP_CHASES)
	connect("body_entered", self, "_on_body_enter")

func _physics_process(delta):
	state.update(delta)
	
func _input(event):
	state.input(event)
	
func _on_body_enter(other_body):
	if state.has_method("_on_body_enter"):
		state._on_body_enter(other_body)
	
func get_state():
	if state is StartingState:
		return STATE_STARTING
	elif state is RunningState:
		return STATE_RUNNING
	elif state is JumpingState:
		return STATE_JUMPING
	elif state is HitState:
		return STATE_HIT
	
func set_state(new_state):
	state.exit()
	
	if new_state == STATE_STARTING:
		state = StartingState.new(self)
	elif new_state == STATE_RUNNING:
		state = RunningState.new(self)
	elif new_state == STATE_JUMPING:
		state = JumpingState.new(self)
	elif new_state == STATE_HIT:
		state = HitState.new(self)

	emit_signal("state_changed", self)

# class StartingState

class StartingState:
	
	var chase
	
	func _init(chase):
		self.chase = chase
		chase.set_linear_velocity(Vector2(chase.speed, chase.fall))
		chase.get_node("sprite").set_frame(0)
		
	func update(delta):
		pass
	
	func input(event):
		if event.is_action_pressed("jump"):
			jump()

	func jump():
		chase.set_linear_velocity(Vector2(chase.speed, chase.jump))
		chase.set_state(chase.STATE_JUMPING)
	
	func exit():
		pass

# class JumpingState

class JumpingState:
	
	var chase
	
	func _init(chase):
		self.chase = chase
		
	func update(delta):
		pass
	
	func input(event):
		pass

	func _on_body_enter(other_body):
		if other_body.is_in_group(game.GROUP_OBSTACLES):
			chase.set_state(chase.STATE_HIT)
		elif other_body.is_in_group(game.GROUP_GROUNDS):
			chase.set_state(chase.STATE_RUNNING)
	
	func exit():
		pass
		
### class RunningState ###

class RunningState:
	
	var chase
	
	func _init(chase):
		self.chase = chase
		chase.set_linear_velocity(Vector2(chase.speed, chase.fall))
		
	func update(delta):
		pass
	
	func input(event):
		# if screen touched
		# if (event is InputEventScreenTouch && event.pressed): 
		if event.is_action_pressed("jump"):
			jump()
	
	func _on_body_enter(other_body):
		if other_body.is_in_group(game.GROUP_OBSTACLES):
			chase.set_state(chase.STATE_HIT)
		elif other_body.is_in_group(game.GROUP_GROUNDS):
			chase.set_state(chase.STATE_RUNNING)
			
	func jump():
		chase.set_linear_velocity(Vector2(chase.speed, chase.jump))
		chase.set_state(chase.STATE_JUMPING)
	
	func exit():
		pass
		
# class HitState

class HitState:
	
	var chase
	
	func _init(chase):
		self.chase = chase
		
	func update(delta):
		chase.set_linear_velocity(Vector2(chase.speed, chase.fall))
		chase.mode = 0
		chase.get_node("sprite").set_frame(1)
	
	func input(event):
		pass
	
	func exit():
		pass
		
