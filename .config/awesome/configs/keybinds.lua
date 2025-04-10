--   _   __           _     _           _
--  | | / /          | |   (_)         | |
--  | |/ /  ___ _   _| |__  _ _ __   __| |___
--  |    \ / _ \ | | | '_ \| | '_ \ / _` / __|
--  | |\  \  __/ |_| | |_) | | | | | (_| \__ \
--  \_| \_/\___|\__, |_.__/|_|_| |_|\__,_|___/
--               __/ |
--              |___/

local gears = require("gears")
local awful = require("awful")
local menubar = require("menubar")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

local globalkeys = gears.table.join(
	-- Tags
	awful.key({ Modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
	awful.key({ Modkey }, "Left", function()
		for s in screen do
			awful.tag.viewprev(s)
		end
	end, { description = "view previous", group = "tag" }),
	awful.key({ Modkey }, "Right", function()
		for s in screen do
			awful.tag.viewnext(s)
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
	awful.key({ Modkey }, "Return", function() awful.spawn(Terminal) end, { description = "open a terminal", group = "launcher" }),

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
	awful.key({ Modkey }, ";", function() awful.spawn.with_shell("xautolock -locknow") end, { description = "lock", group = "launcher" })
)

for i = 1, 9 do
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
			-- floating = false,
			-- ontop = false,
		},
	},
	{
		rule_any = {
			instance = { "arandr", "blueman-manager", "nm-connection-editor", "pavucontrol", "org.gnome.Characters", "gnome-calculator", "update-manager", "firmware-updater", "forticlient", "thunar" },
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
