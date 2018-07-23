extends Control

export (PackedScene) var Game
onready var global = get_node("/root/Main/GLOBALS")

func _ready():
    random_title()

func random_title():
    randomize()
    if randi() % 50 == 0:
        $Title.text = "ENIGMA"
        $SecretTimer.start()

# --- Signals ---

func _on_Timer_timeout():
    $Title.text = "GAMINE"

func _on_StartButton_pressed():
    var GameInstance = Game.instance()
    var position = self.get_parent().get_child_count() - 1
    self.get_parent().add_child(GameInstance)
    self.hide()

func _on_LeaderboardButton_pressed():
    $Leaderboard.popup()

func _on_ThemeButton_pressed():
    pass

func _on_AboutButton_pressed():
    pass
