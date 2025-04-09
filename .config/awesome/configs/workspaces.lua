--   _    _            _
--  | |  | |          | |
--  | |  | | ___  _ __| | _____ _ __   __ _  ___ ___  ___
--  | |/\| |/ _ \| '__| |/ / __| '_ \ / _` |/ __/ _ \/ __|
--  \  /\  / (_) | |  |   <\__ \ |_) | (_| | (_|  __/\__ \
--   \/  \/ \___/|_|  |_|\_\___/ .__/ \__,_|\___\___||___/
--                             | |
--                             |_|

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.top,
}

awful.screen.connect_for_each_screen(function(s)
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = gears.table.join(
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
			awful.widget.launcher({ image = beautiful.awesome_icon, menu = mainmenu }),
			taglist,
			s.promptbox,
		},
		tasklist,
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = 5,
			wibox.widget.systray(),
			volumearc_widget(),
			performance_widget(),
			storage_bar_widget(),
			battery_widget(),
			calendar_widget(s),
			layoutbox,
		},
	})
end)

gears.table.merge(awful.rules.rules, {
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
})
