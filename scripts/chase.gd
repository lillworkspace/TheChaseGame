extends RigidBody2D

onready var state = JumpingState.new(self) # RunningState.new()

var speed = 75
var fall = 50

const STATE_RUNNING = 0
const STATE_JUMPING = 1
const STATE_HIT = 2
const STATE_STOPPED = 3

signal state_changed

func _ready():
	set_process_input(true)
	set_physics_process(true)
	connect("body_entered", self, "_on_body_enter")

func _physics_process(delta):
	state.update(delta)
	
func _input(event):
	state.input(event)
	
func _on_body_enter(other_body):
	if state.has_method("on_body_enter"):
		state.on_body_enter(other_body)
	
func get_state():
	if state is RunningState:
		return STATE_RUNNING
	elif state is JumpingState:
		return STATE_JUMPING
	elif state is HitState:
		return STATE_HIT
	elif state is StoppedState:
		return STATE_STOPPED
	
func set_state(new_state):
	state.exit()
	
	if new_state == STATE_RUNNING:
		state = RunningState.new(self)
	elif new_state == STATE_JUMPING:
		state = JumpingState.new(self)
	elif new_state == STATE_HIT:
		state = HitState.new(self)
	elif new_state == STATE_STOPPED:
		state = StoppedState.new(self)

	emit_signal("state_changed", self)

# class RunningState

class RunningState:
	
	var chase
	
	func _init(chase):
		self.chase = chase
		chase.set_linear_velocity(Vector2(chase.speed, chase.fall))
		
	func update(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		pass
		
### class JumpingState ###

class JumpingState:
	
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
	
	func on_body_enter(other_body):
		if other_body.is_in_group(game.GROUP_OBSTACLES):
			chase.set_state(chase.STATE_HIT)
		elif other_body.is_in_group(game.GROUP_GROUNDS):
			chase.set_state(chase.STATE_JUMPING)
			
	func jump():
		chase.set_linear_velocity(Vector2(chase.get_linear_velocity().x, -200))
	
	func exit():
		pass
		
# class HitState

class HitState:
	
	var chase
	
	func _init(chase):
		self.chase = chase
		
	func update(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		pass
		
# class StoppedState
		
class StoppedState:
	
	var chase
	
	func _init(chase):
		self.chase = chase
		
	func update(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		pass
