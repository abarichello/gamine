extends NinePatchRect

export (PackedScene) var Bit

const PADDING = 25

var serial
var id
var size
var SmallDotTexture = preload("res://resources/textures/dot_small.png")

func _ready():
    self.lowlight_grid()

func setup(id, size, texture_type):
    self.id = id
    self.size = size
    self.serial = get_serial(id)
    self.rect_min_size = Vector2(size * 3 + PADDING, size * 3 + PADDING)

    match texture_type:
        0: self.set_texture(load("res://resources/textures/frame_upper.png"))
        1: self.set_texture(load("res://resources/textures/frame_lower.png"))
        2: self.set_texture(load("res://resources/textures/frame.png"))

    var shrink
    if size < 60:
        shrink = true
    generate_bits(shrink)

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
        10: sr = "101010010"
        11: sr = "001011111"
        12: sr = "011011011"
        13: sr = "001010100"
        14: sr = "110010011"
        15: sr = "011010110"
        16: sr = "011011000"
    return sr

# A Piece is a scene composed of 9 bits, this function generates them
func generate_bits(shrink):
    for i in range(self.serial.length()):
        var BitInstance = Bit.instance()
        BitInstance.rect_size = Vector2(60, 60)

        if str(self.serial)[i] == "0":
            BitInstance.self_modulate = GLOBAL.OFF_COLOR

        if shrink:
            BitInstance.texture = self.SmallDotTexture
        $Grid.add_child(BitInstance)

func highlight_grid():
    $Grid.modulate = GLOBAL.HIGHLIGHT_COLOR

func highlight_frame():
    self.self_modulate = GLOBAL.HIGHLIGHT_COLOR

func highlight_all():
    self.highlight_grid()
    self.highlight_frame()

func lowlight_grid():
    $Grid.modulate = GLOBAL.LOWLIGHT_COLOR

func lowlight_frame():
    self.self_modulate = GLOBAL.LOWLIGHT_COLOR

func lowlight_all():
    self.lowlight_grid()
    self.lowlight_frame()
