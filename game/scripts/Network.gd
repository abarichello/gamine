extends Node

const JSON_HEADER = ["Content-Type: application/json"]
var debug = bool(OS.get_environment("GAMINE_DEBUG"))
var request_node_id = 0

func _ready():
    print("Debug: " + str(debug))

func post(url, contents):
    var body = JSON.print(contents)

    var request_node = self.get_child(request_node_id)
    # Swap node that is making the request
    self.request_node_id = !self.request_node_id

    print("Requesting ", url, " with ", request_node.name)
    if not debug:
        request_node.request(GLOBAL.ROOT_URL + url, JSON_HEADER, false, HTTPClient.METHOD_POST, body)
    else:
        request_node.request(GLOBAL.LOCALHOST + url, JSON_HEADER, false, HTTPClient.METHOD_POST, body)
