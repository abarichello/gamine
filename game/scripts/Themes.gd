extends Popup

# Highlights selected theme and deselects the rest
func highlight():
    $Themes.get_child(GLOBAL.theme_index).select_all()
    var tmp = GLOBAL.theme_index
    $Quotes.get_child(tmp).visible = true
    for i in range(2):
        tmp = (tmp + 1) % 3
        $Themes.get_child(tmp).deselect()
        $Quotes.get_child(tmp).visible = false

# --- Signals ---
# I am using TextEdit nodes as buttons and their focus_entered signal for buttons presses,
# since the first TextEdit in the scene gets automatically focused there needs to be a 'dud' ($Dud)
# node without the connected signal to prevent unwanted triggers.

func _on_Themes_about_to_show():
    self.modulate = GLOBAL.current_theme
    self.highlight()

func _on_FergusASCII_focus_entered():
    GLOBAL.update_theme(0)
    self._on_Themes_about_to_show()

func _on_WyattASCII_focus_entered():
    GLOBAL.update_theme(1)
    self._on_Themes_about_to_show()

func _on_StrasseASCII_focus_entered():
    GLOBAL.update_theme(2)
    self._on_Themes_about_to_show()
