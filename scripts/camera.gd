extends Camera2D

onready var chase = utils.get_main_node().get_node("chase")

func _ready():
	pass
	
func _process(delta):
	position = Vector2(chase.position.x, position.y)

func get_total_pos():
	return position + get_offset()
