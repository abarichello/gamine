extends Node

func _ready():
    self.save_data()
    self.load_data()
    GLOBAL.update_theme(0)

func apply_theme():
    self.modulate = GLOBAL.current_theme

func save_data():
    var save_nodes = get_node("/root/Main").get_tree().get_nodes_in_group("Serialize")
    for node in save_nodes:
        pass

func load_data():
    var save_nodes = get_node("/root/Main").get_tree().get_nodes_in_group("Serialize")
    for node in save_nodes:
        pass
