--   _____                           _
--  |  __ \                         | |
--  | |  \/ ___ _ __   ___ _ __ __ _| |
--  | | __ / _ \ '_ \ / _ \ '__/ _` | |
--  | |_\ \  __/ | | |  __/ | | (_| | |
--   \____/\___|_| |_|\___|_|  \__,_|_|
--
--

local beautiful = require("beautiful")

local theme_path = os.getenv("HOME") .. "/.config/awesome/theme/"
local theme = {}

theme.theme_path = theme_path
theme.wallpaper = theme_path .. "background.png"
theme.wallpaper_path = theme_path .. "wallpapers/"
theme.awesome_icon = theme_path .. "awesome.svg"
theme.font = "OpenDyslexicNerdFont 10"

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

--   _     _     _
--  | |   (_)   | |
--  | |    _ ___| |_ ___
--  | |   | / __| __/ __|
--  | |___| \__ \ |_\__ \
--  \_____/_|___/\__|___/
--
--

theme.logout_icon = theme_path .. "menus/power/logout.svg"
theme.lock_icon = theme_path .. "menus/power/lock.svg"
theme.reboot_icon = theme_path .. "menus/power/reboot.svg"
theme.suspend_icon = theme_path .. "menus/power/suspend.svg"
theme.shutdown_icon = theme_path .. "menus/power/shutdown.svg"
theme.power_icon = theme_path .. "menus/power/power.svg"

theme.taglist_squares_sel = theme_path .. "menus/linef.svg"
theme.taglist_squares_unsel = theme_path .. "menus/line.svg"

theme.menu_height = beautiful.get_font_height(theme.font)
theme.menu_width = 125
theme.menu_border_color = "#000000"
theme.menu_border_width = 2
theme.menu_submenu = "▶"

--   _                             _
--  | |                           | |
--  | |     __ _ _   _  ___  _   _| |_
--  | |    / _` | | | |/ _ \| | | | __|
--  | |___| (_| | |_| | (_) | |_| | |_
--  \_____/\__,_|\__, |\___/ \__,_|\__|
--                __/ |
--               |___/

theme.layout_tilebottom = theme_path .. "menus/layouts/tile_bottom.svg"
theme.layout_tileleft = theme_path .. "menus/layouts/tile_left.svg"
theme.layout_tile = theme_path .. "menus/layouts/tile.svg"
theme.layout_tiletop = theme_path .. "menus/layouts/tile_top.svg"

--   _    _ _     _            _
--  | |  | (_)   | |          | |
--  | |  | |_  __| | __ _  ___| |_ ___
--  | |/\| | |/ _` |/ _` |/ _ \ __/ __|
--  \  /\  / | (_| | (_| |  __/ |_\__ \
--   \/  \/|_|\__,_|\__, |\___|\__|___/
--                   __/ |
--                  |___/

theme.border_widget = "#3F3F3F"
theme.fg_widget_value = "#aaaaaa"
theme.fg_widget_clock = "#aaaaaa"
theme.fg_widget_value_important = "#aaaaaa"
theme.fg_widget_value_red = "#ff4136"
theme.fg_widget = "#908884"
theme.fg_center_widget = "#636363"
theme.fg_end_widget = "#1a1a1a"
theme.bg_widget = "#2a2a2a"
theme.bg_widget_value = "#2a2a2a"
theme.bg_widget_value_red = "#8f2116"

theme.widget_dirbattery = theme_path .. "widgets/battery"

return theme
