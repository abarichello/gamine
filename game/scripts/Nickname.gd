extends Popup

var nickname = ""
var first_time_playing = false

func _ready():
    self.popup_exclusive = true
    self.check_first_time_playing()

func _input(event):
    if event.is_action_pressed("enter"):
        self._on_TextureButton_pressed()

func check_first_time_playing():
    var nickname_set = DB.get_from_user_table("nickname_set")
    if typeof(nickname_set) == TYPE_NIL:
        self.first_time_playing = true
        self.popup()
    else:
        self.nickname = DB.get_from_user_table("nickname")[-1]["nickname"]
        print("Loggin in as ", nickname)

# --- SIGNALS ---

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
