extends Popup

var nickname

func _ready():  # DEBUG
    self.popup()

func serialize():
    return { "nickname": self.nickname }

func _on_Nickname_about_to_show():
    self.modulate = GLOBAL.current_theme

func _on_TextureButton_pressed():
    self.nickname = $TextEdit.text
    if len(nickname) < 3:
        $StatusLabel.text = "Nickname is too short"
        return
    self.hide()
