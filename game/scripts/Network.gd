extends HTTPRequest

onready var global = get_node("/root/Main/GLOBALS")

const JSON_HEADER = ["Content-Type: application/json"]
const LOCALHOST = "http://localhost:3000"

var debug = bool(OS.get_environment("GAMINE_DEBUG"))

func post(url, contents):
    var body = JSON.print(contents)
    if not debug:
        self.request(global.ROOT_URL + url, JSON_HEADER, true, HTTPClient.METHOD_POST, body)
    else:
        self.request(LOCALHOST + url, JSON_HEADER, false, HTTPClient.METHOD_POST, body)
