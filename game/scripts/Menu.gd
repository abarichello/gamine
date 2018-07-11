extends Control

onready var global = get_node("/root/Main/GLOBALS")

func _ready():
    var screensize = global.SCREENSIZE
    $Title.rect_position.x = screensize.x / 2 - $Title.rect_size.x / 2
    $Title.rect_position.y = screensize.y / 4 - $Title.rect_size.y / 2
    random_title()

func random_title():
    randomize()
    if randi() % 50 == 0:
        $Title.text = "ENIGMA"
        $SecretTimer.start()

# --- Signals ---

func _on_Timer_timeout():
    $Title.text = "GAMINE"
