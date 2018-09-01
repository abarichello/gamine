extends HTTPRequest

const JSON_HEADER = ["Content-Type: application/json"]
var debug = bool(OS.get_environment("GAMINE_DEBUG"))

func _ready():
    print("Debug: " + str(debug))
    self.use_threads = true

func post(url, contents):
    var body = JSON.print(contents)
    if not debug:
        self.request(GLOBAL.ROOT_URL + url, JSON_HEADER, false, HTTPClient.METHOD_POST, body)
    else:
        self.request(GLOBAL.LOCALHOST + url, JSON_HEADER, false, HTTPClient.METHOD_POST, body)
