extends TextureButton

func _ready():
	connect("pressed", self, "_on_pressed")
	grab_focus()

func _on_pressed():
	hide()
