extends Node

const GROUP_OBSTACLES = "obstacles"
const GROUP_GROUNDS = "grounds"
const GROUP_CHASES = "chases"

var score_best = 0 setget _set_score_best
var score_current = 0 setget _set_score_current

signal score_top_changed
signal score_current_changed

func _ready():
	pass 
	
func _set_score_best(new_value):
	score_best = new_value
	emit_signal("score_top_changed")
	
func _set_score_current(new_value):
	score_current = new_value
	emit_signal("score_current_changed")
