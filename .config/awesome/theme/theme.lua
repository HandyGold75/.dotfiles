--   _____                           _
--  |  __ \                         | |
--  | |  \/ ___ _ __   ___ _ __ __ _| |
--  | | __ / _ \ '_ \ / _ \ '__/ _` | |
--  | |_\ \  __/ | | |  __/ | | (_| | |
--   \____/\___|_| |_|\___|_|  \__,_|_|
--
--

local theme_path = os.getenv("HOME") .. "/.config/awesome/theme/"
local theme = {}

theme.theme_path = theme_path
theme.wallpaper = theme_path .. "background.png"
theme.awesome_icon = theme_path .. "awesome.svg"
theme.font = "OpenDyslexic 10"

theme.gap_single_client = false
theme.useless_gap = 2

theme.color_awesome_blue = "#535d6c"

theme.bg_normal = "#222222"
theme.bg_focus = "#777777"
theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#444444"
theme.bg_tooltip = "#d6d6d6"
theme.bg_em = "#5a5a5a"
theme.bg_systray = "#222222"

theme.fg_normal = "#aaaaaa"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"
theme.fg_tooltip = "#1a1a1a"
theme.fg_em = "#d6d6d6"

theme.border_width = 0
theme.border_normal = "#000000"
theme.border_focus = "#535d6c"
theme.border_marked = "#91231c"
theme.border_widget = "#3F3F3F"
theme.fg_widget_value = "#aaaaaa"
theme.fg_widget_clock = "#aaaaaa"
theme.fg_widget_value_important = "#aaaaaa"
theme.fg_widget_value_red = "#ff4136"
theme.fg_widget = "#908884"
theme.fg_center_widget = "#636363"
theme.fg_end_widget = "#1a1a1a"
theme.bg_widget = "#2a2a2a"

--   _     _     _
--  | |   (_)   | |
--  | |    _ ___| |_ ___
--  | |   | / __| __/ __|
--  | |___| \__ \ |_\__ \
--  \_____/_|___/\__|___/
--
--

theme.taglist_squares_sel = theme_path .. "menus/linef.svg"
theme.taglist_squares_unsel = theme_path .. "menus/line.svg"

theme.menu_submenu_icon = theme_path .. "menus/submenu.svg"
theme.menu_height = "20"
theme.menu_width = "100"

--   _____ _ _   _      _
--  |_   _(_) | | |    | |
--    | |  _| |_| | ___| |__   __ _ _ __
--    | | | | __| |/ _ \ '_ \ / _` | '__|
--    | | | | |_| |  __/ |_) | (_| | |
--    \_/ |_|\__|_|\___|_.__/ \__,_|_|
--
--

theme.titlebar_height = 30
theme.titlebar_close_button_normal = theme_path .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus = theme_path .. "titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_path .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = theme_path .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_path .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = theme_path .. "titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_path .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = theme_path .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_path .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = theme_path .. "titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_path .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = theme_path .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_path .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = theme_path .. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_path .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = theme_path .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme_path .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = theme_path .. "titlebar/maximized_focus_active.png"

--   _                             _
--  | |                           | |
--  | |     __ _ _   _  ___  _   _| |_
--  | |    / _` | | | |/ _ \| | | | __|
--  | |___| (_| | |_| | (_) | |_| | |_
--  \_____/\__,_|\__, |\___/ \__,_|\__|
--                __/ |
--               |___/

theme.layout_fairh = theme_path .. "layouts/fairh.svg"
theme.layout_fairv = theme_path .. "layouts/fairv.svg"
theme.layout_tilebottom = theme_path .. "layouts/tilebottom.svg"
theme.layout_tileleft = theme_path .. "layouts/tileleft.svg"
theme.layout_tile = theme_path .. "layouts/tile.svg"
theme.layout_tiletop = theme_path .. "layouts/tiletop.svg"
theme.layout_spiral = theme_path .. "layouts/spiral.svg"
theme.layout_dwindle = theme_path .. "layouts/dwindle.svg"

--   _    _ _     _            _
--  | |  | (_)   | |          | |
--  | |  | |_  __| | __ _  ___| |_ ___
--  | |/\| | |/ _` |/ _` |/ _ \ __/ __|
--  \  /\  / | (_| | (_| |  __/ |_\__ \
--   \/  \/|_|\__,_|\__, |\___|\__|___/
--                   __/ |
--                  |___/

theme.widget_dirbattery = theme_path .. "widgets/battery"
theme.widget_dirapt = theme_path .. "widgets/apt"
theme.widget_dirlogout = theme_path .. "widgets/logout"

return theme
