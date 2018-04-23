extends Control

export (PackedScene) var Bit
var serial
var id

func setup(id, serial, size):
    self.id = id
    self.serial = serial

    rect_min_size = Vector2(size, size)
    rect_pivot_offset = rect_min_size / 2

    for i in str(serial):
        var bit = Bit.instance()
        $Grid.add_child(bit)
