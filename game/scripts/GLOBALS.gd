extends Node

# Colors
const FERGUS_THEME_COLOR = Color(1, 0, 0)
const WYATT_THEME_COLOR = Color(0.1, 0.8, 0.1)
const STRASSE_THEME_COLOR = Color(1, 0.56, 0)
const HIGHLIGHT_COLOR = Color(1, 1, 1)
const LOWLIGHT_COLOR = Color(0.4, 0.4, 0.4)
const DIM_COLOR = Color(0.65, 0.65, 0.65)
const OFF_COLOR = Color(0.15, 0.15, 0.15)

# Themes
var theme_index = 0
var current_theme = self.THEMES[self.theme_index]
const THEMES = [FERGUS_THEME_COLOR, WYATT_THEME_COLOR, STRASSE_THEME_COLOR]
const FERGUS_THEME = 0
const WYATT_THEME = 1
const STRASSE_THEME = 2

# Columns
const COLUMNS_ROW = 7
const COLUMNS_SELECT = 9

# Magic numbers
const PIECE_VARIATIONS = 17
const TIME_AVAILABLE = 15
const ROW_SIZE = 60
const SELECT_SIZE = 40

# Paths
const UPPER_ROW = "/root/Main/Game/2/Enigmas/UpperRow"
const LOWER_ROW = "/root/Main/Game/2/Enigmas/LowerRow"
const UPPER_SELECT = "/root/Main/Game/3/Answers/UpperSelect"
const LOWER_SELECT = "/root/Main/Game/3/Answers/LowerSelect"
const NETWORK = "/root/Main/Network"
const MENU = "/root/Main/Menu"
const DATA = "/root/Main/Game/Data"
const NICKNAME = "/root/Main/Menu/Nickname"
const RESULTSMENU = "/root/Main/Game/ResultsMenu"

const ROOT_URL = "https://leaderboard.barichello.me"
const LOCALHOST = "http://localhost:3000"

# Updates GLOBAL theme variables and calls Main node function to apply theme
func update_theme(index):
    self.theme_index = index
    self.current_theme = self.THEMES[index]
    get_node("/root/Main").apply_theme()
