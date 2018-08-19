extends Popup

# Serializable data
var nickname = ""

func _ready():
    self.popup_exclusive = true
    var nickname_set = DB.get_from_user_table("nickname_set")
    if len(nickname_set) == 0:
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
    DB.set_nickname(self.nickname)
    self.hide()
