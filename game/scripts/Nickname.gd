extends Popup

# Serializable data
var nickname = "nil"
var nickname_set = false

func _ready():
    self.popup_exclusive = true
    if !nickname_set:
        self.popup()

func serialize(save_file):
    pass

func unserialize(save_data):
    for config in save_data:
        print(config)

func _on_Nickname_about_to_show():
    self.modulate = GLOBAL.current_theme

func _on_TextureButton_pressed():
    var nickname = $TextEdit.text
    if len(nickname) < 3 || len(nickname) > 15:
        $StatusLabel.text = "Nickname should be between 4 and 15 characters."
        return
    self.nickname = nickname
    DB.update_nickname(self.nickname)
    print(DB.get_nickname())
    self.hide()
