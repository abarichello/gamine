extends Control

export (PackedScene) var LevelNumber
onready var Upper = get_node(GLOBAL.UPPER_SELECT)
onready var Lower = get_node(GLOBAL.LOWER_SELECT)

func _ready():
    setup_select_rows()
    setup_answer_rows()
    setup_level_numbers()

func _process(delta):
    # Keep progressbar orientation
    $"1/ProgressBar".value = float($Timeleft.time_left)
    $"1/ProgressBar".rect_rotation = 180
    $"1/TimeLeftText".text = str(int($Timeleft.time_left))

# --- Input ---

func _input(event):
    if !$Data.dead:
        if event.is_action_pressed("ui_left"):
            left()
        if event.is_action_pressed("ui_right"):
            right()
        if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
            switch()
        if event.is_action_pressed("ui_accept"):
            check_selection()

func left():
    play_key_sound()
    if $Data.selecting_upper:
        shift_left(Upper)
        highlight_select_on_shift(Upper)
    else:
        shift_left(Lower)
        highlight_select_on_shift(Lower)

func right():
    play_key_sound()
    if $Data.selecting_upper:
        shift_right(Upper)
        highlight_select_on_shift(Upper)
    else:
        shift_right(Lower)
        highlight_select_on_shift(Lower)

func switch():
    play_switch_sound()
    $Data.selecting_upper = !$Data.selecting_upper
    swap_filler_with_button()

func _on_LeftButton_pressed():
    if !$Data.dead:
        left()

func _on_RightButton_pressed():
    if !$Data.dead:
        right()

func _on_SwitchButton_pressed():
    if !$Data.dead:
        switch()

# --- Game functions ---

func shift_left(node):
    node.move_child(node.get_child(0), node.get_child_count() - 1)

func shift_right(node):
    node.move_child(node.get_child(node.get_child_count() - 1), 0)

func pause():
    if !$PauseMenu.visible:
        get_tree().set_pause(true)
        $Blur.visible = true
        $PauseMenu.show()
    else:
        get_tree().set_pause(false)
        $Blur.visible = false
        $PauseMenu.hide()

# Check the center selection against the current level
func check_selection():
    var up_ok = int(get_node(GLOBAL.UPPER_SELECT).get_child(4).id) == $Data.upper_row[$Data.level]
    var down_ok = int(get_node(GLOBAL.LOWER_SELECT).get_child(4).id) == $Data.lower_row[$Data.level]

    if up_ok and down_ok:
        level_up()
        $Data.save_level_timer()
    else:
        $Data.emit_signal("dead")

func level_up():
    $Data.level += 1
    var level = $Data.level
    highlight_row_on_level_up(level)
    $Timeleft.start()
    $Sound/OkBeep.play()
    print("Level " + str(level))

    if (level >= GLOBAL.COLUMNS_ROW):
        $Data.emit_signal("finished")

func setup_answer_rows():
    get_node(GLOBAL.UPPER_ROW).get_child(0).highlight()
    get_node(GLOBAL.LOWER_ROW).get_child(0).highlight()

# Highlight center pieces while lowlighting other ones
func setup_select_rows():
    var pieces = []
    pieces += get_node(GLOBAL.UPPER_SELECT).get_children()
    pieces += get_node(GLOBAL.LOWER_SELECT).get_children()
    for node in pieces:
        if node.get_position_in_parent() == 4:  # Center piece
            node.highlight()
            continue
        node.lowlight_frame()

# Setup the level number labels under each AnswerRow level
func setup_level_numbers():
    for i in range(1, GLOBAL.COLUMNS_ROW):
        var LevelNumber = $"2/Enigmas/LevelText/01"
        var Dup = LevelNumber.duplicate(DUPLICATE_USE_INSTANCING)
        Dup.get_node("Text").text = "0" + str(i + 1)
        $"2/Enigmas/LevelText".add_child(Dup)

func highlight_row_on_level_up(level):
    if level < GLOBAL.COLUMNS_ROW:
        get_node(GLOBAL.UPPER_ROW).get_child(level - 1).lowlight()
        get_node(GLOBAL.LOWER_ROW).get_child(level - 1).lowlight()
        get_node(GLOBAL.UPPER_ROW).get_child(level).highlight()
        get_node(GLOBAL.LOWER_ROW).get_child(level).highlight()

func highlight_select_on_shift(node):
    var Left = node.get_child(3)
    var Center = node.get_child(4)
    var Right = node.get_child(5)

    Left.lowlight()
    Left.lowlight_frame()
    Center.highlight()
    Center.highlight_frame()
    Right.lowlight()
    Right.lowlight_frame()

func swap_filler_with_button():
    var LeftPanel = $"3/LeftPanel"
    var RightPanel = $"3/RightPanel"
    LeftPanel.move_child(LeftPanel.get_child(1), 0)
    RightPanel.move_child(RightPanel.get_child(1), 0)

# Turns off all pieces that appear on the screen
func deactivate_all_pieces():
    for node in $"3/Answers/UpperSelect".get_children():
        node.deactivate()
    for node in $"3/Answers/LowerSelect".get_children():
        node.deactivate()
    for node in $"2/Enigmas/UpperRow".get_children():
        node.deactivate()
    for node in $"2/Enigmas/LowerRow".get_children():
        node.deactivate()

# --- Sound ---

func play_key_sound():
    $Sound/KeySound.play()

func play_switch_sound():
    $Sound/SwitchSound.play()

# --- Signals ---

func _on_Timeleft_timeout():
    $Data.dead = true
    # self.queue_free()

func _on_ConfirmButton_pressed():
    check_selection()

func _on_PauseButton_pressed():
    self.pause()

func _on_GameOver_timeout():
    $Data.emit_signal("quit")

# Reposition this node when entering tree so Main/Frame is always the last none to be drawn
func _on_Game_tree_entered():
    var position = self.get_parent().get_child_count() - 2
    if position > 0:
        self.get_parent().move_child(self, position)
