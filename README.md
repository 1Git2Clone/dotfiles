# THESE INIT SYSTEM CHANGES ARE ONLY IF YOU WANT TO AUTOMATE THE `packages-used.txt` GENERATION
# IN ORDER TO SCHEDULE THE PACKAGES-USED FOLDER
# YOU NEED TO SET UP THESE 2 CONFIG FILES FOR YOUR INIT SYSTEM

## For systemd (refer to /systemd1.txt and /systemd2.txt):

### Then you just need to run

`sudo systemctl enable update-package-list.timer`
`sudo systemctl start update-package-list.timer`


# The `neovim` configuration is the default [lazy.nvim](https://github.com/LazyVim/LazyVim) with some small extras. THEIR LICENSING STILL APPLIES THERE! (/nvim)

# The `Hyprland` configuration is just [HyprV4](https://github.com/soldoestech/hyprv4) with changed images and `mako` notification changes.
