extends Node

var screensize = OS.get_screen_size()

const FERGUS_THEME = [Color(1, 0, 0), Color()]
const WYATT_THEME = [Color(0, 1, 0), Color()]
const STRASSE_THEME = [Color(0, 0, 0), Color()]

var selected_theme = 0
const THEMES = [FERGUS_THEME, WYATT_THEME, STRASSE_THEME]

# Columns
const COLUMNS_ROW = 7
const COLUMNS_SELECT = 9

# Magic numbers
const PIECE_VARIATIONS = 18
const TIME_AVAILABLE = 15

# Paths
const UPPER_ROW = "/root/Main/Game/2/Enigmas/UpperRow"
const LOWER_ROW = "/root/Main/Game/2/Enigmas/LowerRow"
const UPPER_SELECT = "/root/Main/Game/3/Answers/UpperSelect"
const LOWER_SELECT = "/root/Main/Game/3/Answers/LowerSelect"
