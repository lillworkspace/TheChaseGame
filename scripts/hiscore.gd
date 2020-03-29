extends Label

func _ready():
	set_text("HI " + str(game.score_best))
	game.connect("score_best_changed", self, "_on_score_best_changed")
	
func _on_score_best_changed():
	set_text("HI " + str(game.score_best))
