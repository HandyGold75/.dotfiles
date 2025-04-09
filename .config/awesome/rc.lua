--   _____                           _
--  |_   _|                         | |
--    | | _ __ ___  _ __   ___  _ __| |_ ___
--    | || '_ ` _ \| '_ \ / _ \| '__| __/ __|
--   _| || | | | | | |_) | (_) | |  | |_\__ \
--   \___/_| |_| |_| .__/ \___/|_|   \__|___/
--                 | |
--                 |_|

pcall(require, "luarocks.loader")
local awful = require("awful")
require("awful.autofocus")
local gears = require("gears")
local beautiful = require("beautiful")
local menubar = require("menubar")
package.loaded["naughty.dbus"] = {}

--   _____                      _   _                 _ _ _
--  |  ___|                    | | | |               | | (_)
--  | |__ _ __ _ __ ___  _ __  | |_| | __ _ _ __   __| | |_ _ __   __ _
--  |  __| '__| '__/ _ \| '__| |  _  |/ _` | '_ \ / _` | | | '_ \ / _` |
--  | |__| |  | | | (_) | |    | | | | (_| | | | | (_| | | | | | | (_| |
--  \____/_|  |_|  \___/|_|    \_| |_/\__,_|_| |_|\__,_|_|_|_| |_|\__, |
--                                                                 __/ |
--                                                                |___/

if awesome.startup_errors then awful.spawn.with_shell("notify-send -u critical 'Oops, there were errors during startup!' '" .. awesome.startup_errors .. "'") end
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		if in_error then return end
		in_error = true
		awful.spawn.with_shell("notify-send -u critical 'Oops, an error happend!' '" .. tostring(err) .. "'")
		in_error = false
	end)
end

--   _____ _       _           _
--  |  __ \ |     | |         | |
--  | |  \/ | ___ | |__   __ _| |___
--  | | __| |/ _ \| '_ \ / _` | / __|
--  | |_\ \ | (_) | |_) | (_| | \__ \
--   \____/_|\___/|_.__/ \__,_|_|___/
--
--

beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme/theme.lua")

modkey = "Mod4"
terminal = "kitty"
editor = os.getenv("EDITOR") or "vi"

systemmonitor = terminal .. " " .. "btop"
networkconfig = "nm-connection-editor"
displayconfig = "arandr"
audioconfig = "pavucontrol"

function run(command, callback)
	awful.spawn.easy_async_with_shell(command, function(stdout, _, _, _) callback(stdout) end)
end

mainmenu = awful.menu({
	items = {
		{
			" Power",
			{
				{ " Logout", awesome.quit, beautiful.logout_icon },
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
				{ " Awesome", terminal .. " sh -c " .. "'" .. editor .. " " .. awesome.conffile .. "'", beautiful.awesome_icon },
				{ " Network", networkconfig },
				{ " Display", displayconfig },
				{ " Audio", audioconfig },
			},
			beautiful.awesome_icon,
		},
		{ " hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
		{ " manual", terminal .. " sh -c " .. "'man awesome'" },
		{ " terminal", terminal },
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

--   _____            _
--  |  __ \          | |
--  | |  \/ __ _ _ __| |__   __ _  __ _  ___
--  | | __ / _` | '__| '_ \ / _` |/ _` |/ _ \
--  | |_\ \ (_| | |  | |_) | (_| | (_| |  __/
--   \____/\__,_|_|  |_.__/ \__,_|\__, |\___|
--                                 __/ |
--                                |___/

gears.timer({ timeout = 600, autostart = true, callback = function() collectgarbage() end })
collectgarbage()
