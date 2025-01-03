local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local theme = require("theme.theme")

local mouse_buttons = require("types").mouse_buttons


local function make_tags_for_screen(screen)
    for id = 1, 6 do
        local tag_name = tostring(id)
        awful.tag.add(tag_name, {
            screen = screen,
            layout = awful.layout.layouts[1],
        })
    end
end


local taglist_buttons = gears.table.join(
    awful.button({}, mouse_buttons.Left, function(tag) tag:view_only() end)
)


local icon_widget = {
    id     = 'icon_role',
    widget = wibox.widget.imagebox,
    image  = theme.taglist.icons.tag_has_no_clients,
}


-- Changes the icon:
-- - different style if there are clients with the given tag.
-- - different color of it is the currently selected tag.
local function update_tag_widget(widget, widget_index)
    local focused_tag = awful.screen.focused().selected_tag

    -- Awesome doens't focus any tag by default, unless it is specifically told
    -- to do so.
    if not focused_tag then return end

    local color = theme.taglist.colors.inactive
    if focused_tag.index == widget_index then
        color = theme.taglist.colors.active
    end

    local icon = theme.taglist.icons.tag_has_no_clients

    -- I don't know if there's an easier way to get the tag associated with a
    -- button.
    local all_tags = awful.screen.focused().tags
    local widget_tag = all_tags[widget_index]
    local clients = widget_tag:clients()

    if #clients > 0 then
        icon = theme.taglist.icons.tag_has_clients
    end

    widget:get_children_by_id(icon_widget.id)[1].image = gears.color.recolor_image(
        icon,
        color
    )
end


local function tag_widget_create_callback(self, _, widget_index, _)
    update_tag_widget(self, widget_index)
end

local function tag_widget_update_callback(self, _, widget_index, _)
    update_tag_widget(self, widget_index)
end


-- https://awesomewm.org/doc/api/classes/tag.html#
-- https://awesomewm.org/doc/api/classes/awful.widget.taglist.html
-- https://awesomewm.org/doc/api/documentation/03-declarative-layout.md.html#
local function make_taglist_for_screen(screen)
    screen.mytaglist = awful.widget.taglist({
        screen  = screen,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = {
            icon_widget,

            widget  = wibox.container.margin,
            top = 8,
            bottom = 8,
            left = 6,
            right = 6,

            create_callback = tag_widget_create_callback,
            update_callback = tag_widget_update_callback,
        },
    })
end


local M = {}

function M.setup_for_screen(screen)
    make_tags_for_screen(screen)
    make_taglist_for_screen(screen)
end

return M

