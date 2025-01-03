-----------------------------
-- My custom awesome theme --
-----------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local vars = require("vars")

local theme = {
    font          = "Hack Nerd Font Mono 14",

    fg_normal     = "#bbbbbb",
    bg_normal     = "#222222",

    fg_focus      = "#dddddd",
    bg_focus      = "#434d5c",

    fg_urgent     = "#ffffff",
    bg_urgent     = "#dd2222",

    fg_minimize   = "#ffffff",
    bg_minimize   = "#444444",

    bg_systray    = "#222222",


    useless_gap   = dpi(0),
    border_width  = dpi(4),

    border_normal = "#000000",
    border_focus  = "#FFCB6B",
    border_marked = "#4123dc",
}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
-- What are they for though???
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--     taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--     taglist_square_size, theme.fg_normal
-- )

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = vars.theme_dir .."/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = vars.theme_dir .. "/titlebar/close_normal.png"
-- theme.titlebar_close_button_normal = vars.theme_dir .. "/test/close_empty.png"
theme.titlebar_close_button_focus  = vars.theme_dir .. "/titlebar/close_focus.png"
-- theme.titlebar_close_button_focus  = vars.theme_dir .. "/test/close_empty.png"

theme.titlebar_minimize_button_normal = vars.theme_dir .. "/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = vars.theme_dir .. "/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = vars.theme_dir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = vars.theme_dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = vars.theme_dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = vars.theme_dir .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = vars.theme_dir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = vars.theme_dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = vars.theme_dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = vars.theme_dir .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = vars.theme_dir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = vars.theme_dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = vars.theme_dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = vars.theme_dir .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = vars.theme_dir .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = vars.theme_dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = vars.theme_dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = vars.theme_dir .. "/titlebar/maximized_focus_active.png"

theme.wallpaper = vars.theme_dir .. "/wallpaper.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = vars.theme_dir .. "/layouts/fairhw.png"
theme.layout_fairv = vars.theme_dir .. "/layouts/fairvw.png"
theme.layout_floating  = vars.theme_dir .. "/layouts/floatingw.png"
theme.layout_magnifier = vars.theme_dir .. "/layouts/magnifierw.png"
theme.layout_max = vars.theme_dir .. "/layouts/maxw.png"
theme.layout_fullscreen = vars.theme_dir .. "/layouts/fullscreenw.png"
theme.layout_tilebottom = vars.theme_dir .. "/layouts/tilebottomw.png"
theme.layout_tileleft   = vars.theme_dir .. "/layouts/tileleftw.png"
theme.layout_tile = vars.theme_dir .. "/layouts/tilew.png"
theme.layout_tiletop = vars.theme_dir .. "/layouts/tiletopw.png"
theme.layout_spiral  = vars.theme_dir .. "/layouts/spiralw.png"
theme.layout_dwindle = vars.theme_dir .. "/layouts/dwindlew.png"
theme.layout_cornernw = vars.theme_dir .. "/layouts/cornernww.png"
theme.layout_cornerne = vars.theme_dir .. "/layouts/cornernew.png"
theme.layout_cornersw = vars.theme_dir .. "/layouts/cornersww.png"
theme.layout_cornerse = vars.theme_dir .. "/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil


-- TODO: other kind of indicator for task.
theme.tasklist_plain_task_name=true


return theme

