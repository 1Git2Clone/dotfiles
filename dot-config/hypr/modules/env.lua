local M = {}

function M.setup(programs)
  hl.env("XCURSOR_THEME", "Hutao-Cursor")
  hl.env("XCURSOR_SIZE", "24")
  hl.env("HYPRCURSOR_SIZE", "24")

  hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
  hl.env("QT_QPA_PLATFORM", "wayland")
  hl.env("SDL_VIDEODRIVER", "wayland")
  hl.env("CLUTTER_BACKEND", "wayland")
  hl.env("MOZ_ENABLE_WAYLAND", "1")
  hl.env("NIXOS_OZONE_WL", "1")
  hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
  hl.env("QT_STYLE_OVERRIDE", "adwaita")
  hl.env("XDG_DATA_DIRS", programs.xdg_data_dirs)
end

return M
