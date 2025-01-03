local awful = require("awful")
local tooltip = require("awful.tooltip")
local wibox = require("wibox")
local gears = require("gears")

local vars = require("vars")
local theme = require("theme.theme")

local my_types = require("types")
local mouse_buttons = my_types.mouse_buttons
local mouse_events = my_types.mouse_events
local button_events = my_types.button_events
local button_state = my_types.button_state

local utils = require("utils")


local M = {}


--- Based on a native Awesomewm implementation.
---
---Creates a button for the titlebar.
---The icon is based on the name. (Shit idea, change that)
---
---@param current_client any Client to make the button for.
---@param button_name string
---@param action fun(client: any) What to do when the button s pressed.
---@param tooltip_msg? string Contents of the tooltip, default to the button name.
---@return table
local function button(current_client, button_name, action, tooltip_msg)
    local widget = wibox.container.margin()
    widget.button_state = button_state.default


    if tooltip_msg and vars.titlebar.tooltips then
        widget._private.tooltip = tooltip({ objects = { widget }, delay_show = 1 })
        widget._private.tooltip:set_text(tooltip_msg)
    end


    local function update()
        local button_theme = theme.titlebar.buttons[button_name]

        local icon = button_theme.icons[widget.button_state]
        local color = button_theme.colors[widget.button_state]

        local img = gears.color.recolor_image(
            icon,
            color
        )

        local icon_widget = wibox.widget.imagebox()
        icon_widget.image = img

        widget.margins = theme.titlebar.buttons.margins

        widget.widget = icon_widget
    end


    -- Hover.
    widget:connect_signal(mouse_events.enter, function()
        widget.button_state = button_state.hover
        update()
    end)
    widget:connect_signal(mouse_events.leave, function()
        widget.button_state = button_state.default
        update()
    end)


    -- Button press.

    -- Only do the action on release.
    widget:buttons(awful.button({}, mouse_buttons.Left, nil, function()
        action(current_client)
    end))

    -- Change the theme on initial press.
    widget:connect_signal(button_events.press, function(_, _, _, btn)
        if btn == mouse_buttons.Left then
            widget.button_state = button_state.pressed
            update()
        end
    end)


    widget.update = update
    update()


    current_client:connect_signal("focus", update)
    current_client:connect_signal("unfocus", update)


    return widget
end


---comment
---
---@param client any
---@return table
function M.close_button(client)
    return button(client, "close", function(cl) cl:kill() end)
end

---comment
---
---@param client any
---@return table
function M.maximize_button(client)
    return button(
        client,
        "maximize",
        function(cl) cl.maximized = not cl.maximized or false end
    )
end


---comment
---
---@param client any
---@return table
function M.reduce_button(client)
    return button(
        client,
        "reduce",
        function(cl) cl.minimized = not cl.minimized or false end
    )
end


return M

