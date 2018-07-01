extends Control

onready var global = get_node("/root/Main/GLOBALS")
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
    if not $Data.dead or not $Data.finished:
        var Upper = get_node(global.UPPER_SELECT)
        var Lower = get_node(global.LOWER_SELECT)

        if event.is_action_pressed("ui_left"):
            if $Data.selecting_upper:
                shift_left(Upper)
                highlight_select_on_shift(Upper)
            else:
                shift_left(Lower)
                highlight_select_on_shift(Lower)

        if event.is_action_pressed("ui_right"):
            if $Data.selecting_upper:
                shift_right(Upper)
                highlight_select_on_shift(Upper)
            else:
                shift_right(Lower)
                highlight_select_on_shift(Lower)

        if event.is_action_pressed("ui_up"):
            $Data.selecting_upper = true

        if event.is_action_pressed("ui_down"):
            $Data.selecting_upper = false

        if event.is_action_pressed("ui_accept"):
            check_selection()

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
    if ($Data.level + 1 > global.COLUMNS_ROW):
        $Data.level = global.COLUMNS_ROW
        $Data.send_level_timer()
        $Data.emit_signal("finished")
    else:
        $Data.level += 1
        highlight_row_on_level_up($Data.level)
        $Timeleft.start()
        print("Level " + str($Data.level))

func setup_select_rows():
    $"3/Answers/UpperSelect".get_child(4).highlight()
    $"3/Answers/LowerSelect".get_child(4).highlight()

func setup_answer_rows():
    $"2/Enigmas/UpperRow".get_child(0).highlight()
    $"2/Enigmas/LowerRow".get_child(0).highlight()

func setup_level_numbers():
    for i in range(1, global.COLUMNS_ROW):
        var levelnumber = $"2/Enigmas/LevelText/01"
        var dup = levelnumber.duplicate(DUPLICATE_USE_INSTANCING)
        dup.get_node("Text").text = "0" + str(i + 1)
        $"2/Enigmas/LevelText".add_child(dup)

func highlight_row_on_level_up(level):
    if level < global.COLUMNS_ROW:
        $"2/Enigmas/UpperRow".get_child(level - 1).lowlight()
        $"2/Enigmas/LowerRow".get_child(level - 1).lowlight()
        $"2/Enigmas/UpperRow".get_child(level).highlight()
        $"2/Enigmas/LowerRow".get_child(level).highlight()

func highlight_select_on_shift(node):
    node.get_child(3).lowlight()
    node.get_child(4).highlight()
    node.get_child(5).lowlight()

# --- Signals ---

func _on_Timeleft_timeout():
    $Data.dead = true
    # self.queue_free()
