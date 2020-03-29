extends Container


func _ready():
	var chase = utils.get_main_node().get_node("chase")
	if chase:
		chase.connect("state_changed", self, "_on_chase_state_changed")
		
func _on_chase_state_changed(chase):
	if chase.get_state() == chase.STATE_HIT:
		show()

