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

var upper_index = 0
var lower_index = 0
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
    if event.is_action_pressed("ui_down"):
        selecting_upper = false

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

func map_row(row, target_path):
    for i in range(0, row.size()):
        var button = Button.new()
        var id = str(row[i])
        button.name = id
        button.text = id
        get_node(target_path).add_child(button)
