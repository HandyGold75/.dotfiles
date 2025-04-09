--   _____ _                   _
--  /  ___(_)                 | |
--  \ `--. _  __ _ _ __   __ _| |___
--   `--. \ |/ _` | '_ \ / _` | / __|
--  /\__/ / | (_| | | | | (_| | \__ \
--  \____/|_|\__, |_| |_|\__,_|_|___/
--            __/ |
--           |___/

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

client.connect_signal("manage", function(c)
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then awful.placement.no_offscreen(c) end
end)
client.connect_signal("mouse::enter", function(c) c:emit_signal("request::activate", { raise = false }) end)
screen.connect_signal("tag::history::update", function()
	gears.timer({
		timeout = 0.01,
		autostart = true,
		single_shot = true,
		callback = function()
			local n = mouse.object_under_pointer()
			if n ~= nil and n ~= client.focus then client.focus = n end
		end,
	})
end)

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
