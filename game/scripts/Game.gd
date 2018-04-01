extends Node2D

const VARIATIONS = 20
const UPPER_ROW = "Enigmas/UpperRow"
const LOWER_ROW = "Enigmas/LowerRow"
const UPPER_SELECT = "Answers/UpperSelect"
const LOWER_SELECT = "Answers/LowerSelect"

var upper_row = []
var lower_row = []
var upper_select = []
var lower_select = []

var level = 0
var selecting_upper = true

func _ready():
    fill_row(upper_row)
    print(upper_row)
    fill_row(lower_row)
    print(lower_row)

    print("---")

    upper_select = shuffle_array(fill_select(upper_row, upper_select))
    print(upper_select)
    lower_select = shuffle_array(fill_select(lower_row, lower_select))
    print(lower_select)

    map_row(upper_row, UPPER_ROW)
    map_row(lower_row, LOWER_ROW)
    map_row(upper_select, UPPER_SELECT)
    map_row(lower_select, LOWER_SELECT)

    # Starting positions
    $">".rect_position = Vector2($Answers.rect_position.x - $">".rect_size.x, $Answers.rect_position.y)

func _input(event):
    var Upper = get_node("Answers/UpperSelect")
    var Lower = get_node("Answers/LowerSelect")

    if event.is_action_pressed("ui_left"):
        if selecting_upper:
            Upper.move_child(Upper.get_child(0), Upper.get_child_count() - 1)
        else:
            Lower.move_child(Lower.get_child(0), Lower.get_child_count() - 1)
    if event.is_action_pressed("ui_right"):
        if selecting_upper:
            Upper.move_child(Upper.get_child(Upper.get_child_count() - 1), 0)
        else:
            Lower.move_child(Lower.get_child(Lower.get_child_count() - 1), 0)
    if event.is_action_pressed("ui_up"):
        selecting_upper = true
        $">".rect_position.y = $Answers/UpperSelect.rect_global_position.y
    if event.is_action_pressed("ui_down"):
        selecting_upper = false
        $">".rect_position.y = $Answers/LowerSelect.rect_global_position.y
    if event.is_action_pressed("ui_accept"):
        check_selection()

func _process(delta):
    # Align V with current level
    var enigma_pos = $Enigmas/UpperRow.rect_global_position
    var move_offset = enigma_pos.x / 14
    $V.rect_global_position = Vector2(enigma_pos.x + move_offset * level, enigma_pos.y - $V.rect_size.y)

func fill_row(row):
    for i in range(0, 7):
        randomize()
        row.append(randi() % VARIATIONS)

# Creates a select row without repeated elements
func fill_select(row_in, row_out):
    for i in range(0, 7):
        var digit = row_in[i]
        if not digit in row_out:
            row_out.append(digit)

    while row_out.size() < 9:
        randomize()
        var digit = randi() % VARIATIONS
        if not digit in row_out:
            row_out.append(digit)
    return row_out

# Why isn't this built in?
func shuffle_array(arr):
    var shuffled = []
    for i in range(arr.size()):
        var x = arr.pop_back()
        randomize()
        if randi() % 2 == 0:
            shuffled.push_back(x)
        else:
            shuffled.push_front(x)
    return shuffled

# Map row of random numbers to pieces/text
func map_row(row, target_path):
    for i in range(0, row.size()):
        var button = Button.new()
        var id = str(row[i])
        button.name = id
        button.text = id
        button.rect_min_size = Vector2(50, 50)
        button.rect_pivot_offset = button.rect_min_size / 2
        get_node(target_path).add_child(button)

# Check the center selection against the
func check_selection():
    var up_ok = int($Answers/UpperSelect.get_child(4).name) == upper_row[level]
    var down_ok = int($Answers/LowerSelect.get_child(4).name) == lower_row[level]
    if up_ok and down_ok:
        level += 1
        print(level)
    else:
        print("WRONG")

# --- Timers ---

func _on_Timer_timeout():
    var marker = $">"
    if marker.text == ">":
        marker.text = ""
    else:
        marker.text = ">"
