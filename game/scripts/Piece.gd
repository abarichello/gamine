extends Control

const OFF_COLOR = Color(0.2, 0.2, 0.2)
const padding = 25

onready var global = get_node("/root/Main/GLOBALS")
export (PackedScene) var Bit
var serial
var id

func _ready():
    self.lowlight()

func setup(id, size):
    self.id = id
    self.serial = get_serial(id)

    self.rect_min_size = Vector2(size * 3 + padding, size * 3 + padding)
    self.rect_pivot_offset = rect_min_size / 2

    for i in range(0, serial.length()):
        var bit = Bit.instance()
        bit.rect_min_size = Vector2(size, size)

        if str(self.serial)[i] == "0":
            bit.self_modulate = OFF_COLOR
        $Grid.add_child(bit)

func get_serial(id):
    var sr = "11111111"
    match id:
        0:  sr = "001001110"
        1:  sr = "111011001"
        2:  sr = "010101010"
        3:  sr = "000111010"
        4:  sr = "110110110"
        5:  sr = "100010001"
        6:  sr = "010010101"
        7:  sr = "000011011"
        8:  sr = "010111000"
        9:  sr = "110001001"
        10: sr = "001001110"
        11: sr = "101010010"
        12: sr = "001011111"
        13: sr = "011011011"
        14: sr = "001010100"
        15: sr = "110010011"
        16: sr = "011010110"
        17: sr = "011011000"
    return sr

func highlight():
    $Grid.modulate = global.HIGHLIGHT_COLOR

func lowlight():
    $Grid.modulate = global.LOWLIGHT_COLOR
