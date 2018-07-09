extends Control

onready var global = get_node("/root/Main/GLOBALS")
onready var Upper = get_node(global.UPPER_SELECT)
onready var Lower = get_node(global.LOWER_SELECT)
export (PackedScene) var LevelNumber

func _ready():
    setup_select_rows()
    setup_answer_rows()
    setup_level_numbers()

func _process(delta):
    $"1/Progress/ProgressBar".value = float($Timeleft.time_left)
    $"1/Progress/ProgressBar".rect_rotation = 180
    $"1/Progress/TimeLeftText".text = str(int($Timeleft.time_left))

func _input(event):
    if not $Data.dead and not $Data.finished:
        if event.is_action_pressed("ui_left"):
            left()
        if event.is_action_pressed("ui_right"):
            right()
        if event.is_action_pressed("ui_up"):
            up()
        if event.is_action_pressed("ui_down"):
            down()
        if event.is_action_pressed("ui_accept"):
            check_selection()

func left():
    if $Data.selecting_upper:
        shift_left(Upper)
        highlight_select_on_shift(Upper)
    else:
        shift_left(Lower)
        highlight_select_on_shift(Lower)

func right():
    if $Data.selecting_upper:
        shift_right(Upper)
        highlight_select_on_shift(Upper)
    else:
        shift_right(Lower)
        highlight_select_on_shift(Lower)

func up():
    $Data.selecting_upper = true
    swap_filler_with_button()

func down():
    $Data.selecting_upper = false
    swap_filler_with_button()

func shift_left(node):
    node.move_child(node.get_child(0), node.get_child_count() - 1)

func shift_right(node):
    node.move_child(node.get_child(node.get_child_count() - 1), 0)

# Check the center selection against the current level
func check_selection():
    var up_ok = int(get_node(global.UPPER_SELECT).get_child(4).id) == $Data.upper_row[$Data.level]
    var down_ok = int(get_node(global.LOWER_SELECT).get_child(4).id) == $Data.lower_row[$Data.level]

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
    print("Level " + str(level))

    if (level >= global.COLUMNS_ROW):
        $Data.emit_signal("finished")

func setup_select_rows():
    get_node(global.UPPER_SELECT).get_child(4).highlight()
    get_node(global.LOWER_SELECT).get_child(4).highlight()

func setup_answer_rows():
    get_node(global.UPPER_ROW).get_child(0).highlight()
    get_node(global.LOWER_ROW).get_child(0).highlight()

# Setup the level number labels under each AnswerRow level
func setup_level_numbers():
    for i in range(1, global.COLUMNS_ROW):
        var LevelNumber = $"2/Enigmas/LevelText/01"
        var Dup = LevelNumber.duplicate(DUPLICATE_USE_INSTANCING)
        Dup.get_node("Text").text = "0" + str(i + 1)
        $"2/Enigmas/LevelText".add_child(Dup)

func highlight_row_on_level_up(level):
    if level < global.COLUMNS_ROW:
        get_node(global.UPPER_ROW).get_child(level - 1).lowlight()
        get_node(global.LOWER_ROW).get_child(level - 1).lowlight()
        get_node(global.UPPER_ROW).get_child(level).highlight()
        get_node(global.LOWER_ROW).get_child(level).highlight()

func highlight_select_on_shift(node):
    node.get_child(3).lowlight()
    node.get_child(4).highlight()
    node.get_child(5).lowlight()

func swap_filler_with_button():
    var LeftPanel = $"3/LeftPanel"
    var RightPanel = $"3/RightPanel"
    LeftPanel.move_child(LeftPanel.get_child(1), 0)
    RightPanel.move_child(RightPanel.get_child(1), 0)

# --- Signals ---

func _on_Timeleft_timeout():
    $Data.dead = true
    # self.queue_free()

func _on_LeftButton_pressed():
    left()

func _on_RightButton_pressed():
    right()

func _on_SwitchButton_pressed():
    if $Data.selecting_upper == true:
        down()
    else:
        up()
