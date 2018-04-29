extends Control

export (PackedScene) var Bit
var serial
var id

func setup(id, serial, size):
    self.id = id
    self.serial = serial

    rect_pivot_offset = rect_min_size / 2

    for i in range(0, 9):
        var bit = Bit.instance()
        self.add_child(bit)
        get_child(i).rect_min_size = Vector2(size, size)
        get_child(i).rect_size = Vector2(size, size)