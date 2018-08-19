extends Node

const SQLite = preload("res://lib/gdsqlite/gdsqlite.gdns")

onready var db = SQLite.new()

func _ready():
    if !db.open_db("gamine"):
        print("ERROR opening db file, creating new one...")

    # Default tables
    var sql = File.new()
    sql.open("res://sql/gamine.sql", File.READ)
    var query = ""
    while !sql.eof_reached():
        query += sql.get_line()
    db.query(query)

func set_nickname(nickname):
    db.query(str("INSERT INTO user (nickname) VALUES ('", nickname, "');"))
    db.query(str("UPDATE user SET nickname_set = 'Y';"))

func get_from_user_table(column):
    return db.fetch_array(str("SELECT ", column, " FROM user;"))

func _on_SQLite_tree_exiting():
    if db.loaded():
        db.close()
