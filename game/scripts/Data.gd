extends Node

const VARIATIONS = 20
const UPPER_ROW = "2/Enigmas/UpperRow"
const LOWER_ROW = "2/Enigmas/LowerRow"
const UPPER_SELECT = "3/Answers/UpperSelect"
const LOWER_SELECT = "3/Answers/LowerSelect"

var upper_row = []
var lower_row = []
var upper_select = []
var lower_select = []

var level = 0
var selecting_upper = true

var screensize

func _ready():
    screensize = get_node("/root").get_viewport().get_visible_rect().size

    fill_row(upper_row)
    fill_row(lower_row)

    upper_select = shuffle_array(fill_select(upper_row, upper_select))
    lower_select = shuffle_array(fill_select(lower_row, lower_select))

    map_row(upper_row, UPPER_ROW, 200)
    map_row(lower_row, LOWER_ROW, 200)
    map_row(upper_select, UPPER_SELECT, 130)
    map_row(lower_select, LOWER_SELECT, 130)

# --- Game Logic ---

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
# Placeholder
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
func map_row(row, target_path, size):
    for i in range(0, row.size()):
        var button = Button.new()
        var id = str(row[i])
        button.name = id
        button.text = id
        button.rect_min_size = Vector2(size, size)
        button.rect_pivot_offset = button.rect_min_size / 2
        get_parent().get_node(target_path).add_child(button)
