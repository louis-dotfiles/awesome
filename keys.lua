local awful = require("awful")
local gears = require("gears")

local vars = require("vars")


local M = {}


M.modkey = "Mod4"

M.global_keys = gears.table.join(
    -- Tags.
    awful.key(
        { M.modkey, "Shift" }, "[",
        awful.tag.viewprev,
        { description = "Previous tab.", group = "Tags" }
    ),
    awful.key(
        { M.modkey, "Shift" }, "]",
        awful.tag.viewnext,
        { description = "View next.", group = "Tags" }
    ),
    awful.key(
        { M.modkey, "Ctrl" }, "o", -- Vim's <C-o> "equivalent".
        awful.tag.history.restore,
        { description = "Previous historical tab.", group = "Tags" }
    ),


    -- Windows.
    awful.key(
        { M.modkey }, "j",
        function () awful.client.focus.byidx(1) end,
        { description = "Focus next window.", group = "Windows" }
    ),
    awful.key(
        { M.modkey }, "k",
        function () awful.client.focus.byidx(-1) end,
        { description = "Focus previous window.", group = "Windows" }
    ),
    awful.key(
        { M.modkey }, "u",
        awful.client.urgent.jumpto,
        { description = "Jump to urgent window.", group = "Windows" }
    ),
    awful.key(
        { M.modkey }, "o", -- Vim's <C-o> "equivalent".
        function () awful.client.focus.history.previous() if client.focus then client.focus:raise() end end,
        { description = "Previous historical window.", group = "Windows" }
    ),
    awful.key(
        { M.modkey, "Alt" }, "l",
        function () awful.tag.incmwfact(0.10) end,
        { description = "Increase width.", group = "layout" }
    ),
    awful.key(
        { M.modkey, "Alt" }, "h",
        function () awful.tag.incmwfact(-0.10) end,
        { description = "Decrease width.", group = "layout" }
    ),


    -- Standard programs.
    awful.key(
        { M.modkey }, "Return",
        function () awful.spawn(vars.terminal) end,
        { description = "Open a terminal.", group = "Launcher" }
    ),
    awful.key(
        { M.modkey }, "r",
        function () awful.screen.focused().mypromptbox:run() end,
        { description = "Run prompt.", group = "Launcher" }
    ),


    -- Awesome keybinds.
    awful.key(
        { M.modkey, "Control" }, "r",
        awesome.restart,
        { description = "Reload awesome.", group = "Awesome" }
    ),
    awful.key(
        { M.modkey, "Shift" }, "q",
        awesome.quit,
        { description = "Quit awesome.", group = "Awesome" }
    ),



    -- I'll probably never use this.
    -- awful.key({ M.modkey,           }, "w", function () mymainmenu:show() end,
    --   {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    -- awful.key({ M.modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
    --   {description = "swap with next client by index", group = "client"}),
    --
    -- awful.key({ M.modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
    --   {description = "swap with previous client by index", group = "client"}),

    -- awful.key({ M.modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
    --   {description = "focus the next screen", group = "screen"}),
    --
    -- awful.key({ M.modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
    --   {description = "focus the previous screen", group = "screen"}),

    -- awful.key({ M.modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    --   {description = "increase master width factor", group = "layout"}),
    -- awful.key({ M.modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    --   {description = "decrease master width factor", group = "layout"}),

    -- Don't know what this does.
    awful.key({ M.modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ M.modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}),

    awful.key({ M.modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ M.modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
        {description = "decrease the number of columns", group = "layout"}),

    awful.key({ M.modkey,           }, "space", function () awful.layout.inc( 1)                end,
        {description = "select next", group = "layout"}),
    awful.key({ M.modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
        {description = "select previous", group = "layout"}),

    awful.key(
        { M.modkey, "Control" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", {raise = true}
                )
            end
        end,
        { description = "restore minimized", group = "client" }
    )

    -- awful.key({ M.modkey }, "x",
    --   function ()
    --     awful.prompt.run {
    --       prompt       = "Run Lua code: ",
    --       textbox      = awful.screen.focused().mypromptbox.widget,
    --       exe_callback = awful.util.eval,
    --       history_path = awful.util.get_cache_dir() .. "/history_eval"
    --     }
    --   end,
    --   {description = "lua execute prompt", group = "awesome"}),

    -- Menubar
    -- awful.key({ M.modkey }, "p", function() menubar.show() end,
    --   {description = "show the menubar", group = "launcher"})
)

local tag_id_to_key = {
    -- Access the first 3 tags with 1,2,3 (left hand).
    [1] = 1,
    [2] = 2,
    [3] = 3,

    -- Access the last 3 tags with 8,9,0 (right hand).
    [4] = 8,
    [5] = 9,
    [6] = 0,
}

for tag_id = 1, 6 do
    local key = tostring(tag_id_to_key[tag_id])
    M.global_keys = gears.table.join(
        M.global_keys,

        -- View tag only.
        awful.key({ M.modkey }, key,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[tag_id]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. tag_id, group = "tag" }
        ),

        -- Toggle tag display.
        awful.key({ M.modkey, "Control" }, key,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[tag_id]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. tag_id, group = "tag" }
        ),

        -- Move client to tag.
        awful.key({ M.modkey, "Shift" }, key,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[tag_id]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #"..tag_id, group = "tag" }
        ),

        -- Toggle tag on focused client.
        awful.key({ M.modkey, "Control", "Shift" }, key,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[tag_id]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. tag_id, group = "tag" }
        )
    )
end


return M

