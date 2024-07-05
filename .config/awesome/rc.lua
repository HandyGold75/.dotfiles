--   _____                           _
--  |_   _|                         | |
--    | | _ __ ___  _ __   ___  _ __| |_ ___
--    | || '_ ` _ \| '_ \ / _ \| '__| __/ __|
--   _| || | | | | | |_) | (_) | |  | |_\__ \
--   \___/_| |_| |_| .__/ \___/|_|   \__|___/
--                 | |
--                 |_|

pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme/theme.lua")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
require("wi")
package.loaded["naughty.dbus"] = {}

--   _____                      _   _                 _ _ _
--  |  ___|                    | | | |               | | (_)
--  | |__ _ __ _ __ ___  _ __  | |_| | __ _ _ __   __| | |_ _ __   __ _
--  |  __| '__| '__/ _ \| '__| |  _  |/ _` | '_ \ / _` | | | '_ \ / _` |
--  | |__| |  | | | (_) | |    | | | | (_| | | | | (_| | | | | | | (_| |
--  \____/_|  |_|  \___/|_|    \_| |_/\__,_|_| |_|\__,_|_|_|_| |_|\__, |
--                                                                 __/ |
--                                                                |___/

if awesome.startup_errors then awful.spawn.with_shell("dunstify -u critical 'Oops, there were errors during startup!' '" .. awesome.startup_errors .. "'") end

do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		if in_error then return end
		in_error = true

		awful.spawn.with_shell("dunstify -u critical 'Oops, an error happend!' '" .. tostring(err) .. "'")
		in_error = false
	end)
end

--   _   _
--  | | | |
--  | | | | __ _ _ __ ___
--  | | | |/ _` | '__/ __|
--  \ \_/ / (_| | |  \__ \
--   \___/ \__,_|_|  |___/
--
--

gears.filesystem.get_themes_dir()

local terminal = "terminator"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor

local modkey = "Mod4"

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.fair,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.spiral,
}

--  ___  ___
--  |  \/  |
--  | .  . | ___ _ __  _   _
--  | |\/| |/ _ \ '_ \| | | |
--  | |  | |  __/ | | | |_| |
--  \_|  |_/\___|_| |_|\__,_|
--
--

local myawesomemenu = {
	{ "lock", "xautolock -locknow" },
	{ "restart", awesome.restart },
	{ "shutdown", "shutdown now" },
	{ "quit", function() awesome.quit() end },
	{ "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{ "manual", terminal .. ' -e "man awesome"' },
}
local mysettingsmenu = {
	{ "awesome", editor_cmd .. " " .. awesome.conffile },
	{ "solaar", "solaar" },
	{ "display", "arandr" },
	{ "audio", "pavucontrol" },
	{ "pentablet", terminal .. " -e " .. "'sudo /usr/lib/pentablet/PenTablet.sh'" },
}
local mymainmenu = awful.menu({ items = {
	{ "system", myawesomemenu, beautiful.awesome_icon },
	{ "settings", mysettingsmenu },
	{ "open terminal", terminal },
} })
local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

menubar.utils.terminal = terminal

--   _    _            _
--  | |  | |          | |
--  | |  | | ___  _ __| | _____ _ __   __ _  ___ ___  ___
--  | |/\| |/ _ \| '__| |/ / __| '_ \ / _` |/ __/ _ \/ __|
--  \  /\  / (_) | |  |   <\__ \ |_) | (_| | (_|  __/\__ \
--   \/  \/ \___/|_|  |_|\_\___/ .__/ \__,_|\___\___||___/
--                             | |
--                             |_|

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then client.focus:move_to_tag(t) end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then client.focus:toggle_tag(t) end
	end),
	awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
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
)

local function set_wallpaper(s)
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	set_wallpaper(s)

	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

	s.mypromptbox = awful.widget.prompt()
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(
		gears.table.join(awful.button({}, 1, function() awful.layout.inc(1) end), awful.button({}, 3, function() awful.layout.inc(-1) end), awful.button({}, 4, function() awful.layout.inc(1) end), awful.button({}, 5, function() awful.layout.inc(-1) end))
	)

	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})

	s.mywibox = awful.wibar({ position = "top", screen = s, height = 25 })
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist,
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = 5,
			wibox.widget.systray(),
			volumearc_widget,
			logout_widget,
			performance_widget,
			storage_bar_widget,
			battery_widget,
			calendar_widget,
			s.mylayoutbox,
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

root.buttons(gears.table.join(awful.button({}, 3, function() mymainmenu:toggle() end), awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))

local globalkeys = gears.table.join(
	awful.key({ modkey }, ";", function() awful.spawn.with_shell("xautolock -locknow") end, { description = "lock", group = "system" }),
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "Left", function()
		for s in screen do
			awful.tag.viewprev(s)
		end
	end, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", function()
		for s in screen do
			awful.tag.viewnext(s)
		end
	end, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
	awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end, { description = "focus previous by index", group = "client" }),
	awful.key({ modkey }, "w", function() mymainmenu:show() end, { description = "show main menu", group = "awesome" }),

	awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then client.focus:raise() end
	end, { description = "go back", group = "client" }),

	awful.key({ modkey }, "Return", function() awful.spawn(terminal) end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function() awful.layout.inc(1) end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end, { description = "select previous", group = "layout" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		if c then c:emit_signal("request::activate", "key.unminimize", { raise = true }) end
	end, { description = "restore minimized", group = "client" }),

	awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end, { description = "run prompt", group = "launcher" }),
	awful.key(
		{ modkey },
		"x",
		function()
			awful.prompt.run({
				prompt = "Lua: ",
				textbox = awful.screen.focused().mypromptbox.widget,
				exe_callback = awful.util.eval,
				history_path = awful.util.get_cache_dir() .. "/history_eval",
			})
		end,
		{ description = "lua execute prompt", group = "awesome" }
	),
	awful.key({ modkey }, "p", function() menubar.show() end, { description = "show the menubar", group = "launcher" }),
	awful.key({ modkey }, "v", function() awful.util.spawn("cliphist list | wofi --dmenu | cliphist decode | wl-copy") end, { description = "launch cliphist with wofi", group = "launcher" })
)

local clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end, { description = "close", group = "client" }),
	awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle, { description = "toggle floating", group = "client" }),
	awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end, { description = "move to master", group = "client" }),

	awful.key({ modkey }, "o", function(c) c:move_to_screen() end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c) c.minimized = true end, { description = "minimize", group = "client" }),

	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then tag:view_only() end
		end, { description = "view tag #" .. i, group = "tag" }),
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then awful.tag.viewtoggle(tag) end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then client.focus:move_to_tag(tag) end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then client.focus:toggle_tag(tag) end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

local clientbuttons = gears.table.join(
	awful.button({}, 1, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }) end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

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
		},
	},
	{
		rule_any = {
			instance = { "DTA", "copyq", "pinentry" },
			class = { "Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", "Sxiv", "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer" },
			name = { "Event Tester" },
			role = { "AlarmWindow", "ConfigManager", "pop-up" },
		},
		properties = { floating = true },
	},
	{ rule_any = { type = { "dialog" } }, properties = { titlebars_enabled = true } },
	{
		rule = { name = "Vivaldi" },
		properties = { screen = function() return math.max(1, screen.count() - 1) end, tag = "1" },
	},
	{
		rule_any = { name = { "Microsoft Teams", "Mozilla Thunderbird" } },
		properties = { screen = function() return screen.count() end, tag = "1" },
	},
	{
		rule = { name = "Firefox" },
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

client.connect_signal("request::titlebars", function(c)
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{
			{
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

client.connect_signal("mouse::enter", function(c) c:emit_signal("request::activate", "mouse_enter", { raise = false }) end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
	c.opacity = 1
end)

client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
	c.opacity = 0.5
end)

--   _    _       _ _
--  | |  | |     | | |
--  | |  | | __ _| | |_ __   __ _ _ __   ___ _ __
--  | |/\| |/ _` | | | '_ \ / _` | '_ \ / _ \ '__|
--  \  /\  / (_| | | | |_) | (_| | |_) |  __/ |
--   \/  \/ \__,_|_|_| .__/ \__,_| .__/ \___|_|
--                   | |         | |
--                   |_|         |_|

local function scandir(directory, filter)
	local i, t, popen = 0, {}, io.popen
	if not filter then filter = function(s) return true end end
	for filename in popen('ls -a "' .. directory .. '"'):lines() do
		if filter(filename) then
			i = i + 1
			t[i] = filename
		end
	end
	return t
end

local wp_timeout = 30
local wp_path = os.getenv("HOME") .. "/.config/awesome/theme/wallpapers/"
local wp_files = scandir(wp_path, function(s) return string.match(s, "%.png$") or string.match(s, "%.jpg$") end)

math.randomseed(os.time())

local wp_timer = gears.timer({ timeout = wp_timeout })
wp_timer:connect_signal("timeout", function()
	local wp_index = math.random(1, #wp_files)
	for s = 1, screen.count() do
		gears.wallpaper.maximized(wp_path .. wp_files[wp_index], s, true)
	end

	wp_timer:stop()
	wp_timer.timeout = wp_timeout
	wp_timer:start()
end)

local wp_index = math.random(1, #wp_files)
for s = 1, screen.count() do
	gears.wallpaper.maximized(wp_path .. wp_files[wp_index], s, true)
end

wp_timer:start()

--   _____            _
--  |  __ \          | |
--  | |  \/ __ _ _ __| |__   __ _  __ _  ___
--  | | __ / _` | '__| '_ \ / _` |/ _` |/ _ \
--  | |_\ \ (_| | |  | |_) | (_| | (_| |  __/
--   \____/\__,_|_|  |_.__/ \__,_|\__, |\___|
--                                 __/ |
--                                |___/

gears.timer({
	timeout = 30,
	autostart = true,
	callback = function() collectgarbage() end,
})

--    ___        _            _             _
--   / _ \      | |          | |           | |
--  / /_\ \_   _| |_ ___  ___| |_ __ _ _ __| |_
--  |  _  | | | | __/ _ \/ __| __/ _` | '__| __|
--  | | | | |_| | || (_) \__ \ || (_| | |  | |_
--  \_| |_/\__,_|\__\___/|___/\__\__,_|_|   \__|
--
--

awful.spawn.with_shell(os.getenv("HOME") .. "/.config/awesome/scripts/startup.sh")
