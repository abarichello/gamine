extends Control

onready var global = get_node("/root/Main/GLOBALS")

func _ready():
    self.modulate = global.CURRENT_THEME

    for element in $"3/Answers/UpperSelect".get_children():
        element.lowlight()
    for element in $"3/Answers/LowerSelect".get_children():
        element.lowlight()
    $"3/Answers/UpperSelect".get_child(4).highlight()
    $"3/Answers/LowerSelect".get_child(4).highlight()

func _process(delta):
    $"1/ProgressBar".value = float($Timeleft.time_left)

func _input(event):
    if not get_child(0).dead:
        var Upper = get_node(global.UPPER_SELECT)
        var Lower = get_node(global.LOWER_SELECT)

        if event.is_action_pressed("ui_left"):
            if $Data.selecting_upper:
                Upper.move_child(Upper.get_child(0), Upper.get_child_count() - 1)
                highlight_center_piece(global.UPPER_SELECT)
            else:
                Lower.move_child(Lower.get_child(0), Lower.get_child_count() - 1)
                highlight_center_piece(global.LOWER_SELECT)

        if event.is_action_pressed("ui_right"):
            if $Data.selecting_upper:
                Upper.move_child(Upper.get_child(Upper.get_child_count() - 1), 0)
                highlight_center_piece(global.UPPER_SELECT)
            else:
                Lower.move_child(Lower.get_child(Lower.get_child_count() - 1), 0)
                highlight_center_piece(global.LOWER_SELECT)

        if event.is_action_pressed("ui_up"):
            $Data.selecting_upper = true

        if event.is_action_pressed("ui_down"):
            $Data.selecting_upper = false

        if event.is_action_pressed("ui_accept"):
            check_selection()

# Check the center selection against the current level
func check_selection():
    var up_ok = int(get_node(global.UPPER_SELECT).get_child(4).id) == $Data.upper_row[$Data.level]
    var down_ok = int(get_node(global.LOWER_SELECT).get_child(4).id) == $Data.lower_row[$Data.level]

    if up_ok and down_ok:
        level_up()
    else:
        print("WRONG")

func level_up():
    $Data.level += 1
    $Timeleft.start()
    print($Data.level)

func highlight_center_piece(path):
    get_node(path).get_child(3).lowlight()
    get_node(path).get_child(4).highlight()
    get_node(path).get_child(5).lowlight()

# --- Timers ---

func _on_Timeleft_timeout():
    get_child(0).dead = true
    print("rip")
