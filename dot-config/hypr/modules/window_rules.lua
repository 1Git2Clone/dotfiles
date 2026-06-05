hl.window_rule({ name = "centerfloat-float", match = { tag = "centerfloat" }, float = true })
hl.window_rule({ name = "centerfloat-center", match = { tag = "centerfloat" }, center = true })
hl.window_rule({
  name = "centerfloat-size",
  match = { tag = "centerfloat" },
  size = { "monitor_w*0.6", "monitor_h*0.6" },
})

hl.window_rule({
  name = "tag-centerfloat-files",
  match = { class = [[^(Thunar|org\.gnome\.Nautilus)$]] },
  tag = "+centerfloat",
})
hl.window_rule({
  name = "tag-centerfloat-floorp-save",
  match = { class = "^(floorp)$", title = "^[Ss]ave.+" },
  tag = "+centerfloat",
})
hl.window_rule({
  name = "tag-centerfloat-discord-portal",
  match = { class = "^(xdg-desktop-portal-gtk)$", title = [[^blob:https://discord\.com/.+]] },
  tag = "+centerfloat",
})
hl.window_rule({
  name = "tag-centerfloat-open-files",
  match = { class = "^(xdg-desktop-portal-gtk)$", title = "Open Files" },
  tag = "+centerfloat",
})
hl.window_rule({ name = "tag-centerfloat-pavucontrol", match = { class = "^(pavucontrol)$" }, tag = "+centerfloat" })

hl.window_rule({ name = "suppress-maximize-events", match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

hl.window_rule({
  name = "vesktop-rules",
  match = { class = "^([Vv]esktop)$" },
  float = true,
  center = true,
  size = { "monitor_w*0.8", "monitor_h*0.8" },
  opacity = "0.9",
})

hl.window_rule({
  name = "terminal",
  match = { class = "^[Kk]itty$" },
  opacity = "0.93",
})

hl.window_rule({
  name = "floating-terminal",
  match = { class = "^(floating-term)$" },
  float = true,
  center = true,
  size = { "monitor_w*0.7", "monitor_h*0.7" },
  opacity = "0.9",
})

hl.window_rule({
  name = "spotify",
  match = { class = "^[Ss]potify$" },
  opacity = "0.95",
})

hl.window_rule({
  name = "nautilus",
  match = { class = [[org\.gnome\.Nautilus]] },
  opacity = "0.9",
})

hl.window_rule({
  name = "fullscreen",
  match = { fullscreen = true },
  opacity = "1",
})
