local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("theme.theme")

local mouse_buttons = require("types").mouse_buttons
local capitalize_first_letter = require("utils").capitalize_first_letter

local titlebar_buttons = require("titlebar.buttons")

local function make_buttons_for_client(client)
    local buttons = gears.table.join(
        awful.button(
            {}, mouse_buttons.Left,
            function()
                client:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.move(client)
            end
        ),
        awful.button(
            {}, mouse_buttons.Right,
            function()
                client:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.resize(client)
            end
        )
    )

    return buttons
end


local function make_titlebar_for_client(client)
    local buttons = make_buttons_for_client(client)

    local left_titlebar = {
        {
            awful.titlebar.widget.iconwidget(client),
            margins = 4,
            widget = wibox.container.margin,
        },
        {
            text = capitalize_first_letter(client.class),
            align = "left",
            widget = wibox.widget.textbox,
        },
        buttons = buttons,
        layout  = wibox.layout.align.horizontal
    }

    local middle_titlebar = {
        {
            text  = "TODO",
            align = "center",
            widget = wibox.widget.textbox,
        },
        buttons = buttons,
        widget = wibox.widget.background,
    }

    local right_titlebar = {
        -- awful.titlebar.widget.floatingbutton (client),
        -- awful.titlebar.widget.maximizedbutton(client),
        -- awful.titlebar.widget.stickybutton   (client),
        -- awful.titlebar.widget.ontopbutton    (client),
        -- awful.titlebar.widget.closebutton    (client),
        titlebar_buttons.reduce_button(client),
        titlebar_buttons.maximize_button(client),
        titlebar_buttons.close_button(client),

        layout = wibox.layout.fixed.horizontal,
    }

    awful.titlebar(client):setup({
        left_titlebar,
        middle_titlebar,
        right_titlebar,

        layout = wibox.layout.align.horizontal,
    })
end


local M = {}


function M.setup_for_client(client)
    make_titlebar_for_client(client)
end


return M

