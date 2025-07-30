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
local wibox = require("wibox")
local menubar = require("menubar")
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
Screenshot = "flameshot gui"
Filemanger = "thunar"

Mainmenu = awful.menu({
	items = {
		{
			" Power",
			{
				{ " Lock", "xautolock -locknow", beautiful.lock_icon },
				{ " Suspend", "systemctl suspend", beautiful.suspend_icon },
				{ " Logout", function() awesome.quit() end, beautiful.logout_icon },
				{ " Reboot", "reboot now", beautiful.reboot_icon },
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

require(".widgets")

--   _    _            _
--  | |  | |          | |
--  | |  | | ___  _ __| | _____ _ __   __ _  ___ ___  ___
--  | |/\| |/ _ \| '__| |/ / __| '_ \ / _` |/ __/ _ \/ __|
--  \  /\  / (_) | |  |   <\__ \ |_) | (_| | (_|  __/\__ \
--   \/  \/ \___/|_|  |_|\_\___/ .__/ \__,_|\___\___||___/
--                             | |
--                             |_|

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.top,
}

awful.screen.connect_for_each_screen(function(s)
	awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = gears.table.join(
			awful.button({}, 1, function(t) t:view_only() end),
			awful.button({ Modkey }, 1, function(t)
				if client.focus then client.focus:move_to_tag(t) end
			end),
			awful.button({}, 3, awful.tag.viewtoggle),
			awful.button({ Modkey }, 3, function(t)
				if client.focus then client.focus:toggle_tag(t) end
			end),
			awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
			awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
		),
	})

	local tasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = gears.table.join(
			awful.button({}, 1, function(c)
				if c == client.focus then
					c.minimized = true
				else
					c:emit_signal("request::activate", "tasklist", { raise = true })
				end
			end),
			awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
			awful.button({}, 4, function() awful.client.focus.byidx(1) end),
			awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
		),
	})

	local layoutbox = awful.widget.layoutbox(s)
	layoutbox:buttons(
		gears.table.join(awful.button({}, 1, function() awful.layout.inc(1) end), awful.button({}, 3, function() awful.layout.inc(-1) end), awful.button({}, 4, function() awful.layout.inc(1) end), awful.button({}, 5, function() awful.layout.inc(-1) end))
	)

	s.promptbox = awful.widget.prompt()
	s.wibox = awful.wibar({ position = "top", screen = s, height = beautiful.get_font_height(beautiful.font) })
	s.wibox:setup({
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			awful.widget.launcher({ image = beautiful.awesome_icon, menu = Mainmenu }),
			taglist,
			s.promptbox,
		},
		tasklist,
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = 5,
			wibox.widget.systray(),
			Volumearc_widget(),
			Brightnessarc_widget(),
			Performance_widget(),
			Storagebar_widget(),
			Battery_widget(),
			Calendar_widget(s),
			layoutbox,
		},
	})
end)

--   _   __           _     _           _
--  | | / /          | |   (_)         | |
--  | |/ /  ___ _   _| |__  _ _ __   __| |___
--  |    \ / _ \ | | | '_ \| | '_ \ / _` / __|
--  | |\  \  __/ |_| | |_) | | | | | (_| \__ \
--  \_| \_/\___|\__, |_.__/|_|_| |_|\__,_|___/
--               __/ |
--              |___/

local function focusunderpointer()
	gears.timer({
		timeout = 0.01,
		autostart = true,
		single_shot = true,
		callback = function()
			local n = mouse.object_under_pointer()
			if n ~= nil and n ~= client.focus then client.focus = n end
		end,
	})
end

local globalkeys = gears.table.join(
	-- Tags
	awful.key({ Modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
	awful.key({ Modkey }, "Left", function()
		for s in screen do
			awful.tag.viewprev(s)
			focusunderpointer()
		end
	end, { description = "view previous", group = "tag" }),
	awful.key({ Modkey }, "Right", function()
		for s in screen do
			awful.tag.viewnext(s)
			focusunderpointer()
		end
	end, { description = "view next", group = "tag" }),

	-- Layouts
	awful.key({ Modkey }, "l", function() awful.tag.incmwfact(0.05) end, { description = "increase master width factor", group = "layout" }),
	awful.key({ Modkey }, "h", function() awful.tag.incmwfact(-0.05) end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ Modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ Modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ Modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ Modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ Modkey }, "space", function() awful.layout.inc(1) end, { description = "select next", group = "layout" }),
	awful.key({ Modkey, "Shift" }, "space", function() awful.layout.inc(-1) end, { description = "select previous", group = "layout" }),

	-- Screens
	awful.key({ Modkey, "Control" }, "k", function() awful.screen.focus_relative(1) end, { description = "focus the next screen", group = "screen" }),
	awful.key({ Modkey, "Control" }, "j", function() awful.screen.focus_relative(-1) end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ Modkey }, "k", function() awful.client.focus.byidx(1) end, { description = "focus next client by index", group = "screen" }),
	awful.key({ Modkey }, "j", function() awful.client.focus.byidx(-1) end, { description = "focus previous client by index", group = "screen" }),
	awful.key({ Modkey, "Shift" }, "k", function() awful.client.swap.byidx(1) end, { description = "swap with next client by index", group = "screen" }),
	awful.key({ Modkey, "Shift" }, "j", function() awful.client.swap.byidx(-1) end, { description = "swap with previous client by index", group = "screen" }),
	awful.key({ Modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "screen" }),
	awful.key({ Modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then client.focus:raise() end
	end, { description = "focus previous client", group = "screen" }),
	awful.key({ Modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		if c then c:emit_signal("request::activate", "key.unminimize", { raise = true }) end
	end, { description = "restore minimized", group = "screen" }),

	-- Awesome
	awful.key({ Modkey }, "s", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, { description = "show help", group = "awesome" }),
	awful.key({ Modkey }, "w", function() Mainmenu:show() end, { description = "show main menu", group = "awesome" }),
	awful.key({ Modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ Modkey }, "f4", awesome.quit, { description = "quit awesome", group = "awesome" }),

	-- Launcher
	awful.key({ Modkey }, "p", function()
		menubar.refresh()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" }),
	awful.key({ Modkey }, "r", function() awful.screen.focused().promptbox:run() end, { description = "run prompt", group = "launcher" }),
	awful.key({ Modkey }, "x", function()
		awful.prompt.run({
			prompt = "Lua: ",
			textbox = awful.screen.focused().promptbox.widget,
			exe_callback = function(s) awful.spawn.with_shell("notify-send -u low 'Lua' '" .. tostring(awful.util.eval("return " .. s)) .. "'") end,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "launcher" }),
	awful.key({ Modkey }, ";", function() awful.spawn.with_shell("xautolock -locknow") end, { description = "lock", group = "launcher" }),

	-- Media
	awful.key(
		{},
		"XF86AudioRaiseVolume",
		function() awful.spawn.with_shell("wpctl set-volume @DEFAULT_SINK@ 1%+; notify-send -a volume -h int:value:$(wpctl get-volume @DEFAULT_SINK@ | awk '{ print $2 * 100 }') Volume") end,
		{ description = "volume raise", group = "media" }
	),
	awful.key(
		{},
		"XF86AudioLowerVolume",
		function() awful.spawn.with_shell("wpctl set-volume @DEFAULT_SINK@ 1%-; notify-send -a volume -h int:value:$(wpctl get-volume @DEFAULT_SINK@ | awk '{ print $2 * 100 }') Volume") end,
		{ description = "volume lower", group = "media" }
	),
	awful.key({}, "XF86AudioMute", function() awful.spawn.with_shell("wpctl set-mute @DEFAULT_SINK@ toggle") end, { description = "mute sink", group = "media" }),
	awful.key({}, "XF86AudioMicMute", function() awful.spawn.with_shell("wpctl set-mute @DEFAULT_SOURCE@ toggle") end, { description = "mute source", group = "media" }),

	awful.key({}, "XF86AudioPlay", function() awful.spawn.with_shell("playerctl play-pause") end, { description = "player toggle", group = "media" }),
	awful.key({}, "XF86AudioNext", function() awful.spawn.with_shell("playerctl next") end, { description = "player next", group = "media" }),
	awful.key({}, "XF86AudioPrev", function() awful.spawn.with_shell("playerctl previous") end, { description = "player previous", group = "media" }),

	awful.key({}, "XF86MonBrightnessUp", function() awful.spawn.with_shell("notify-send -a brightness -h int:value:$(brightnessctl -n 1 -m set +1% | awk -F ',' '{ print $4 }') Brightness") end, { description = "brightness down", group = "media" }),
	awful.key({}, "XF86MonBrightnessDown", function() awful.spawn.with_shell("notify-send -a brightness -h int:value:$(brightnessctl -n 1 -m set 1%- | awk -F ',' '{ print $4 }') Brightness") end, { description = "brightness up", group = "media" }),

	-- xrandr
	awful.key({ Modkey }, "KP_0", function() awful.spawn.with_shell("~/.config/awesome/xrandr/lp.sh") end, { description = "xrander config lp", group = "xrandr" }),
	awful.key({ Modkey }, "KP_9", function() awful.spawn.with_shell("~/.config/awesome/xrandr/h.sh") end, { description = "xrander config h", group = "xrandr" }),
	awful.key({ Modkey }, "KP_1", function() awful.spawn.with_shell("~/.config/awesome/xrandr/w1.sh") end, { description = "xrander config w1", group = "xrandr" }),
	awful.key({ Modkey }, "KP_2", function() awful.spawn.with_shell("~/.config/awesome/xrandr/w2.sh") end, { description = "xrander config w2", group = "xrandr" }),
	awful.key({ Modkey }, "KP_3", function() awful.spawn.with_shell("~/.config/awesome/xrandr/w3.sh") end, { description = "xrander config w3", group = "xrandr" }),
	awful.key({ Modkey }, "KP_4", function() awful.spawn.with_shell("~/.config/awesome/xrandr/w4.sh") end, { description = "xrander config w4", group = "xrandr" }),
	awful.key({ Modkey, "Shift" }, "KP_1", function() awful.spawn.with_shell("~/.config/awesome/xrandr/p1.sh") end, { description = "xrander config p1", group = "xrandr" }),
	awful.key({ Modkey, "Shift" }, "KP_2", function() awful.spawn.with_shell("~/.config/awesome/xrandr/p2.sh") end, { description = "xrander config p2", group = "xrandr" }),
	awful.key({ Modkey, "Shift" }, "KP_3", function() awful.spawn.with_shell("~/.config/awesome/xrandr/p3.sh") end, { description = "xrander config p3", group = "xrandr" }),
	awful.key({ Modkey, "Shift" }, "KP_4", function() awful.spawn.with_shell("~/.config/awesome/xrandr/p4.sh") end, { description = "xrander config p4", group = "xrandr" }),

	-- Applications
	awful.key({ Modkey }, "Return", function() awful.spawn(Terminal) end, { description = "open " .. Terminal, group = "applications" }),
	awful.key({ Modkey }, "F11", function() awful.spawn.with_shell("headsetcontrol -l0") end, { description = "headsetcontrol lights off", group = "applications" }),
	awful.key({ Modkey }, "d", function() awful.spawn(Filemanger) end, { description = "open " .. Filemanger, group = "applications" }),
	awful.key({}, "Print", function() awful.spawn(Screenshot) end, { description = "screenshot with " .. Screenshot, group = "applications" })
)

for i = 1, 5 do
	globalkeys = gears.table.join(
		globalkeys,
		awful.key({ Modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then tag:view_only() end
		end, { description = "view tag #" .. i, group = "tag" }),
		awful.key({ Modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then awful.tag.viewtoggle(tag) end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		awful.key({ Modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then client.focus:move_to_tag(tag) end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		awful.key({ Modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then client.focus:toggle_tag(tag) end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

local clientkeys = gears.table.join(
	awful.key({ Modkey }, "f", function(c)
		if not c.floating then
			c.maximized = false
			c.fullscreen = false
		end
		c.floating = not c.floating
	end, { description = "toggle floating", group = "client" }),
	awful.key({ Modkey }, "o", function(c) c:move_to_screen() end, { description = "move to screen", group = "client" }),
	awful.key({ Modkey }, "n", function(c) c.minimized = true end, { description = "minimize", group = "client" }),
	awful.key({ Modkey, "Shift" }, "c", function(c) c:kill() end, { description = "close", group = "client" }),
	awful.key({ Modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end, { description = "move to master", group = "client" }),
	awful.key({ Modkey }, "m", function(c)
		if not c.maximized then
			c.floating = false
			c.fullscreen = false
		end
		c.maximized = not c.maximized
	end, { description = "toggle maximize", group = "client" }),
	awful.key({ Modkey, "Control" }, "m", function(c)
		if not c.fullscreen then
			c.floating = false
			c.maximized = false
		end
		c.fullscreen = not c.fullscreen
	end, { description = "toggle fullscreen", group = "client" })
)

local clientbuttons = gears.table.join(
	awful.button({}, 1, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }) end),
	awful.button({ Modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ Modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

menubar.utils.terminal = Terminal
root.buttons(gears.table.join(awful.button({}, 3, function() Mainmenu:toggle() end), awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))
root.keys(globalkeys)

--  ______      _
--  | ___ \    | |
--  | |_/ /   _| | ___  ___
--  |    / | | | |/ _ \/ __|
--  | |\ \ |_| | |  __/\__ \
--  \_| \_\__,_|_|\___||___/
--
--

awful.rules.rules = {
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			fullscreen = false,
			maximized = false,
			floating = false,
			ontop = false,
		},
	},
	-- $ xprop WM_CLASS | awk -F '"' '{print $2}' # instance
	-- $ xprop WM_CLASS | awk -F '"' '{print $4}' # class
	{
		rule_any = {
			instance = { "arandr", "blueman-manager", "nm-connection-editor", "pavucontrol", "org.gnome.Characters", "gnome-calculator", "update-manager", "firmware-updater", "forticlient", "thunar" },
			type = { "splash", "dialog", "utility" },
		},
		properties = { floating = true, ontop = true, placement = awful.placement.centered },
	},
	{
		rule_any = { instance = { "teams-for-linux" }, class = { "thunderbird-esr" } },
		properties = { screen = function() return screen.count() end, tag = "1" },
	},
	{
		rule = { instance = "vivaldi-stable" },
		properties = {
			screen = 1,
			tag = function()
				if screen.count() == 1 then return "2" end
				return "1"
			end,
		},
	},
	{
		rule = { class = "firefox" },
		properties = { screen = function() return screen.count() end, tag = "2" },
	},
}

--   _____ _                   _
--  /  ___(_)                 | |
--  \ `--. _  __ _ _ __   __ _| |___
--   `--. \ |/ _` | '_ \ / _` | / __|
--  /\__/ / | (_| | | | | (_| | \__ \
--  \____/|_|\__, |_| |_|\__,_|_|___/
--            __/ |
--           |___/

client.connect_signal("manage", function(c)
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then awful.placement.no_offscreen(c) end
end)
client.connect_signal("mouse::enter", function(c) c:emit_signal("request::activate", { raise = false }) end)

client.connect_signal("property::floating", function(c) c.ontop = c.floating end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

screen.connect_signal("property::geometry", function(s)
	if beautiful.wallpaper then gears.wallpaper.maximized(beautiful.wallpaper, s, true) end
end)
for s = 1, screen.count() do
	if beautiful.wallpaper then gears.wallpaper.maximized(beautiful.wallpaper, s, true) end
end

math.randomseed(os.time())

if beautiful.wallpaper_path then
	awful.spawn.easy_async('ls -a "' .. beautiful.wallpaper_path .. '"', function(stdout, _, _, _)
		local i, wp_files = 0, {}
		for filename in stdout:gmatch("[^\r\n$]+") do
			if string.match(filename, "%.png$") or string.match(filename, "%.jpg$") then
				i = i + 1
				wp_files[i] = beautiful.wallpaper_path .. filename
			end
		end

		for s = 1, screen.count() do
			gears.wallpaper.maximized(wp_files[math.random(1, #wp_files)], s, true)
		end

		gears.timer({
			timeout = 30,
			autostart = true,
			callback = function()
				for s = 1, screen.count() do
					gears.wallpaper.maximized(wp_files[math.random(1, #wp_files)], s, true)
				end
			end,
		})
	end)
end

--    ___        _            _             _
--   / _ \      | |          | |           | |
--  / /_\ \_   _| |_ ___  ___| |_ __ _ _ __| |_
--  |  _  | | | | __/ _ \/ __| __/ _` | '__| __|
--  | | | | |_| | || (_) \__ \ || (_| | |  | |_
--  \_| |_/\__,_|\__\___/|___/\__\__,_|_|   \__|
--
--

local function run_if_not_running(cmd, pgrep)
	if pgrep == nil then pgrep = cmd end
	awful.spawn.easy_async("pgrep -f " .. pgrep, function(stdout, _, _, _)
		if stdout == "" then awful.spawn(cmd) end
	end)
end

run_if_not_running("nm-applet")
run_if_not_running("qlipper")
run_if_not_running("flameshot")
run_if_not_running("teams-for-linux")
run_if_not_running("thunderbird")
run_if_not_running("vivaldi")

run_if_not_running("hg macros", "macros")
run_if_not_running('xautolock -time 5 -notify 60 -detectsleep -locker "i3lock -c 000000 -i ~/.config/awesome/theme/wallpaper.png -fet" -notifier "notify-send -a XAutoLock -t 60000 xautolock \'Locking in 60 seconds\'"', "xautolock")

awful.spawn("headsetcontrol -l 0")
awful.spawn("setxkbmap -option caps:swapescape")
awful.spawn("pactl load-module module-remap-sink sink_name=mono sink_properties='device.description=\"FallbackMono\"' channels=1 channel_map=mono")
awful.spawn("brightnessctl -n 1 -m set 100%")

-- awful.spawn('xinput set-prop "Logitech MX Master 3S" "libinput Accel Profile Enabled" 0 1')
-- awful.spawn('sleep 5 && xinput set-prop "Logitech MX Master 3S" "libinput Accel Profile Enabled" 0 1')
-- awful.spawn('xinput set-prop "Logitech MX Master 3S" "libinput Accel Speed" -0.30')
-- awful.spawn('sleep 5 && xinput set-prop "Logitech MX Master 3S" "libinput Accel Speed" -0.30')

-- awful.spawn('xinput set-prop "MX Master 3S" "libinput Accel Profile Enabled" 0 1')
-- awful.spawn('sleep 5 && xinput set-prop "MX Master 3S" "libinput Accel Profile Enabled" 0 1')
-- awful.spawn('xinput set-prop "MX Master 3S" "libinput Accel Speed" -0.30')
-- awful.spawn('sleep 5 && xinput set-prop "MX Master 3S" "libinput Accel Speed" -0.30')

--   _____ _                  _   _
--  /  __ \ |                | | | |
--  | /  \/ | ___  __ _ _ __ | | | |_ __
--  | |   | |/ _ \/ _` | '_ \| | | | '_ \
--  | \__/\ |  __/ (_| | | | | |_| | |_) |
--   \____/_|\___|\__,_|_| |_|\___/| .__/
--                                 | |
--                                 |_|

focusunderpointer()
gears.timer({ timeout = 600, autostart = true, callback = collectgarbage })
collectgarbage()
