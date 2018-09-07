extends Node

func _ready():
    GLOBAL.load_key()
    GLOBAL.update_theme(0)

func apply_theme():
    self.modulate = GLOBAL.current_theme
