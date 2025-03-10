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

--   _   _
--  | | | |
--  | | | | __ _ _ __ ___
--  | | | |/ _` | '__/ __|
--  \ \_/ / (_| | |  \__ \
--   \___/ \__,_|_|  |___/
--
--

gears.filesystem.get_themes_dir()

local modkey = "Mod4"
local terminal = "kitty"
local editor = os.getenv("EDITOR") or "vi"

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
	{ "shutdown", "shutdown now" },
	{ "reboot", "reboot now" },
	{ "quit", function() awesome.quit() end },
	{ "restart", awesome.restart },
}
local mysettingsmenu = {
	{ "awesome", terminal .. " -e " .. "'" .. editor .. " " .. awesome.conffile .. "'" },
	{ "nmtui", terminal .. " -e 'nmtui'" },
	{ "nmgui", "nm-connection-editor" },
	{ "display", "arandr" },
	{ "audio", "pavucontrol" },
}
local mymainmenu = awful.menu({
	items = {
		{ "system", myawesomemenu, beautiful.awesome_icon },
		{ "settings", mysettingsmenu },
		{ "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
		{ "manual", terminal .. " -e 'man awesome'" },
		{ "terminal", terminal },
	},
})
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

awful.screen.connect_for_each_screen(function(s)
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
			volumearc_widget(),
			logout_widget(),
			performance_widget(),
			storage_bar_widget(),
			battery_widget(),
			calendar_widget(s),
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
	-- Tags
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
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

	-- Layouts
	awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function() awful.layout.inc(1) end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end, { description = "select previous", group = "layout" }),

	-- Screens
	awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(1) end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(-1) end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "k", function() awful.client.focus.byidx(1) end, { description = "focus next client by index", group = "screen" }),
	awful.key({ modkey }, "j", function() awful.client.focus.byidx(-1) end, { description = "focus previous client by index", group = "screen" }),
	awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(1) end, { description = "swap with next client by index", group = "screen" }),
	awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(-1) end, { description = "swap with previous client by index", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "screen" }),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then client.focus:raise() end
	end, { description = "focus previous client", group = "screen" }),
	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		if c then c:emit_signal("request::activate", "key.unminimize", { raise = true }) end
	end, { description = "restore minimized", group = "screen" }),

	-- Awesome
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "w", function() mymainmenu:show() end, { description = "show main menu", group = "awesome" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey }, "f4", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ modkey }, "Return", function() awful.spawn(terminal) end, { description = "open a terminal", group = "launcher" }),

	-- Launcher
	awful.key({ modkey }, "p", function()
		menubar.refresh()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" }),
	awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end, { description = "run prompt", group = "launcher" }),
	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Lua: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = function(s) awful.spawn.with_shell("notify-send -u low 'Lua' '" .. tostring(awful.util.eval("return " .. s)) .. "'") end,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "launcher" }),
	awful.key({ modkey }, ";", function() awful.spawn.with_shell("xautolock -locknow") end, { description = "lock", group = "launcher" })
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

root.keys(globalkeys)

local clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		if not c.floating then
			c.maximized = false
			c.fullscreen = false
		end
		c.floating = not c.floating
	end, { description = "toggle floating", group = "client" }),
	awful.key({ modkey }, "o", function(c) c:move_to_screen() end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "n", function(c) c.minimized = true end, { description = "minimize", group = "client" }),
	awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end, { description = "close", group = "client" }),
	awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		if not c.maximized then
			c.floating = false
			c.fullscreen = false
		end
		c.maximized = not c.maximized
	end, { description = "toggle maximize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", function(c)
		if not c.fullscreen then
			c.floating = false
			c.maximized = false
		end
		c.fullscreen = not c.fullscreen
	end, { description = "toggle fullscreen", group = "client" })
)

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
	{
		rule_any = {
			instance = { "arandr", "blueman-manager", "nm-connection-editor", "pavucontrol", "org.gnome.Characters", "gnome-calculator", "update-manager", "firmware-updater" },
			type = { "splash", "dialog", "utility" },
		},
		properties = { floating = true, ontop = true, placement = awful.placement.centered },
	},
	{
		rule_any = { name = { "Microsoft Teams", "Mozilla Thunderbird" } },
		properties = { screen = function() return screen.count() end, tag = "1" },
	},
	{
		rule = { name = "Vivaldi" },
		properties = { screen = 1, tag = "1" },
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

	awful.titlebar(c, { size = beautiful.titlebar_height }):setup({
		{ align = "left", widget = mylauncher },
		{ align = "center", buttons = buttons, widget = awful.titlebar.widget.titlewidget(c) },
		{ align = "right", widget = awful.titlebar.widget.iconwidget(c) },
		layout = wibox.layout.align.horizontal,
	})
end)

client.connect_signal("mouse::enter", function(c) c:emit_signal("request::activate", "mouse_enter", { raise = false }) end)
client.connect_signal("property::floating", function(c) c.ontop = c.floating end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

--   _    _       _ _
--  | |  | |     | | |
--  | |  | | __ _| | |_ __   __ _ _ __   ___ _ __
--  | |/\| |/ _` | | | '_ \ / _` | '_ \ / _ \ '__|
--  \  /\  / (_| | | | |_) | (_| | |_) |  __/ |
--   \/  \/ \__,_|_|_| .__/ \__,_| .__/ \___|_|
--                   | |         | |
--                   |_|         |_|

screen.connect_signal("property::geometry", function(s)
	if beautiful.wallpaper then gears.wallpaper.maximized(beautiful.wallpaper, s, true) end
end)
for s = 1, screen.count() do
	if beautiful.wallpaper then gears.wallpaper.maximized(beautiful.wallpaper, s, true) end
end

math.randomseed(os.time())

if beautiful.wallpaper_path then
	awful.spawn.easy_async('ls -a "' .. beautiful.wallpaper_path .. '"', function(stdout, stderr, reason, exit_code)
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

awful.spawn.with_shell(os.getenv("HOME") .. "/.config/awesome/scripts/startup.sh")

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
