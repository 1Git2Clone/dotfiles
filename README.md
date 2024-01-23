# ONLY IF YOU WANT TO AUTOMATE THE `packages-used.txt` GENERATION

In order to schedule the packages-used.txt file you need to make some timer schedules in your init system.

- For systemd (refer to /systemd1.txt and /systemd2.txt):

- Then you just need to run

`sudo systemctl enable update-package-list.timer`

`sudo systemctl start update-package-list.timer`

I don't know about different init systems. This can be scheduled in different ways or not be scheduled at all, it's not important to set it up 

# The `neovim` configuration is the default [lazy.nvim](https://github.com/LazyVim/LazyVim) with some small extras. THEIR LICENSING STILL APPLIES THERE! (/nvim)

# The `Hyprland` configuration is just [HyprV4](https://github.com/soldoestech/hyprv4) with changed images and `mako` notification changes.
