extends HTTPRequest

onready var global = get_node("/root/Main/GLOBALS")
const JSON_HEADER = ["Content-Type: application/json"]
const LOCALHOST = "http://localhost:3000"

var debug = true

func _ready():
    if debug:
        test()

func post(url, contents):
    var body = JSON.print(contents)
    if debug:
        self.request(LOCALHOST + url, JSON_HEADER, false, HTTPClient.METHOD_POST, body)
    else:
        self.request(global.ROOT_URL + url, JSON_HEADER, true, HTTPClient.METHOD_POST, body)

func get(url):
    if debug:
        self.request(LOCALHOST + url, JSON_HEADER, false, HTTPClient.METHOD_GET)

# DEBUG
func test():
    #var test = {"game": "gamine", "nickname": "Barichello", "score": 8}
    #post("/leaderboard", test)
    get("/leaderboard?game=gamine&nickname=Barichello")

func _on_Network_request_completed(result, response_code, headers, body):
    var json = JSON.parse(body.get_string_from_utf8())
    print(response_code)
    print(json.result)
