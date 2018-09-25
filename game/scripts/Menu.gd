extends Control

export (PackedScene) var Game

var playing = false

func _ready():
    random_title()
    play_pause_menu_music()
    set_nickname_login()

func random_title():
    randomize()
    if randi() % 35 == 0:
        $Title.text = "ENIGMA"
        $Timer.start()

func play_pause_menu_music():
    if !playing:
        $MenuMusic.play()
    else:
        $MenuMusic.stop()
    playing = !playing

func set_nickname_login():
    $TerminalContainer/LoginLabel.text = "GAMINE login: " + $Nickname.nickname

# --- Signals ---

func _on_Timer_timeout():
    $Title.text = "GAMINE"

func _on_StartButton_pressed():
    var GameInstance = Game.instance()
    self.get_parent().add_child(GameInstance)
    self.hide()
    play_pause_menu_music()

func _on_LeaderboardButton_pressed():
    $Leaderboard.popup()

func _on_ThemeButton_pressed():
    $Themes.popup()

func _on_AboutButton_pressed():
    $About.popup()

func _on_HelpButton_pressed():
    $Tutorial.popup()
