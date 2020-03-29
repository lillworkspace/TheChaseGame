extends Label

func _ready():
	game.connect("score_current_changed", self, "_on_score_current_changed")
	
func _on_score_current_changed():
	set_text(str(game.score_current))
