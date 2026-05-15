-- https://wiki.hypr.land/Configuring/Start/

local programs = require("modules.programs")

require("modules.animations")
require("modules.autostart").setup(programs)
require("modules.env").setup(programs)
require("modules.gestures")
require("modules.input")
require("modules.keybindings").setup(programs)
require("modules.look_and_feel")
require("modules.monitors")
require("modules.window_rules")
require("modules.workspace_rules")
