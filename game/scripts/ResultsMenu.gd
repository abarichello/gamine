extends Popup

# DEBUG
func _ready():
    self.popup()

func update_highscore_labels():
    $Container/Highscores/LevelScores/HighscoreLabel.text = "Your highscore: " + str(DB.get_highscore("level"))
    $Container/Highscores/RoundScores/HighscoreLabel.text = "Your highscore: " + str(DB.get_highscore("round"))

func save_local_highscores():
    pass

func send_highscores():
    pass

# --- Signals ---

func _on_ResultsMenu_about_to_show():
    self.modulate = GLOBAL.current_theme
    self.update_highscore_labels()

func _on_SendButton_pressed():
    pass

func _on_DoNotSendButton_pressed():
    pass
