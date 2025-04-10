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
