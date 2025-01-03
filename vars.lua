local M = {
    terminal = "alacritty",
    editor = os.getenv("EDITOR") or "vim",
    theme_dir = os.getenv("XDG_CONFIG_HOME") .. "/awesome/theme",

    titlebar = {
        tooltips = true,
    }
}


return M

