extends Node

onready var global = get_node("/root/Main/GLOBALS")

func _ready():
    self.modulate = global.current_theme
