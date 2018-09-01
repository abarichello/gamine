extends Popup

var level_result
var round_result

func update_labels():
    $Container/Highscores/LevelScores/HighscoreLabel.text = "Your highscore: " + str(DB.get_highscore("level"))
    $Container/Highscores/RoundScores/HighscoreLabel.text = "Your highscore: " + str(DB.get_highscore("round"))

    $Container/Highscores/LevelScores/CurrentScoreLabel.text = "Current score: " + str(self.level_result)
    $Container/Highscores/RoundScores/CurrentScoreLabel.text = "Current score: " + str(self.round_result)

func save_local_highscores():
    DB.save_highscore(self.level_result, "level")
    DB.save_highscore(self.round_result, "round")

func send_highscores():
    var Data = get_node(GLOBAL.DATA)
    Data.send_level_clock()
    Data.send_round_clock()

func exit():
    self.save_local_highscores()
    var Data = get_node(GLOBAL.DATA)
    get_tree().set_pause(false)
    Data.emit_signal("quit")

# --- Signals ---

func _on_ResultsMenu_about_to_show():
    get_tree().set_pause(true)
    self.modulate = GLOBAL.current_theme
    self.update_labels()

func _on_CancelButton_pressed():
    self.exit()

func _on_SendButton_pressed():
    self.send_highscores()
    self.exit()
