extends RigidBody2D

func _ready():
	print("!")
	set_process_input(true)
	set_physics_process(true)

func _physics_process(delta):
	pass
	
func jump():
	set_linear_velocity(Vector2(get_linear_velocity().x, -100))

func _input(event):
	# if screen touched
	# if (event is InputEventScreenTouch && event.pressed): 
	if event.is_action_pressed("jump"):
		jump()
 
