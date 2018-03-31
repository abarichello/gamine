extends Node2D

const VARIATIONS = 20

var upper_row = []
var lower_row = []
var upper_select = []
var lower_select = []

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

    while row_in.size() != row_out.size():
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
