--[[
Setup-specific, not tracked in git.

Copy specific snippets of this example to `monitors.lua` and adjust for your
hardware.

Latest Hyprland configuration guide:
 - https://wiki.hypr.land/Configuring/Basics/Monitors/
   NOTE: File was made during Hyprland v0.55.0.

================================================================================
Setup A: Dock (2 monitors, main on the right)
================================================================================

               ┌──────────────────────┐  ┌──────────────────────┐
               │                      │  │                      │
               │    HDMI-A-1          │  │    DP-1 (main)       │
               │    1920×1080 @60     │  │    1920×1080 @165    │
               │    -1920×0           │  │    0×0               │
               │                      │  │                      │
               └──────────────────────┘  └──────────────────────┘

================================================================================
--]]

hl.monitor({
  output = "DP-1",
  mode = "1920x1080@165",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@60",
  position = "-1920x0",
  scale = 1,
})

--[[
================================================================================
= Setup B: Laptop-only
================================================================================

                            ┌──────────────────────┐
                            │                      │
                            │    eDP-1             │
                            │    1920×1080 @60     │
                            │    0x0               │
                            │                      │
                            └──────────────────────┘

================================================================================
--]]

hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@60",
  position = "0x0",
  scale = 1,
})
