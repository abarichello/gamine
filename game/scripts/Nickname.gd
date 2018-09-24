extends Popup

var nickname = ""

func _ready():
    self.popup_exclusive = true
    var nickname_set = DB.get_from_user_table("nickname_set")
    if typeof(nickname_set) == TYPE_NIL:
        self.popup()
    else:
        self.nickname = DB.get_from_user_table("nickname")[-1]["nickname"]
        print("Loggin in as ", nickname)

func _input(event):
    if event.is_action_pressed("enter"):
        self._on_TextureButton_pressed()

func _on_Nickname_about_to_show():
    self.modulate = GLOBAL.current_theme

func _on_TextureButton_pressed():
    var nickname = $TextEdit.text
    if len(nickname) < 3 || len(nickname) > 15:
        $StatusLabel.text = "Nickname should be between 4 and 15 characters."
        return
    self.nickname = nickname
    DB.set_nickname(self.nickname)
    get_node(GLOBAL.MENU).set_nickname_login()
    self.hide()
