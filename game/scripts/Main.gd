extends Node

func _ready():
    self.save_data()
    self.load_data()
    GLOBAL.update_theme(0)

func apply_theme():
    self.modulate = GLOBAL.current_theme

func save_data():
    var save_file = File.new()
    save_file.open("user://savedata.gamine", File.WRITE)
    var save_nodes = get_node("/root/Main").get_tree().get_nodes_in_group("Serialize")
    for node in save_nodes:
        node.serialize(save_file)
    save_file.close()

func load_data():
    var save_file = File.new()
    if !save_file.file_exists("user://savedata.gamine"):
        print("No save located")
        return

    # Save data is an array of save_data dictionaries
    save_file.open("user://savedata.gamine", File.READ)
    var save_nodes = get_node("/root/Main").get_tree().get_nodes_in_group("Serialize")
    var save_data = []
    while !save_file.eof_reached():
        save_data.append(parse_json(save_file.get_line()))

    for node in save_nodes:
        node.unserialize(save_data)
