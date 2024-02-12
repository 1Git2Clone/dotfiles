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

<img src="https://cdn.discordapp.com/attachments/614790390020833280/1206572222542520352/2SiAR0T.png?ex=65dc7ef2&is=65ca09f2&hm=9e6f376c2dda528f2fc88163a6ff39b019a2d859c7f975f65a6045bc2fb9f77c&"></img>

### Lazy Neovim

**NOTE:** I'm too lazy to change the color scheming for the lualine at the bottom.

<img src="https://cdn.discordapp.com/attachments/614790390020833280/1206572603775520798/jc0XGKv.png?ex=65dc7f4d&is=65ca0a4d&hm=d2cec9089c0922fa8ea620880470409fec7f5aeec9c00ff79a49f4da5323ce84&"></img>
<img src="https://cdn.discordapp.com/attachments/614790390020833280/1206573735679762472/OpR6K4R.png?ex=65dc805b&is=65ca0b5b&hm=e30a9be7d2c0ebb96121623cd21c1159ac12680bb1151598da5e5cde50a0a176&"></img>

### Additional resources
- HyprV4 guide video - [YouTube](https://youtu.be/whAi_y_LfEE?si=VjWGe4B-OIfhH2xu) (By the author)
- cattpuccin.nvim docs - [neovimcraft.com](https://neovimcraft.com/plugin/catppuccin/nvim/index.html)
  - Useful for those who want to change the styling under /nvim/lua/plugins/colorscheme.lua
