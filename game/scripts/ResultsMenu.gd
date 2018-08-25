extends Popup

# DEBUG
func _ready():
    self.popup()

func _on_ResultsMenu_about_to_show():
    self.modulate = GLOBAL.current_theme
