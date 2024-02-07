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

<img src="https://cdn.discordapp.com/attachments/1204166452450431067/1204699086633041931/vibNCTb.png?ex=65d5ae74&is=65c33974&hm=64a6cd42e57da5d785baa2371edec985f27e93e9081dc53a8d4633bc6bd69118&"></img>

### Lazy Neovim

<img src="https://media.discordapp.net/attachments/643888283449032736/1204838429511127070/72sEYJy.png?ex=65d6303a&is=65c3bb3a&hm=696895dc089012a7a14bcb925210e4f761f9d4d5b3fc9acd95f2a1507e4b41cc"></img>

### Additional resources
- HyprV4 guide video - [YouTube](https://youtu.be/whAi_y_LfEE?si=VjWGe4B-OIfhH2xu) (By the author)
- cattpuccin.nvim docs - [neovimcraft.com](https://neovimcraft.com/plugin/catppuccin/nvim/index.html)
  - Useful for those who want to change the styling under /nvim/lua/plugins/colorscheme.lua
