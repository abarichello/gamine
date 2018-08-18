extends Node

const SQLite = preload("res://lib/gdsqlite.gdns")

func _ready():
    var db = SQLite.new();
    if !db.open_db("res://sql/gamine.sql"):
        print("Error opening sql file")
        return
