-----------------------------
-- My custom awesome theme --
-----------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local vars = require("vars")
local icons_dir = vars.theme_dir .. "/test"

local generic_icons = {
  circle_empty = icons_dir .. "/circle_empty.png",
  circle_full  = icons_dir .. "/circle_full.png",
}

local theme = {
  font = "Hack Nerd Font Mono 14",

  fg_normal = "#bbbbbb",
  bg_normal = "#222222",

  fg_focus = "#cccccc",
  bg_focus = "#434d5c",

  fg_urgent = "#ffffff",
  bg_urgent = "#dd2222",

  fg_minimize = "#ffffff",
  bg_minimize = "#444444",

  bg_systray = "#222222",


  useless_gap   = dpi(0),
  border_width  = dpi(4),

  border_normal = "#000000",
  border_focus  = "#FFCB6B",
  border_marked = "#4123dc",

  taglist = {
    colors =  {
      active   = "#FFC050",
      inactive = "#555555",
    },

    icons = {
      tag_has_clients    = icons_dir .. "/circle_full.png",
      tag_has_no_clients = icons_dir .. "/circle_empty.png",
    },
  },

  titlebar = {
    buttons = {
      margins = 8,

      reduce = {
        colors = {
          default = "#00cc00",
          hover   = "#00ee00",
          pressed = "#ffffff",
        },
        icons = {
          default = generic_icons.circle_full,
          hover   = generic_icons.circle_full,
          pressed = generic_icons.circle_full,
        },
      },
      maximize = {
        colors = {
          default = "#ff9900",
          hover   = "#ffbb11",
          pressed = "#ffffff",
        },
        icons = {
          default = generic_icons.circle_full,
          hover   = generic_icons.circle_full,
          pressed = generic_icons.circle_full,
        },
      },
      close = {
        colors = {
          default = "#ee2200",
          hover   = "#ff5522",
          pressed = "#ffffff",
        },
        icons = {
          default = generic_icons.circle_full,
          hover   = generic_icons.circle_full,
          pressed = generic_icons.circle_full,
        },
      },
    },
  },

  custom_colors =  {
    taglist_active   = "#FFC050",
    taglist_inactive = "#555555",
  },

  custom_icons = {
    tag_has_clients    = icons_dir .. "/circle_full.png",
    tag_has_no_clients = icons_dir .. "/circle_empty.png",
  },

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
  menu_submenu_icon = vars.theme_dir .."/submenu.png",
  menu_height = dpi(30),
  menu_width  = dpi(350),

  -- You can add as many variables as
  -- you wish and access them by using
  -- beautiful.variable in your rc.lua
  --  bg_widget = "#cc0000"

  -- Define the image to load
  titlebar_close_button_normal = vars.theme_dir .. "/titlebar/close_normal.png",
  -- titlebar_close_button_normal = vars.theme_dir .. "/test/close_empty.png",
  -- titlebar_close_button_focus  = vars.theme_dir .. "/titlebar/close_focus.png",
  titlebar_close_button_focus  = vars.theme_dir .. "/test/close_full.png",

  titlebar_minimize_button_normal = vars.theme_dir .. "/titlebar/minimize_normal.png",
  titlebar_minimize_button_focus  = vars.theme_dir .. "/titlebar/minimize_focus.png",

  titlebar_ontop_button_normal_inactive = vars.theme_dir .. "/titlebar/ontop_normal_inactive.png",
  titlebar_ontop_button_focus_inactive  = vars.theme_dir .. "/titlebar/ontop_focus_inactive.png",
  titlebar_ontop_button_normal_active = vars.theme_dir .. "/titlebar/ontop_normal_active.png",
  titlebar_ontop_button_focus_active  = vars.theme_dir .. "/titlebar/ontop_focus_active.png",

  titlebar_sticky_button_normal_inactive = vars.theme_dir .. "/titlebar/sticky_normal_inactive.png",
  titlebar_sticky_button_focus_inactive  = vars.theme_dir .. "/titlebar/sticky_focus_inactive.png",
  titlebar_sticky_button_normal_active = vars.theme_dir .. "/titlebar/sticky_normal_active.png",
  titlebar_sticky_button_focus_active  = vars.theme_dir .. "/titlebar/sticky_focus_active.png",

  titlebar_floating_button_normal_inactive = vars.theme_dir .. "/titlebar/floating_normal_inactive.png",
  titlebar_floating_button_focus_inactive  = vars.theme_dir .. "/titlebar/floating_focus_inactive.png",
  titlebar_floating_button_normal_active = vars.theme_dir .. "/titlebar/floating_normal_active.png",
  titlebar_floating_button_focus_active  = vars.theme_dir .. "/titlebar/floating_focus_active.png",

  titlebar_maximized_button_normal_inactive = vars.theme_dir .. "/titlebar/maximized_normal_inactive.png",
  titlebar_maximized_button_focus_inactive  = vars.theme_dir .. "/titlebar/maximized_focus_inactive.png",
  titlebar_maximized_button_normal_active = vars.theme_dir .. "/titlebar/maximized_normal_active.png",
  titlebar_maximized_button_focus_active  = vars.theme_dir .. "/titlebar/maximized_focus_active.png",

  wallpaper = vars.theme_dir .. "/wallpaper.jpg",

  -- You can use your own layout icons like this:
  layout_fairh = vars.theme_dir .. "/layouts/fairhw.png",
  layout_fairv = vars.theme_dir .. "/layouts/fairvw.png",
  layout_floating  = vars.theme_dir .. "/layouts/floatingw.png",
  layout_magnifier = vars.theme_dir .. "/layouts/magnifierw.png",
  layout_max = vars.theme_dir .. "/layouts/maxw.png",
  layout_fullscreen = vars.theme_dir .. "/layouts/fullscreenw.png",
  layout_tilebottom = vars.theme_dir .. "/layouts/tilebottomw.png",
  layout_tileleft   = vars.theme_dir .. "/layouts/tileleftw.png",
  layout_tile = vars.theme_dir .. "/layouts/tilew.png",
  layout_tiletop = vars.theme_dir .. "/layouts/tiletopw.png",
  layout_spiral  = vars.theme_dir .. "/layouts/spiralw.png",
  layout_dwindle = vars.theme_dir .. "/layouts/dwindlew.png",
  layout_cornernw = vars.theme_dir .. "/layouts/cornernww.png",
  layout_cornerne = vars.theme_dir .. "/layouts/cornernew.png",
  layout_cornersw = vars.theme_dir .. "/layouts/cornersww.png",
  layout_cornerse = vars.theme_dir .. "/layouts/cornersew.png",

  -- Generate Awesome icon:

  -- Define the icon theme for application icons. If not set then the icons
  -- from /usr/share/icons and /usr/share/icons/hicolor will be used.
  icon_theme = nil,


  -- TODO: other kind of indicator for task.
  tasklist_plain_task_name=true,
}

theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height,
  theme.bg_focus,
  theme.fg_focus
)

return theme

