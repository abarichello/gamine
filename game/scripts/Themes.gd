extends Popup

# Highlights selected theme and deselects the rest
func highlight_selected():
    $Themes.get_child(GLOBAL.theme_index)

    # Deselect other themes and hide their quotes
    var tmp = GLOBAL.theme_index
    $Quotes.get_child(tmp).visible = true
    for i in range(2):
        tmp = (tmp + 1) % 3
        var Child = $Themes.get_child(tmp)
        dim(Child)
        $Quotes.get_child(tmp).visible = false

func light_up(node):
    node.self_modulate = GLOBAL.HIGHLIGHT_COLOR

func dim(node):
    node.self_modulate = GLOBAL.DIM_COLOR

# --- Signals ---

func _on_Themes_about_to_show():
    self.modulate = GLOBAL.current_theme
    self.highlight_selected()

func _on_Theme_Button_pressed(index):
    GLOBAL.update_theme(index)
    self._on_Themes_about_to_show()
    light_up($Themes.get_child(index))
