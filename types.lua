
M = {}


-- https://awesomewm.org/doc/api/libraries/mouse.html
M.mouse_buttons = {
    Left  = 1,
    Right = 3,

    WheelClick      = 2,
    WheelScrollUp   = 4,
    WheelScrollDown = 5,
}

M.button_state = {
    default = "default",
    hover = "hover",
    pressed = "pressed",
}

M.mouse_events = {
    enter = "mouse::enter",
    leave = "mouse::leave",
}

M.button_events = {
    press = "button::press",
}


return M

