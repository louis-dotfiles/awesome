-- Life saver.
-- https://awesomewm.org/apidoc/

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local vicious = require("vicious")

local vars = require("vars")
local mouse_buttons = require("types").mouse_buttons

-- Standard awesome library.
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library.
local wibox = require("wibox")

-- Theme handling library.
local beautiful = require("beautiful")

local menubar = require("menubar")
menubar.utils.terminal = vars.terminal -- Set the terminal for applications that require it


local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")


local taglist = require("taglist")
local tasklist = require("tasklist")
local titlebar = require("titlebar")
local batbox = require("widgets.battery")

-- Define top level keys.
local keys = require("keys")
keys.global_keys = gears.table.join(
  keys.global_keys,
  awful.key(
    { keys.modkey, "Shift" }, "/",
    hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }
  )
)
root.keys(keys.global_keys)


require("error_handling")
require("rules")

local debug = require("utils").debug



beautiful.init(vars.theme_dir .. "/theme.lua")



-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
}


local my_awesome_menu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", vars.terminal .. " -e man awesome" },
  { "edit config", vars.terminal .. " -e " .. vars.editor .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

local my_main_menu = awful.menu({
  items = {
    { "awesome", my_awesome_menu, beautiful.awesome_icon },
    { "open terminal", vars.terminal },
  }
})


local my_launcher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = my_main_menu,
})



local function set_wallpaper(current_screen)
  local wallpaper = beautiful.wallpaper

  if wallpaper then
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(current_screen)
    end
    gears.wallpaper.maximized(wallpaper, current_screen, true)
  end
end


local keyboard_layout_widget = awful.widget.keyboardlayout()
local clock_widget = wibox.widget.textclock("%H:%M")


-- Re-set wallpaper when a screen's geometry changes (e.g. different
-- resolution).
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(current_screen)
  set_wallpaper(current_screen)

  taglist.setup_for_screen(current_screen)
  tasklist.setup_for_screen(current_screen)

  current_screen.mypromptbox = awful.widget.prompt()


  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  current_screen.mylayoutbox = awful.widget.layoutbox(current_screen)
  current_screen.mylayoutbox:buttons(gears.table.join(
    awful.button({}, mouse_buttons.Left,  function () awful.layout.inc( 1) end),
    awful.button({}, mouse_buttons.Right, function () awful.layout.inc(-1) end)
  ))


  -- Create the wibox.
  current_screen.mywibox = awful.wibar({ position = "top", screen = current_screen })

  local left_wibox_widgets = {
    layout = wibox.layout.fixed.horizontal,

    my_launcher,
    current_screen.mytaglist,
    current_screen.mypromptbox,
  }

  local middle_wibox_widgets = current_screen.mytasklist

  local right_wibox_widgets = {
    layout = wibox.layout.fixed.horizontal,

    batbox,
    keyboard_layout_widget,
    wibox.widget.systray(),
    clock_widget,
    {
      current_screen.mylayoutbox,

      widget = wibox.container.margin,
      left = 10,
    },
  }

  -- Add widgets to the wibox
  current_screen.mywibox:setup({
    layout = wibox.layout.align.horizontal,

    left_wibox_widgets,
    middle_wibox_widgets,
    right_wibox_widgets,
  })
end)


-- Focus the first tag of the first screen by default.
local screen = awful.screen.focused()
local tag = screen.tags[1]
if tag then
    tag:view_only()
end



root.buttons(gears.table.join(
  awful.button({}, mouse_buttons.Right, function () my_main_menu:toggle() end),
  awful.button({}, mouse_buttons.WheelScrollUp, awful.tag.viewnext),
  awful.button({}, mouse_buttons.WheelScrollDown, awful.tag.viewprev)
))



-- Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", titlebar.setup_for_client)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

