local M = {}

local function exec(cmd)
  return hl.dsp.exec_cmd(cmd)
end

function M.setup(programs)
  local main_mod = "SUPER"
  local file_manager_from_clipboard = 'sh -c \'c=$(wl-paste); [ -d "$c" ] && '
    .. programs.file_manager
    .. ' "$c" || '
    .. programs.file_manager
    .. "'"
  local neovide_from_clipboard = 'sh -c \'c=$(wl-paste); [ -d "$c" ] && neovide "$c" || neovide\''
  local launcher_interrupt_opts = { ignore_mods = true, non_consuming = true }

  hl.define_submap("global", function()
    hl.bind(main_mod .. " + Q", exec(programs.terminal))
    hl.bind(main_mod .. " + Return", exec(programs.terminal))
    hl.bind(main_mod .. " + SHIFT + C", hl.dsp.window.close())
    hl.bind(main_mod .. " + M", exec("wlogout --protocol layer-shell"))
    hl.bind(main_mod .. " + E", exec(file_manager_from_clipboard))
    hl.bind(main_mod .. " + SHIFT + E", exec(neovide_from_clipboard))
    hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
    hl.bind(main_mod .. " + V", hl.dsp.window.center())
    hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())
    hl.bind(main_mod .. " + G", hl.dsp.layout("togglesplit"))
    hl.bind(main_mod .. " + Space", exec(programs.menu))

    hl.bind(main_mod .. " + SUPER_L", hl.dsp.global("caelestia:launcher"), { ignore_mods = true, release = true })

    for _, key in ipairs({
      "Q",
      "Return",
      "C",
      "E",
      "G",
      "V",
      "S",
      "Space",
      "mouse:274",
      "mouse:275",
      "mouse:276",
      "mouse:277",
      "mouse_up",
      "mouse_down",
    }) do
      hl.bind(main_mod .. " + " .. key, hl.dsp.global("caelestia:launcherInterrupt"), launcher_interrupt_opts)
    end

    hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen())
    hl.bind(main_mod .. " + S", exec("~/dotfiles/dot-config/programs/shell_scripts/screenshot-selection-copy.sh"))
    hl.bind(
      main_mod .. " + SHIFT + S",
      exec("~/dotfiles/dot-config/programs/shell_scripts/screenshot-focused-monitor.sh")
    )
    hl.bind("ALT + V", exec("cliphist list | wofi -dmenu | cliphist decode | wl-copy"))
    hl.bind("ALT + C", exec("~/dotfiles/dot-config/programs/shell_scripts/cliphist-remove-entry.sh"))
    hl.bind("CTRL + ALT + C", exec("~/dotfiles/dot-config/programs/shell_scripts/get-cursor-pos.sh"))
    hl.bind("ALT + SHIFT + Q", exec("poweroff"))
    hl.bind("ALT + T", exec([[kitty --class "floating-term"]]))
    hl.bind(main_mod .. " + T", exec("~/dotfiles/dot-config/programs/shell_scripts/tesseract-screenshot.sh"))
    hl.bind(
      main_mod .. " + SHIFT + T",
      exec("~/dotfiles/dot-config/programs/shell_scripts/tesseract-screenshot.sh eng")
    )
    hl.bind("ALT + E", exec("caelestia emoji -p"))
    hl.bind(main_mod .. " + SHIFT + P", exec("~/dotfiles/dot-config/programs/shell_scripts/power-mode.sh"))
    hl.bind("CTRL + " .. main_mod .. " + J", exec("~/dotfiles/dot-config/programs/shell_scripts/autoclicker.sh"))

    hl.bind(main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
    hl.bind(main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
    hl.bind(main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
    hl.bind(main_mod .. " + down", hl.dsp.focus({ direction = "down" }))
    hl.bind(main_mod .. " + l", hl.dsp.focus({ direction = "right" }))
    hl.bind(main_mod .. " + h", hl.dsp.focus({ direction = "left" }))
    hl.bind(main_mod .. " + k", hl.dsp.focus({ direction = "down" }))
    hl.bind(main_mod .. " + j", hl.dsp.focus({ direction = "up" }))

    for workspace = 1, 10 do
      local key = workspace % 10
      hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
      hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
    end

    hl.bind(main_mod .. " + D", hl.dsp.workspace.toggle_special())

    hl.bind(main_mod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
    hl.bind(main_mod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
    hl.bind(main_mod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
    hl.bind(main_mod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))
    hl.bind(main_mod .. " + SHIFT + h", hl.dsp.window.swap({ direction = "left" }))
    hl.bind(main_mod .. " + SHIFT + l", hl.dsp.window.swap({ direction = "right" }))
    hl.bind(main_mod .. " + SHIFT + k", hl.dsp.window.swap({ direction = "up" }))
    hl.bind(main_mod .. " + SHIFT + j", hl.dsp.window.swap({ direction = "down" }))

    hl.bind(main_mod .. " + G", hl.dsp.window.center())

    hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

    hl.bind(
      "XF86AudioRaiseVolume",
      exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
      { locked = true, repeating = true }
    )
    hl.bind(
      "XF86AudioLowerVolume",
      exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
      { locked = true, repeating = true }
    )
    hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
    hl.bind(
      "XF86AudioMicMute",
      exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
      { locked = true, repeating = true }
    )
    hl.bind("XF86MonBrightnessUp", exec("brightnessctl s 10%+"), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown", exec("brightnessctl s 10%-"), { locked = true, repeating = true })

    hl.bind("XF86AudioNext", exec("playerctl next"), { locked = true })
    hl.bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPlay", exec("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPrev", exec("playerctl previous"), { locked = true })
  end)

  -- Mouse binds must be outside submap to work properly
  hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
  hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

  local function enter_global_submap()
    hl.exec_cmd([[hyprctl dispatch 'hl.dsp.submap("global")']])
  end

  hl.on("hyprland.start", enter_global_submap)
  hl.on("config.reloaded", enter_global_submap)
end

return M
