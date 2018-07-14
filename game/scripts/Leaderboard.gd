extends Control

export (PackedScene) var RankLabel
export (PackedScene) var NicknameLabel
export (PackedScene) var ScoreLabel

const JSON_HEADER = ["Content-Type: application/json"]
const LOCALHOST = "http://localhost:3000/leaderboard/top?game=gamine&type=round&limit=10"
var debug = bool(OS.get_environment("GAMINE_DEBUG"))
var rank_counter = 1

# DEBUG
var content
var test_json

func _ready():
    self.popup()

func request_leaderboard():
    if not debug:
        # TODO: replace with global ROOT_URL
        $Network.request(LOCALHOST, JSON_HEADER, true, HTTPClient.METHOD_GET)
    else:
        $Network.request(LOCALHOST, JSON_HEADER, false, HTTPClient.METHOD_GET)

func add_rank():
    var label = RankLabel.instance()
    if rank_counter < 10:  # Number padding
        label.text = "   " + str(rank_counter)
    else:
        label.text = str(rank_counter)
    $BackPanel/MainStack/ScoresContainer/RankStack.add_child(label, true)
    rank_counter += 1

func add_nickname(nickname):
    var label = NicknameLabel.instance()
    label.text = nickname
    $BackPanel/MainStack/ScoresContainer/NicknameStack.add_child(label, true)

func add_score(score):
    print(score)
    var label = ScoreLabel.instance()
    label.text = str(score)
    $BackPanel/MainStack/ScoresContainer/ScoreStack.add_child(label, true)

# --- Signals ---

func _on_Leaderboard_about_to_show():
    rank_counter = 1
    var file = File.new()
    file.open("res://test.json", File.READ)
    content = file.get_as_text()
    test_json = JSON.parse(content)
    request_leaderboard()

func _on_Network_request_completed(result, response_code, headers, body):
    # var json = JSON.parse(body.get_string_from_utf8())
    # TODO: Handle response code
    var json = test_json
    for value in json.result.topEntries:
        var entry = value.values()
        add_rank()
        add_nickname(entry[0])
        add_score(entry[1])
