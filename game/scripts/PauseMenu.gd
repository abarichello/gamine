extends Popup

func _ready():
    self.modulate = GLOBAL.current_theme

func _input(event):
    if event.is_action_pressed("ui_escape"):
        get_parent().pause()

# --- Signals ---

func _on_ResumeButton_pressed():
    self.get_parent().get_tree().set_pause(false)
    self.hide()

func _on_QuitButton_pressed():
    self.get_parent().get_tree().set_pause(false)
    get_node(GLOBAL.DATA).emit_signal("quit")
