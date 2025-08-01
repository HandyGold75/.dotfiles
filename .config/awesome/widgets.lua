--   _____                           _
--  |_   _|                         | |
--    | | _ __ ___  _ __   ___  _ __| |_ ___
--    | || '_ ` _ \| '_ \ / _ \| '__| __/ __|
--   _| || | | | | | |_) | (_) | |  | |_\__ \
--   \___/_| |_| |_| .__/ \___/|_|   \__|___/
--                 | |
--                 |_|

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
require("math")

local function run(command, callback)
	awful.spawn.easy_async_with_shell(command, function(stdout, _, _, _) callback(stdout) end)
end

--   _   _       _
--  | | | |     | |
--  | | | | ___ | |_   _ _ __ ___   ___
--  | | | |/ _ \| | | | | '_ ` _ \ / _ \
--  \ \_/ / (_) | | |_| | | | | | |  __/
--   \___/ \___/|_|\__,_|_| |_| |_|\___|
--
-- Volumearc_widget()

function Volumearc_widget()
	local volumearc = wibox.widget({
		{
			image = beautiful.widget_volume,
			resize = true,
			widget = wibox.widget.imagebox,
		},
		max_value = 1,
		thickness = 2,
		start_angle = 4.71238898, -- 2pi*3/4
		forced_height = beautiful.get_font_height(beautiful.font) - 6,
		forced_width = beautiful.get_font_height(beautiful.font) - 6,
		colors = { beautiful.fg_normal },
		bg = beautiful.fg_minimize,
		paddings = 2,
		widget = wibox.container.arcchart,
	})

	local update_graphic_sink = function(widget, stdout, _, _, _, notify)
		widget.value = tonumber(string.match(stdout, "Volume: (%d.%d%d)"))
		if string.match(stdout, "%[(%D?%D?%D%D?%D?)%]") == "MUTED" then
			widget.colors = { beautiful.color_red }
		else
			widget.colors = { beautiful.fg_normal }
		end
		if notify then awful.spawn.with_shell("notify-send -a volume -h int:value:" .. tostring(string.match(stdout, "Volume: (%d.%d%d)") * 100) .. " Volume") end
	end

	local update_graphic_source = function(widget, stdout, _, _, _)
		if string.match(stdout, "%[(%D?%D?%D%D?%D?)%]") == "MUTED" then
			widget.bg = beautiful.color_darkred
		else
			widget.bg = beautiful.fg_minimize
		end
	end

	volumearc:connect_signal("button::press", function(_, _, _, button)
		if button == 5 then
			awful.spawn("wpctl set-volume @DEFAULT_SINK@ 1%-", false)
			awful.spawn.easy_async("wpctl get-volume @DEFAULT_SINK@", function(stdout, _, _, _) update_graphic_sink(volumearc, stdout, _, _, _, true) end)
		elseif button == 4 then
			awful.spawn("wpctl set-volume @DEFAULT_SINK@ 1%+", false)
			awful.spawn.easy_async("wpctl get-volume @DEFAULT_SINK@", function(stdout, _, _, _) update_graphic_sink(volumearc, stdout, _, _, _, true) end)
		elseif button == 3 then
			awful.spawn("wpctl set-mute @DEFAULT_SOURCE@ toggle", false)
			awful.spawn.easy_async("wpctl get-volume @DEFAULT_SOURCE@", function(stdout, _, _, _) update_graphic_source(volumearc, stdout, _, _, _) end)
		elseif button == 2 then
			awful.spawn(Audioconfig, false)
		elseif button == 1 then
			awful.spawn("wpctl set-mute @DEFAULT_SINK@ toggle", false)
			awful.spawn.easy_async("wpctl get-volume @DEFAULT_SINK@", function(stdout, _, _, _) update_graphic_sink(volumearc, stdout, _, _, _) end)
		end
	end)

	awful.widget.watch("wpctl get-volume @DEFAULT_SINK@", 1, update_graphic_sink, volumearc)
	awful.widget.watch("wpctl get-volume @DEFAULT_SOURCE@", 1, update_graphic_source, volumearc)

	return volumearc
end

--  ______      _       _     _
--  | ___ \    (_)     | |   | |
--  | |_/ /_ __ _  __ _| |__ | |_ _ __   ___  ___ ___
--  | ___ \ '__| |/ _` | '_ \| __| '_ \ / _ \/ __/ __|
--  | |_/ / |  | | (_| | | | | |_| | | |  __/\__ \__ \
--  \____/|_|  |_|\__, |_| |_|\__|_| |_|\___||___/___/
--                 __/ |
--                |___/
-- Brightnessarc_widget()

function Brightnessarc_widget()
	local brightnessarc = wibox.widget({
		{
			image = beautiful.widget_brightness,
			resize = true,
			widget = wibox.widget.imagebox,
		},
		max_value = 100,
		thickness = 2,
		start_angle = 4.71238898, -- 2pi*3/4
		forced_height = beautiful.get_font_height(beautiful.font) - 6,
		forced_width = beautiful.get_font_height(beautiful.font) - 6,
		colors = { beautiful.fg_normal },
		bg = beautiful.fg_minimize,
		paddings = 2,
		widget = wibox.container.arcchart,
	})

	local update_graphic = function(widget, stdout, _, _, _, notify)
		widget.value = tonumber(string.match(stdout, ",(%d?%d?%d)%%,"))
		if notify then awful.spawn.with_shell("notify-send -a brightness -h int:value:" .. tostring(string.match(stdout, ",(%d?%d?%d)%%,")) .. " Brightness") end
	end

	brightnessarc:connect_signal("button::press", function(_, _, _, button)
		if button == 5 then
			awful.spawn.easy_async("brightnessctl -m set 1%- -n 1", function(stdout, _, _, _) update_graphic(brightnessarc, stdout, _, _, _, true) end)
		elseif button == 4 then
			awful.spawn.easy_async("brightnessctl -m set +1% -n 1", function(stdout, _, _, _) update_graphic(brightnessarc, stdout, _, _, _, true) end)
		end
	end)

	awful.widget.watch("brightnessctl -m info", 1, update_graphic, brightnessarc)

	return brightnessarc
end

--  ______          __
--  | ___ \        / _|
--  | |_/ /__ _ __| |_ ___  _ __ _ __ ___   __ _ _ __   ___ ___
--  |  __/ _ \ '__|  _/ _ \| '__| '_ ` _ \ / _` | '_ \ / __/ _ \
--  | | |  __/ |  | || (_) | |  | | | | | | (_| | | | | (_|  __/
--  \_|  \___|_|  |_| \___/|_|  |_| |_| |_|\__,_|_| |_|\___\___|
--
-- Performance_widget()

function Performance_widget()
	local performancegraph_widget = wibox.widget({
		max_value = 100,
		color = "#74aeab",
		background_color = "#00000000",
		forced_width = 50,
		step_width = 2,
		step_spacing = 1,
		widget = wibox.widget.graph,
	})
	local performance_widget_menu = wibox.container.margin(wibox.container.mirror(performancegraph_widget, { horizontal = true }), 0, 0, 0, 5)
	performance_widget_menu:connect_signal("button::press", function(_, _, _, button)
		if button == 1 then awful.spawn(Systemmonitor) end
	end)

	local total_prev = 0
	local idle_prev = 0
	awful.widget.watch("cat /proc/stat | grep '^performance'", 1, function(widget, stdout, _, _, _)
		local user, nice, system, idle, iowait, irq, softirq, steal, _, _ = stdout:match("(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s")
		local total = user + nice + system + idle + iowait + irq + softirq + steal

		local diff_idle = idle - idle_prev
		local diff_total = total - total_prev
		local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

		if diff_usage > 80 then
			widget:set_color("#ff4136")
		else
			widget:set_color("#74aeab")
		end

		widget:add_value(diff_usage)

		total_prev = total
		idle_prev = idle
	end, performancegraph_widget)

	local performancett_text = "Pending . . ."
	local performancett = awful.tooltip({
		timer_function = function()
			run("free | awk '/^Mem/ {printf(\"%.0f\", 100-$7/$2*100)}'", function(memory)
				run("free | awk '/^Swap/ {printf(\"%.0f\", $3/$2*100)}'", function(swap) performancett_text = ("Memory: 	" .. memory:gsub("[\n\r]", "") .. "%\nSwap: 	" .. swap:gsub("[\n\r]", "") .. "%") end)
			end)
			return performancett_text
		end,
	})
	performancett:add_to_object(performance_widget_menu)
	return performance_widget_menu
end

--  ______ _ _                     _
--  |  ___(_) |                   | |
--  | |_   _| | ___  ___ _   _ ___| |_ ___ _ __ ___
--  |  _| | | |/ _ \/ __| | | / __| __/ _ \ '_ ` _ \
--  | |   | | |  __/\__ \ |_| \__ \ ||  __/ | | | | |
--  \_|   |_|_|\___||___/\__, |___/\__\___|_| |_| |_|
--                        __/ |
--                       |___/
-- Storagebar_widget()

function Storagebar_widget()
	local function storage_bar_widget_worker(user_args)
		local args = user_args or {}
		local config = {}

		config.mounts = { "/" }
		config.refresh_rate = 300

		config.widget_width = 40
		config.widget_bar_color = "#aaaaaa"
		config.widget_onclick_bg = "#ff0000"
		config.widget_border_color = "#535d6c"
		config.widget_background_color = "#222222"

		config.popup_bg = "#222222"
		config.popup_border_width = 1
		config.popup_border_color = "#535d6c"
		config.popup_bar_color = "#aaaaaa"
		config.popup_bar_background_color = "#222222"
		config.popup_bar_border_color = "#535d6c"

		local _config = {}
		for prop, value in pairs(config) do
			_config[prop] = args[prop] or beautiful[prop] or value
		end

		local storagebar_widget = wibox.widget({
			{
				id = "progressbar",
				color = _config.widget_bar_color,
				max_value = 100,
				forced_height = 20,
				forced_width = _config.widget_width,
				paddings = 2,
				margins = 4,
				border_width = 1,
				border_radius = 2,
				border_color = _config.widget_border_color,
				background_color = _config.widget_background_color,
				widget = wibox.widget.progressbar,
			},
			shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 4) end,
			widget = wibox.container.background,
			set_value = function(self, new_value) self:get_children_by_id("progressbar")[1].value = new_value end,
		})

		local disk_rows = {
			{ widget = wibox.widget.textbox },
			spacing = 4,
			layout = wibox.layout.fixed.vertical,
		}

		local disk_header = wibox.widget({
			{
				markup = "<b>Mount</b>",
				forced_width = 300,
				align = "left",
				widget = wibox.widget.textbox,
			},
			{
				markup = "<b>Used</b>",
				align = "left",
				widget = wibox.widget.textbox,
			},
			layout = wibox.layout.ratio.horizontal,
		})
		disk_header:ajust_ratio(1, 0, 0.3, 0.7)

		local popup = awful.popup({
			bg = _config.popup_bg,
			ontop = true,
			visible = false,
			shape = gears.shape.rounded_rect,
			border_width = _config.popup_border_width,
			border_color = _config.popup_border_color,
			maximum_width = 550,
			offset = { y = 5 },
			widget = {},
		})

		storagebar_widget:buttons(awful.util.table.join(awful.button({}, 1, function()
			if popup.visible then
				popup.visible = not popup.visible
				storagebar_widget:set_bg("#00000000")
			else
				storagebar_widget:set_bg(_config.widget_background_color)
				popup:move_next_to(mouse.current_widget_geometry)
			end
		end)))

		local disks = {}
		awful.widget.watch([[bash -c "df | tail -n +2"]], _config.refresh_rate, function(widget, stdout)
			for line in stdout:gmatch("[^\r\n$]+") do
				local filesystem, size, used, avail, perc, mount = line:match("([%p%w]+)%s+([%d%w]+)%s+([%d%w]+)%s+([%d%w]+)%s+([%d]+)%%%s+([%p%w]+)")

				disks[mount] = {}
				disks[mount].filesystem = filesystem
				disks[mount].size = size
				disks[mount].used = used
				disks[mount].avail = avail
				disks[mount].perc = perc
				disks[mount].mount = mount

				if disks[mount].mount == _config.mounts[1] then widget:set_value(tonumber(disks[mount].perc)) end
			end

			for k, v in ipairs(_config.mounts) do
				local row = wibox.widget({
					{
						text = disks[v].mount,
						forced_width = 300,
						widget = wibox.widget.textbox,
					},
					{
						color = _config.popup_bar_color,
						max_value = 100,
						value = tonumber(disks[v].perc),
						forced_height = 20,
						paddings = 1,
						margins = 4,
						border_width = 1,
						border_color = _config.popup_bar_border_color,
						background_color = _config.popup_bar_background_color,
						bar_border_width = 1,
						bar_border_color = _config.popup_bar_border_color,
						widget = wibox.widget.progressbar,
					},
					{
						text = math.floor(" " .. disks[v].used / 1024 / 1024) .. "GiB / " .. math.floor(disks[v].size / 1024 / 1024) .. "GiB (" .. math.floor(disks[v].perc) .. "%)",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.ratio.horizontal,
				})
				row:ajust_ratio(2, 0.3, 0.3, 0.4)

				disk_rows[k] = row
			end
			popup:setup({
				{
					disk_header,
					disk_rows,
					layout = wibox.layout.fixed.vertical,
				},
				margins = 8,
				widget = wibox.container.margin,
			})
		end, storagebar_widget)

		return storagebar_widget
	end
	return storage_bar_widget_worker({ mounts = { "/", "/mnt/OneDrive_DI", "/mnt/OneDrive_IZO" } })
end

--  ______       _   _
--  | ___ \     | | | |
--  | |_/ / __ _| |_| |_ ___ _ __ _   _
--  | ___ \/ _` | __| __/ _ \ '__| | | |
--  | |_/ / (_| | |_| ||  __/ |  | |_| |
--  \____/ \__,_|\__|\__\___|_|   \__, |
--                                 __/ |
--                                |___/
-- Battery_widget()

function Battery_widget()
	local battery_widget_menu = wibox.widget.imagebox(beautiful.widget_dirbattery .. "/0.svg")
	local batterytt_text = "Pending . . ."
	local batterytt = awful.tooltip({
		timer_function = function()
			run("cat /sys/class/power_supply/BAT0/capacity", function(capacity)
				local pers = tonumber(capacity)
				local cap = (pers / 100) * 12
				if cap - math.floor(cap) >= 0.5 then
					cap = math.floor(cap) + 1
				else
					cap = math.floor(cap)
				end

				run("cat /sys/class/power_supply/BAT0/status", function(status)
					local suffix = ""
					if status:find("Charging") ~= nil then suffix = "c" end
					battery_widget_menu:set_image(beautiful.widget_dirbattery .. "/" .. cap .. suffix .. ".svg")

					batterytt_text = capacity:gsub("[\n\r]", "") .. "% (" .. status:gsub("[\n\r]", "") .. ")"
				end)
			end)
			return batterytt_text
		end,
	})
	batterytt:add_to_object(battery_widget_menu)

	local function update_graphic(widget, capacity, _, _, _)
		local pers = tonumber(capacity)
		local cap = (pers / 100) * 12
		if cap - math.floor(cap) >= 0.5 then
			cap = math.floor(cap) + 1
		else
			cap = math.floor(cap)
		end

		run("cat /sys/class/power_supply/BAT0/status", function(status)
			local suffix = ""
			if status:find("Charging") ~= nil then
				suffix = "c"
			else
				if pers <= 20 then awful.spawn.with_shell("notify-send -u critical -a battery 'Houston, we have a problem' 'Battery is dying'") end
			end
			widget:set_image(beautiful.widget_dirbattery .. "/" .. cap .. suffix .. ".svg")
		end)
	end

	awful.widget.watch("cat /sys/class/power_supply/BAT0/capacity", 120, update_graphic, battery_widget_menu)

	return battery_widget_menu
end

--   _____       _                _
--  /  __ \     | |              | |
--  | /  \/ __ _| | ___ _ __   __| | __ _ _ __
--  | |    / _` | |/ _ \ '_ \ / _` |/ _` | '__|
--  | \__/\ (_| | |  __/ | | | (_| | (_| | |
--   \____/\__,_|_|\___|_| |_|\__,_|\__,_|_|
--
-- Calendar_widget()

function Calendar_widget(s)
	local calender_menu = wibox.widget.textclock("%d-%b-%y %k:%M")
	awful.widget.calendar_popup
		.year({
			screen = s,
			spacing = 0,
			week_numbers = true,
			style_month = { padding = 8, border_width = 2 },
			style_weekday = { border_width = 1 },
			style_weeknumber = { border_width = 1 },
		})
		:attach(calender_menu, "tr")
	return calender_menu
end
