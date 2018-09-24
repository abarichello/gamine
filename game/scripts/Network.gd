extends Node

const JSON_HEADER = ["Content-Type: application/json"]
var debug = bool(OS.get_environment("GAMINE_DEBUG"))

func _ready():
    print("Debug: " + str(debug))

func post(url, contents):
    var body = JSON.print(contents)

    # Check if a node is already busy with a request
    var request_node = $RoundRequest
    if $RoundRequest.get_http_client_status() > HTTPClient.STATUS_REQUESTING:
        request_node = $LevelRequest

    print("Requesting ", url, " with ", request_node.name)
    if not debug:
        request_node.request(GLOBAL.ROOT_URL + url, JSON_HEADER, false, HTTPClient.METHOD_POST, body)
    else:
        request_node.request(GLOBAL.LOCALHOST + url, JSON_HEADER, false, HTTPClient.METHOD_POST, body)
