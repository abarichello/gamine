extends Popup

# Highlights selected theme and deselects the rest
func highlight():
    $Themes.get_child(GLOBAL.theme_index).select_all()

    # Deselect other themes and hide their quotes
    var tmp = GLOBAL.theme_index
    $Quotes.get_child(tmp).visible = true
    for i in range(2):
        tmp = (tmp + 1) % 3
        $Themes.get_child(tmp).deselect()
        $Quotes.get_child(tmp).visible = false

# --- Signals ---

func _on_Themes_about_to_show():
    self.modulate = GLOBAL.current_theme
    self.highlight()

func _on_FergusASCII_focus_entered():
    GLOBAL.update_theme(GLOBAL.FERGUS_THEME)
    self._on_Themes_about_to_show()

func _on_WyattASCII_focus_entered():
    GLOBAL.update_theme(GLOBAL.WYATT_THEME)
    self._on_Themes_about_to_show()

func _on_StrasseASCII_focus_entered():
    GLOBAL.update_theme(GLOBAL.STRASSE_THEME)
    self._on_Themes_about_to_show()
