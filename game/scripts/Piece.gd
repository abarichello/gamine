extends Control

export (PackedScene) var Bit
onready var OFF_COLOR = get_node("/root/Main/GLOBALS").OFF_COLOR

const padding = 25

var serial
var id
var size

func _ready():
    self.lowlight()

func setup(id, size):
    self.id = id
    self.size = size
    self.serial = get_serial(id)

    self.rect_min_size = Vector2(size * 3 + padding, size * 3 + padding)
    self.rect_pivot_offset = rect_min_size / 2
    generate_bits()

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

# A Piece is a scene composed of 9 bits, this function generates them
func generate_bits():
    for i in range(0, self.serial.length()):
        var BitInstance = Bit.instance()
        BitInstance.rect_min_size = Vector2(self.size, self.size)

        if str(self.serial)[i] == "0":
            BitInstance.self_modulate = self.OFF_COLOR
        $Grid.add_child(BitInstance)

func highlight():
    $Grid.modulate = global.HIGHLIGHT_COLOR

func lowlight():
    $Grid.modulate = global.LOWLIGHT_COLOR
