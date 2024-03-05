# Automating your own used packages

**THIS PART IS USEFUL ONLY IF YOU WANT TO AUTOMATE THE `packages-used.txt` GENERATION**

In order to schedule the packages-used.txt file you need to make some timer schedules in your init system.

- For systemd (refer to /systemd1.txt and /systemd2.txt):
  - The top comments of the files show the locations they need to be at alongside their proper file extension.

- Then you just need to run

`sudo systemctl enable update-package-list.timer`

`sudo systemctl start update-package-list.timer`

I don't know about different init systems. This can be scheduled in different ways or done manually. It's not important to set it up 

### Important notes

- **The `neovim` configuration is the default [lazy.nvim](https://github.com/LazyVim/LazyVim) with some small extras. THEIR LICENSING STILL APPLIES THERE! (/nvim)**

- **The `Hyprland` configuration is just [HyprV4](https://github.com/soldoestech/hyprv4) with changed images and `mako` notification changes.**

## Preview (current v2 layout)

<img src="images/screenshot-one-screen.png">
<img src="images/screenshot-two-screens.png">

### [Lazy Neovim](https://github.com/folke/lazy.nvim)

**NOTE:** I'm too lazy to change the color scheming for the lualine at the bottom.

<img src="images/treesitter.png">
<img src="images/code-testing.png">

- Also a link to the [Neovim project](https://github.com/neovim/neovim) on GitHub.

## Terminal utils

### [Zoxide](https://github.com/ajeetdsouza/zoxide)

<img src="images/zoxide.png">

### [Lazygit](https://github.com/jesseduffield/lazygit)

<img src="images/lazygit.png">

### Additional resources
- HyprV4 guide video - [YouTube](https://youtu.be/whAi_y_LfEE?si=VjWGe4B-OIfhH2xu) (By the author)
- cattpuccin.nvim docs - [neovimcraft.com](https://neovimcraft.com/plugin/catppuccin/nvim/index.html)
  - Useful for those who want to change the styling under /nvim/lua/plugins/colorscheme.lua
