local home = os.getenv("HOME") or "~"
local xdg_data_dirs = home .. "/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"

return {
    terminal = "kitty",
    file_manager = "nautilus -w",
    menu = "export XDG_DATA_DIRS=" .. xdg_data_dirs .. " && wofi --show drun",
    xdg_data_dirs = xdg_data_dirs,
    cursor_theme = "sweet-cursors",
    cursor_size = 24,
}
