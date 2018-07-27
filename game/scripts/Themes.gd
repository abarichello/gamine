extends Popup

onready var global = get_node("/root/Main/GLOBALS")

func _ready():
    self.popup()

func _on_Themes_about_to_show():
    self.modulate = global.current_theme
