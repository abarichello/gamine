extends Node

export (PackedScene) var Piece
onready var global = get_node("/root/Main/GLOBALS")

var upper_row = []
var lower_row = []
var upper_select = []
var lower_select = []

var level = 0
var selecting_upper = true

func _ready():
    fill_row(upper_row)
    fill_row(lower_row)

    upper_select = shuffle_array(fill_select(upper_row, upper_select))
    lower_select = shuffle_array(fill_select(lower_row, lower_select))

    map_line(upper_row, global.UPPER_ROW, 001110000, 200)
    map_line(lower_row, global.LOWER_ROW, 110001111, 200)
    map_line(upper_select, global.UPPER_SELECT, 000000111, 130)
    map_line(lower_select, global.LOWER_SELECT, 111000111, 130)

# --- Game Logic ---

func fill_row(row):
    for i in range(0, global.COLUMNS_ROW):
        randomize()
        row.append(randi() % global.PIECE_VARIATIONS)

# Creates a select row without repeated elements
func fill_select(row_in, row_out):
    for i in range(0, global.COLUMNS_ROW):
        var digit = row_in[i]
        if not digit in row_out:
            row_out.append(digit)

    while row_out.size() < global.COLUMNS_SELECT:
        randomize()
        var digit = randi() % global.PIECE_VARIATIONS
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

# Map array of random numbers to pieces/text
func map_line(row, target_path, serial, size):
    for i in range(0, row.size()):
        var piece = Piece.instance()
        var id = str(row[i])
        piece.setup(id, serial, size)
        get_node(target_path).add_child(piece)
