extends Popup

func _ready():
    self.modulate = GLOBAL.current_theme

# --- Signals ---

func _on_PauseMenu_about_to_show():
    get_tree().set_pause(true)

func _on_ResumeButton_pressed():
    get_tree().set_pause(false)
    self.hide()

func _on_QuitButton_pressed():
    pass
