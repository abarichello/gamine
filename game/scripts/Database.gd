extends Node

const FILENAME_NICKNAME = "user://gamine.data"
const FILENAME_SCORE = "user://score.data"

var nickname_file
var score_file

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
    var content = []
    while !file.eof_reached() and file.get_as_text() != "":
        var line = file.get_line()
        var split = line.split(" ")
        if split[0] == type:
            content.append(split[1])
    file.close()
    return content

func get_highscore(type):
    var highscore = self.get_scores(type)
    highscore.sort()
    return highscore.back()

func save_highscore(value, type):
    var file = File.new()
    file.open(FILENAME_SCORE, File.READ_WRITE)
    var content = file.get_as_text()
    file.store_line(content + type + " " + str(value))
    file.close()
