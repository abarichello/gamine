extends Control

const JSON_HEADER = ["Content-Type: application/json"]
const LOCALHOST = "http://localhost:3000/leaderboard"

var debug = bool(OS.get_environment("GAMINE_DEBUG"))

func _ready():
    request_leaderboard()

func request_leaderboard():
    if not debug:
        # TODO: replace with global ROOT_URL
        $Network.request(LOCALHOST, JSON_HEADER, true, HTTPClient.METHOD_GET)
    else:
        $Network.request(LOCALHOST, JSON_HEADER, false, HTTPClient.METHOD_GET)

func _on_Network_request_completed(result, response_code, headers, body):
    var json = JSON.parse(body.get_string_from_utf8())
    print(result)
    print(response_code)
    print(json.result)
