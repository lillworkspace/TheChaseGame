extends Node

const GROUP_OBSTACLES = "obstacles"
const GROUP_GROUNDS = "grounds"
const GROUP_CHASE = "chase"

var score_top = 0 setget _set_score_top
var score_current = 0 setget _set_score_current

signal score_top_changed
signal score_current_changed

func _ready():
	pass 
	
func _set_score_top(new_value):
	score_top = new_value
	emit_signal("score_top_changed")
	
func _set_score_current(new_value):
	score_current = new_value
	emit_signal("score_current_changed")
