extends Node

signal dead
signal finished
signal quit

export (PackedScene) var Piece

var upper_row = []
var lower_row = []
var upper_select = []
var lower_select = []

var level_clock = 0.0
var round_clock = 0.0
var level_clock_queue = []

var level = 0
var selecting_upper = true
var dead = false

func _ready():
    fill_row(upper_row)
    fill_row(lower_row)

    upper_select = shuffle_array(fill_select(upper_row, upper_select))
    lower_select = shuffle_array(fill_select(lower_row, lower_select))

    map_line(upper_row, GLOBAL.UPPER_ROW, GLOBAL.ROW_SIZE)
    map_line(lower_row, GLOBAL.LOWER_ROW, GLOBAL.ROW_SIZE)
    map_line(upper_select, GLOBAL.UPPER_SELECT, GLOBAL.SELECT_SIZE)
    map_line(lower_select, GLOBAL.LOWER_SELECT, GLOBAL.SELECT_SIZE)

func _process(delta):
    level_clock += delta
    round_clock += delta

func fill_row(row):
    while len(row) < GLOBAL.COLUMNS_ROW:
        randomize()
        var digit = randi() % GLOBAL.PIECE_VARIATIONS
        if not digit in row:
            row.append(digit)

# Creates a select row without repeated elements
func fill_select(row_in, row_out):
    row_out = row_in.duplicate()

    while row_out.size() < GLOBAL.COLUMNS_SELECT:
        randomize()
        var digit = randi() % GLOBAL.PIECE_VARIATIONS
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
func map_line(row, target_path, size):
    for i in range(row.size()):
        var piece = Piece.instance()
        var id = row[i]
        piece.setup(id, size)
        get_node(target_path).add_child(piece)

# Appends the current level timer to a queue
func save_level_timer():
    self.level_clock_queue.append(self.level_clock)
    print(level_clock_queue)
    self.level_clock = 0.0

# Sends the quickest level time to the server
func send_level_clock():
    self.level_clock_queue.sort()
    var score = self.level_clock_queue.front()
    if score != null:
        var body = {"key": GLOBAL.KEY, "game": "gamine", "type": "level", "nickname": get_node(GLOBAL.NICKNAME).nickname, "score": score}
        get_node(GLOBAL.NETWORK).post("/entry", body)

# Send the time that it took to complete an entire round
func send_round_clock():
    var score = self.round_clock
    print(round_clock)
    var body = {"key": GLOBAL.KEY, "game": "gamine", "type": "round", "nickname": get_node(GLOBAL.NICKNAME).nickname, "score": score}
    get_node(GLOBAL.NETWORK).post("/entry", body)

# --- Signals ---

func _on_Data_dead():
    self.dead = true

func _on_Data_finished():
    # self.level = GLOBAL.COLUMNS_ROW
    var ResultsMenu = get_node(GLOBAL.RESULTSMENU)
    ResultsMenu.level_result = self.level_clock
    ResultsMenu.round_result = self.round_clock
    get_parent().get_node("ResultsMenu").popup()

func _on_Data_quit():
    self.get_parent().queue_free()
    get_node(GLOBAL.MENU).visible = true
