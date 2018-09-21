extends Node

const FILENAME_NICKNAME = "user://gamine.data"
const FILENAME_SCORE = "user://score.data"

var nickname_file
var score_file

func _ready():
    self.save_highscore(20, "round")
    print(self.get_scores("game"))

func set_nickname(nickname):
    var file = File.new()
    file.open(FILENAME_NICKNAME, File.WRITE)
    file.store_line(nickname)
    file.close()

func get_from_user_table(column):
    var file = File.new()
    if !file.file_exists(FILENAME_NICKNAME):
        return null
    file.open(FILENAME_NICKNAME, File.READ)
    var nickname = file.get_line()
    file.close()
    return [{"nickname": nickname}]

func get_scores(type):
    var file = File.new()
    file.open(FILENAME_SCORE, File.READ_WRITE)
    var content = file.get_as_text()
    file.close()
    return content.split("\n")

func get_highscore(type):
    get_scores(type).sort()

func save_highscore(value, type):
    var file = File.new()
    file.open(FILENAME_SCORE, File.WRITE)
    file.store_line(type + " " + int(value))
    file.close()
