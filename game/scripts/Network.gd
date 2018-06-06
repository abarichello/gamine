extends HTTPRequest

onready var global = get_node("/root/Main/GLOBALS")
const JSON_HEADER = ["Content-Type: application/json"]

func _ready():
    var test = {"game": "GAMINE", "value": 8}
    make_post("/leaderboard/add", test)

func make_post(url, contents):
    var body = JSON.print(contents)
    self.request(global.ROOT_URL + url, JSON_HEADER, true, HTTPClient.METHOD_POST, body)
