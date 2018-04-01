extends Node

func _ready():
    randomize()
    if randi() % 10 == 0:
        $Title.text = "ENIGMA"
        $SecretTimer.start()
    else:
        $Title.text = "GAMINE"

func _on_SecretTimer_timeout():
    $Title.text = "GAMINE"
