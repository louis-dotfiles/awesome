local vicious = require("vicious")
local wibox = require("wibox")
local beautiful = require("beautiful")

local batwidget = wibox.widget.progressbar()

-- Create wibox with batwidget
local batbox = {
    {
        {
            max_value = 1,
            widget = batwidget,
            border_width = 0.5,
            border_color = "#000000",
            color = {
                type = "linear",
                from = { 0, 0 },
                to = { 0, 30 },
                stops = {
                    { 0, "#AECF96" },
                    { 1, "#FF5656" },
                },
            },
        },
        forced_height = 10,
        forced_width = 8,
        -- color = beautiful.fg_widget,

        direction = "east",
        -- direction = "south",
        layout = wibox.container.rotate,
    },
    top    = 1,
    bottom = 1,
    left  = 3,
    right = 3,
    widget = wibox.container.margin,
}

-- Register battery widget
vicious.register(batwidget, vicious.widgets.bat, "$2", 60, "BAT0")


return batbox

