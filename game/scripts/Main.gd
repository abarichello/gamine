extends Node

onready var global = get_node("/root/Main/GLOBALS")

func _ready():
    self.modulate = global.current_theme

    var screensize = global.SCREENSIZE
    $Title.rect_position.x = screensize.x / 2 - $Title.rect_size.x / 2
    $Title.rect_position.y = screensize.y / 4 - $Title.rect_size.y / 2

    random_title()

func random_title():
    randomize()
    if randi() % 10 == 0:
        $Title.text = "ENIGMA"
        $SecretTimer.start()
    else:
        $Title.text = "GAMINE"

func _on_SecretTimer_timeout():
    $Title.text = "GAMINE"
