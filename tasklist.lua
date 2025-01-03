local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local mouse_buttons = require("types").mouse_buttons

local capitalize_first_letter = require("utils").capitalize_first_letter

local tasklist_buttons = gears.table.join(
    awful.button({}, mouse_buttons.Left, function(current_client)
        if current_client == client.focus then
            current_client.minimized = true
        else
            current_client:emit_signal(
                "request::activate",
                "tasklist",
                { raise = true }
            )
        end
    end)
    -- awful.button({}, mouse.Right, function()
    --   awful.menu.client_list({ theme = { width = 250 } })
    -- end)
)

local icon_widget = {
    {
        id     = 'icon_role',
        widget = wibox.widget.imagebox,
    },
    margins = 5,
    widget  = wibox.container.margin,
}

local title_widget = {
    id     = 'custom_title',
    widget = wibox.widget.textbox,
}

-- local reduced_widget = {
--     id     = 'reduced',
--     widget = wibox.widget.imagebox,
-- }


local function update_widget_text(widget, name)
    local title = capitalize_first_letter(name)
    widget:get_children_by_id(title_widget.id)[1].text = title
end

local function task_widget_create_callback(widget, client, _, _)
    update_widget_text(widget, client.class)
end

local function task_widget_update_callback(widget, client, _, _)
    update_widget_text(widget, client.class)
end


local function make_tasklist_for_screen(screen)
    screen.mytasklist = awful.widget.tasklist({
        screen  = screen,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape_border_width = 1,
            shape_border_color = '#777777',
            shape = gears.shape.rectangle,
        },
        layout = {
            spacing = 10,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    icon_widget,
                    title_widget,
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 10,
                right = 10,
                widget = wibox.container.margin
            },
            forced_width = 220,
            id     = 'background_role',
            widget = wibox.container.background,

            create_callback = task_widget_create_callback,
            update_callback = task_widget_update_callback,
        },
    })
end


local M = {}


function M.setup_for_screen(screen)
    make_tasklist_for_screen(screen)
end


return M

