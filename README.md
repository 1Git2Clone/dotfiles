# Configuration files

Quick tip about querying your packages into your own file:

```sh
pacman -Qqe > target_file_location/target_file.txt
```

To install the queried packages:

```sh
sudo pacman -S --needed - < target_file_location/target_file.txt
```

_Feel free to replace pacman with paru, yay or whatever [AUR helper](https://wiki.archlinux.org/title/AUR_helpers) you may use_

- But ****DON'T**** use `sudo` if you use an AUR helper!!!

Also, a lot of the packages **are** AUR packages, so don't worry about pacman telling you they don't exist if you don't use an AUR helper to install them with.

## Quick setup guide

```sh
chmod +x ./stow_setup.sh && chmod +x ./full_setup.sh # One time only

./full_setup.sh # Or ./stow_setup.sh if you only want the symlinks.
```

### Important notes

- **The [Hyprland](https://hyprland.org/) configuration is just [HyprV4](https://github.com/soldoestech/hyprv4) with changed images and `mako` notification changes.**

- **Both the i3 and Hyprland configurations assume DP-1 is a 1080p165hz monitor. _(easy to change)_**

## Preview (current v2 layout)

![One screen preview](images/screenshot-one-screen.png)
![Two screens preview](images/screenshot-two-screens.png)

### [Lazy Neovim](https://github.com/folke/lazy.nvim)

**NOTE:** I'm too lazy to change the color scheming for the lualine at the bottom.

![Treesitter](images/treesitter.png)
![Code testing feature preview](images/code-testing.png)

## Terminal utils

### [Zoxide](https://github.com/ajeetdsouza/zoxide)

![Zoxide preview](images/zoxide.png)

### [Lazygit](https://github.com/jesseduffield/lazygit)

![Lazygit preview](images/lazygit.png)

### [Btop++](https://github.com/aristocratos/btop)

![Btop++](images/btop++.png)

### Additional resources

- HyprV4 guide video - [YouTube](https://youtu.be/whAi_y_LfEE?si=VjWGe4B-OIfhH2xu) (By the author)
- cattpuccin.nvim docs - [neovimcraft.com](https://neovimcraft.com/plugin/catppuccin/nvim/index.html)
  - Useful for those who want to change the styling under /nvim/lua/plugins/colorscheme.lua
