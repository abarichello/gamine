extends Node

var screensize

func _ready():
    screensize = get_node("/root").get_viewport().get_visible_rect().size
    $Title.rect_position.x = screensize.x / 2 - $Title.rect_size.x / 2
    $Title.rect_position.y = screensize.y / 4 - $Title.rect_size.y / 2

    randomize()
    if randi() % 10 == 0:
        $Title.text = "ENIGMA"
        $SecretTimer.start()
    else:
        $Title.text = "GAMINE"

func _on_SecretTimer_timeout():
    $Title.text = "GAMINE"
