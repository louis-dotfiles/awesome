local naughty = require("naughty")
local gears = require("gears")


local M = {}


---Debug anything?
---
---@param msg any
function M.debug(msg)
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "DEBUG",
        text = gears.debug.dump_return(msg),
        timeout = 15,
    })
end


function M.capitalize_first_letter(str)
    return str:gsub("^%l", string.upper)
end


return M

