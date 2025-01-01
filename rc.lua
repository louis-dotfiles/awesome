-- Life saver.
-- https://awesomewm.org/apidoc/

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")


local vars = require("vars")


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



beautiful.init(os.getenv("XDG_CONFIG_HOME") .. "/awesome/theme/theme.lua")



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


-- Wibar
-- Create a wibox for each screen and add it ???????????????????
-- function button.new(mod, _button, press, release)
local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ keys.modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ keys.modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (current_client)
    if current_client == client.focus then
      current_client.minimized = true
    else
      current_client:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),
  awful.button({ }, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
  end)
)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

local clock_widget = wibox.widget.textclock()
local keyboard_layout_widget = awful.widget.keyboardlayout()

-- Re-set wallpaper when a screen's geometry changes (e.g. different
-- resolution).
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(current_screen)
  -- Wallpaper
  set_wallpaper(current_screen)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6" }, current_screen, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  current_screen.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  current_screen.mylayoutbox = awful.widget.layoutbox(current_screen)
  current_screen.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a taglist widget.
  current_screen.mytaglist = awful.widget.taglist({
    screen  = current_screen,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  })

  -- Create a tasklist widget.
  current_screen.mytasklist = awful.widget.tasklist({
    screen  = current_screen,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  })

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

    keyboard_layout_widget,
    wibox.widget.systray(),
    clock_widget,
    current_screen.mylayoutbox,
  }

  -- Add widgets to the wibox
  current_screen.mywibox:setup({
    layout = wibox.layout.align.horizontal,

    left_wibox_widgets,
    middle_wibox_widgets,
    right_wibox_widgets,
  })
end)

-- Mouse bindings
root.buttons(gears.table.join(
  awful.button({ }, 3, function () my_main_menu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
))




-- Key bindings

-- Keybindings for individual windows.
local clientkeys = gears.table.join(
  awful.key({ keys.modkey }, "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "Toggle fullscreen.", group = "cWindowlient" }
  ),

  awful.key({ keys.modkey, "Shift" }, "c",
    function (c) c:kill() end,
    { description = "Close.", group = "Window" }
  ),
  awful.key({ keys.modkey, "Control" }, "space",
    awful.client.floating.toggle,
    { description = "Toggle floating.", group = "Window" }
  ),

  awful.key({ keys.modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
    { description = "Move to master.", group = "Window" }),

  awful.key({ keys.modkey }, "t",
    function (c) c.ontop = not c.ontop end,
    { description = "Toggle keep on top.", group = "Window" }
  ),

  awful.key({ keys.modkey }, "n",
    function (c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end ,
    { description = "minimize", group = "client" }
  ),

  awful.key({ keys.modkey,           }, "m",
    function (c)
      c.maximized = not c.maximized
      c:raise()
    end ,
    { description = "(un)maximize", group = "client" }),

  awful.key({ keys.modkey, "Control" }, "m",
    function (c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end ,
    { description = "(un)maximize vertically", group = "client" }),

  awful.key({ keys.modkey, "Shift"   }, "m",
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end ,
    { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

local clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ keys.modkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ keys.modkey }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
)

-- Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,

      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA",  -- Firefox addon DownThemAll.
        "copyq",  -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer"
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester",  -- xev.
      },
      role = {
        "AlarmWindow",   -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = { floating = true }
  },

  -- Add titlebars to normal clients and dialogs.
  {
    rule_any = {
      type = { "normal", "dialog" }
    },
    properties = { titlebars_enabled = true }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- {
  --   rule = { class = "Firefox" },
  --   properties = {
  --     screen = 1,
  --     tag = "2",
  --   }
  -- },
}

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
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  local left_titlebar = {
    awful.titlebar.widget.iconwidget(c),
    buttons = buttons,
    layout  = wibox.layout.fixed.horizontal
  }

  local middle_titlebar = {
    { -- Title.
      align  = "center",
      widget = awful.titlebar.widget.titlewidget(c)
    },
    buttons = buttons,
    layout  = wibox.layout.flex.horizontal
  }

  local right_titlebar = {
    awful.titlebar.widget.floatingbutton (c),
    awful.titlebar.widget.maximizedbutton(c),
    awful.titlebar.widget.stickybutton   (c),
    awful.titlebar.widget.ontopbutton    (c),
    awful.titlebar.widget.closebutton    (c),
    layout = wibox.layout.fixed.horizontal()
  }

  awful.titlebar(c) : setup {
    left_titlebar,
    middle_titlebar,
    right_titlebar,

    layout = wibox.layout.align.horizontal
  }
end)


client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

