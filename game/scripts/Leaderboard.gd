extends Control

export (PackedScene) var RankLabel
export (PackedScene) var NicknameLabel
export (PackedScene) var ScoreLabel

const ROOT_URL = "https://leaderboard.barichello.me"
const JSON_HEADER = ["Content-Type: application/json"]
const ROUTE = "/?game=gamine&limit=16"
const TYPE_ROUND = "&type=round"
const TYPE_LEVEL = "&type=level"

var rank_counter = 1

func request_leaderboard():
    $BackPanel.hide()
    self.clear_leaderboard()
    var request = ""

    if $TypeSwitch.pressed:
        request = ROOT_URL + ROUTE + TYPE_ROUND
    else:
        request = ROOT_URL + ROUTE + TYPE_LEVEL
    print("Requesting: " + request)
    $Network.request(request, JSON_HEADER, false, HTTPClient.METHOD_GET)

func clear_leaderboard():
    self.rank_counter = 1
    var nodes = $BackPanel/ScoreStack.get_children()
    for node in nodes:
        node.queue_free()

func error_status():
    $LoadingPanel/StatusText.text = "Error loading"

# --- Leaderboard components ---

func rank():
    var Rank = RankLabel.instance()
    if rank_counter < 10:  # Number padding
        Rank.text = "   " + str(rank_counter)
    else:
        Rank.text = str(rank_counter)
    rank_counter += 1
    return Rank

func nickname(nickname):
    var Nickname = NicknameLabel.instance()
    Nickname.text = nickname
    return Nickname

func score(score):
    var Score = ScoreLabel.instance()
    Score.text = str(score)
    return Score

# --- Signals ---

func _on_Leaderboard_about_to_show():
    self.modulate = GLOBAL.current_theme
    request_leaderboard()

func _on_Network_request_completed(result, response_code, headers, body):
    var json = JSON.parse(body.get_string_from_utf8())
    if response_code == 200:
        for value in json.result.topEntries:
            var entry = value.values()
            # Score HBox contains rank, nickname and score
            var Score = HBoxContainer.new()
            Score.add_child(rank())
            Score.add_child(nickname(entry[0]))
            Score.add_child(score(entry[2]))
            $BackPanel/ScoreStack.add_child(Score)
            $BackPanel.show()
    else:
        error_status()

func _on_TypeSwitch_pressed():
    if $TypeSwitch.pressed:
        $TypeFrame/TypeText.text = "TYPE: ROUND"
    else:
        $TypeFrame/TypeText.text = "TYPE: LEVEL"
    request_leaderboard()
