extends RigidBody2D

func _ready():
	set_linear_velocity(Vector2(75, 50))
	set_process_input(true)
	
func jump():
	set_linear_velocity(Vector2(get_linear_velocity().x, -200))

func _input(event):
	# if screen touched
	# if (event is InputEventScreenTouch && event.pressed): 
	if event.is_action_pressed("jump"):
		jump()
 
