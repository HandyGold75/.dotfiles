--   _____ _
--  |_   _| |
--    | | | |__   ___ _ __ ___   ___
--    | | | '_ \ / _ \ '_ ` _ \ / _ \
--    | | | | | |  __/ | | | | |  __/
--    \_/ |_| |_|\___|_| |_| |_|\___|
--
--

local beautiful = require("beautiful")
local xres = beautiful.xresources.get_current_theme()
local theme = {}

theme.font = "OpenDyslexicNerdFont 10"

theme.maximized_honor_padding = true
theme.maximized_hide_border = true
theme.fullscreen_hide_border = true

theme.gap_single_client = false
theme.useless_gap = 2

theme.snap_border_width = 0
theme.systray_icon_spacing = 2

theme.menu_height = beautiful.get_font_height(theme.font)
theme.menu_width = 110
theme.menu_border_width = 2

--   _____       _
--  /  __ \     | |
--  | /  \/ ___ | | ___  _ __ ___
--  | |    / _ \| |/ _ \| '__/ __|
--  | \__/\ (_) | | (_) | |  \__ \
--   \____/\___/|_|\___/|_|  |___/
--
--

theme.bg_normal = xres.background
theme.bg_focus = xres.foreground
theme.bg_urgent = xres.color1
theme.bg_minimize = "#181926"
theme.bg_systray = theme.bg_normal

theme.fg_normal = xres.foreground
theme.fg_focus = xres.background
theme.fg_urgent = xres.foreground
theme.fg_minimize = xres.color0

theme.border_width = 0
theme.border_normal = xres.color0
theme.border_focus = xres.color1
theme.border_marked = xres.color4

theme.color_red = "#ff4136"
theme.color_darkred = "#8f2116"

--  ______     _   _
--  | ___ \   | | | |
--  | |_/ /_ _| |_| |__  ___
--  |  __/ _` | __| '_ \/ __|
--  | | | (_| | |_| | | \__ \
--  \_|  \__,_|\__|_| |_|___/
--
--

theme.theme_path = os.getenv("HOME") .. "/.config/awesome/theme/"

theme.wallpaper = theme.theme_path .. "background.png"
theme.awesome_icon = theme.theme_path .. "awesome.svg"

theme.layout_tilebottom = theme.theme_path .. "menus/layouts/tile_bottom.svg"
theme.layout_tileleft = theme.theme_path .. "menus/layouts/tile_left.svg"
theme.layout_tile = theme.theme_path .. "menus/layouts/tile.svg"
theme.layout_tiletop = theme.theme_path .. "menus/layouts/tile_top.svg"

theme.taglist_squares_sel = theme.theme_path .. "menus/linef.svg"
theme.taglist_squares_unsel = theme.theme_path .. "menus/line.svg"

theme.wallpaper_path = theme.theme_path .. "wallpapers/"
theme.widget_dirbattery = theme.theme_path .. "widgets/battery"
theme.widget_volume = theme.theme_path .. "widgets/volume.svg"
theme.widget_brightness = theme.theme_path .. "widgets/brightness.svg"

theme.logout_icon = theme.theme_path .. "menus/power/logout.svg"
theme.lock_icon = theme.theme_path .. "menus/power/lock.svg"
theme.reboot_icon = theme.theme_path .. "menus/power/reboot.svg"
theme.suspend_icon = theme.theme_path .. "menus/power/suspend.svg"
theme.shutdown_icon = theme.theme_path .. "menus/power/shutdown.svg"
theme.power_icon = theme.theme_path .. "menus/power/power.svg"

return theme
