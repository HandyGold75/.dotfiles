--    ___
--   / _ \
--  / /_\ \_      _____  ___  ___  _ __ ___   ___
--  |  _  \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \
--  | | | |\ V  V /  __/\__ \ (_) | | | | | |  __/
--  \_| |_/ \_/\_/ \___||___/\___/|_| |_| |_|\___|
--
--

pcall(require, "luarocks.loader")
local awful = require("awful")
require("awful.autofocus")
local gears = require("gears")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
package.loaded["naughty.dbus"] = {}

if awesome.startup_errors then awful.spawn.with_shell("notify-send -u critical 'Oops, there were errors during startup!' '" .. awesome.startup_errors .. "'") end
awesome.connect_signal("debug::error", function(err) awful.spawn.with_shell("notify-send -u critical 'Oops, an error happend!' '" .. tostring(err) .. "'") end)

--   _____ _       _           _
--  |  __ \ |     | |         | |
--  | |  \/ | ___ | |__   __ _| |___
--  | | __| |/ _ \| '_ \ / _` | / __|
--  | |_\ \ | (_) | |_) | (_| | \__ \
--   \____/_|\___/|_.__/ \__,_|_|___/
--
--

beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme/theme.lua")

Modkey = "Mod4"
Terminal = "kitty"
Editor = os.getenv("EDITOR") or "vi"

Systemmonitor = Terminal .. " " .. "btop"
Networkconfig = "nm-connection-editor"
Displayconfig = "arandr"
Audioconfig = "pavucontrol"

Mainmenu = awful.menu({
	items = {
		{
			" Power",
			{
				{ " Logout", function() awesome.quit() end, beautiful.logout_icon },
				{ " Lock", "xautolock -locknow", beautiful.lock_icon },
				{ " Reboot", "reboot now", beautiful.reboot_icon },
				{ " Suspend", "systemctl suspend", beautiful.suspend_icon },
				{ " Shutdown", "shutdown now", beautiful.shutdown_icon },
			},
			beautiful.power_icon,
		},
		{
			" Config",
			{
				{ " Awesome", Terminal .. " sh -c " .. "'" .. Editor .. " " .. awesome.conffile .. "'", beautiful.awesome_icon },
				{ " Network", Networkconfig },
				{ " Display", Displayconfig },
				{ " Audio", Audioconfig },
			},
			beautiful.awesome_icon,
		},
		{ " hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
		{ " manual", Terminal .. " sh -c " .. "'man awesome'" },
		{ " terminal", Terminal },
	},
})

--   _____              __ _
--  /  __ \            / _(_)
--  | /  \/ ___  _ __ | |_ _  __ _ ___
--  | |    / _ \| '_ \|  _| |/ _` / __|
--  | \__/\ (_) | | | | | | | (_| \__ \
--   \____/\___/|_| |_|_| |_|\__, |___/
--                            __/ |
--                           |___/

require(".widgets")
require(".configs.workspaces")
require(".configs.keybinds")
require(".configs.signals")
awful.spawn.with_shell(os.getenv("HOME") .. "/.config/awesome/configs/autostart.sh")

gears.timer({ timeout = 600, autostart = true, callback = collectgarbage })
collectgarbage()
