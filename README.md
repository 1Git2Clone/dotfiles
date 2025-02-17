# Configuration files

Quick tip about querying your packages into your own file:

```sh
pacman -Qqe > target_file_location/target_file.txt
```

To install the queried packages:

```sh
sudo pacman -S --needed - < target_file_location/target_file.txt
```

_Feel free to replace pacman with paru, yay or whatever [AUR
helper](https://wiki.archlinux.org/title/AUR_helpers) you may use_

- But **_DON'T_** use `sudo` if you use an AUR helper!!!

Also, a lot of the packages **are** AUR packages, so don't worry about pacman
telling you they don't exist if you don't use an AUR helper to install them
with.

## Table of contents

- [Configuration files](#configuration-files)
  - [Quick setup guide](#quick-setup-guide)
    - [Important notes](#important-notes)
    - [Lazy Neovim](#lazy-neovim)
  - [Terminal utils](#terminal-utils)
    - [Workflow video](#workflow-video)
    - [Zoxide](#zoxide)
    - [Lazygit](#lazygit)
    - [Btop++](#btop)
    - [Additional resources](#additional-resources)

## Quick setup guide

```sh
chmod +x ./stow_setup.sh && chmod +x ./full_setup.sh # One time only

./full_setup.sh # Or ./stow_setup.sh if you only want the symlinks.
```

### Important notes

- **Both the i3 and Hyprland configurations assume DP-1 is a 1080p165hz
  monitor. _(easy to change)_**

### Lazy Neovim

![Treesitter](assets/treesitter.png)
![Code testing feature preview](assets/code-testing.png)

Here's a more recent setup showcase video too (recorded on `2025-02-10` | `YYYY/MM/DD`):

[Neovim Setup Showcase](https://github.com/user-attachments/assets/adf29c80-4e4b-4bee-a1a0-c8d8f511ade3)

> [!NOTE]
> Also available on [`YouTube`](https://www.youtube.com/watch?v=BKOce2_b8t8)
> and as an uncompressed asset under
> [`/assets`](./assets/neovm-setup-showcase.mp4).

## Terminal utils

> [!NOTE]
> The screenshots from below are from my old Hyprland setup. The applications
> are the same but the windows don't have gaps and aren't rounded anymore in
> the i3 environment.

### Workflow video

[Workflow preview - only visible on the GitHub repo](https://github.com/1Git2Clone/dotfiles/assets/171241044/21eb072e-509b-4ef2-b709-15ddfa58ff0d)

For non-GitHub users you can preview the video on [YouTube](https://youtu.be/Zu_38OXGSvc)

Or you can download the raw video file from
[here](https://raw.githubusercontent.com/1git2clone/dotfiles/main/assets/workflow_showcase.mp4)
(`raw.githubusercontent.com`). Alternatively, head to the [git repo asset itself](assets/workflow_showcase.mp4).

### Zoxide

![Zoxide preview](assets/zoxide.png)

### Lazygit

![Lazygit preview](assets/lazygit.png)

### Btop++

![Btop++](assets/btop++.png)

### Additional resources

- cattpuccin.nvim docs -
  [neovimcraft.com](https://neovimcraft.com/plugin/catppuccin/nvim/index.html)

  - Useful for those who want to change the styling under
    /nvim/lua/plugins/colorscheme.lua

- Make sure to check the `dot-config/programs/` folder which contains a bunch
  of useful utilities like a color hue shift script that changes the hues of
  every 6-digit HEX sequence with your specified offset (1-360) and some other
  apps. They're already added to your `$PATH` variable in `dot-profile`.
