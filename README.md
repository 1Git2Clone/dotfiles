# Configuration files

[![CI Icon]][CI Status]&emsp;[![License Icon]][LICENSE]

[CI Icon]: https://img.shields.io/github/actions/workflow/status/1Git2Clone/dotfiles/ci.yml?branch=main
[CI Status]: https://github.com/1Git2Clone/dotfiles/actions?query=branch%3Amain
[License Icon]: https://img.shields.io/badge/license-MIT-blue.svg
[LICENSE]: LICENSE

> [!IMPORTANT]
> **Arch Linux only.** This repository assumes you are running
> [Arch Linux](https://archlinux.org/) (or an Arch-based distro). The
> [setup scripts](./full_setup.sh) and
> [package list](./required_packages_archlinux.txt) call
> [`pacman`](https://wiki.archlinux.org/title/Pacman) and
> [`makepkg`](https://wiki.archlinux.org/title/Makepkg) directly, install
> AUR helpers from the AUR, and lean on Arch-specific paths and units
> (e.g. `sddm`, `pacman -S`). On other distros you can still cherry-pick
> configs, but the bootstrap will not work as written.

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
  - [Setup Showcase](#setup-showcase)
    - [Neovim](#neovim)
    - [Full Workflow video](#full-workflow-video)
  - [LFS / large binaries](#lfs--large-binaries)
  - [Additional resources](#additional-resources)

## Quick setup guide

```sh
chmod +x ./stow_setup.sh && chmod +x ./full_setup.sh # One time only

./full_setup.sh # Or ./stow_setup.sh if you only want the symlinks.
```

> [!IMPORTANT]
> The [`stow script`](./stow_setup.sh) and by extension the
> [`full setup script`](./full_setup.sh) both use
> [`stow`](https://www.gnu.org/software/stow/) with the
> [`--adopt` flag](https://man.archlinux.org/man/stow.8#adopt), meaning it
> could alter existing files in directories such as `~/.config`, `~/.local`,
> etc. If you don't want that behavior, run your stow commands manually or
> change the scripts to not use the `--adopt` flag.

## Setup Showcase

### Neovim

![Neovim Screenshot](assets/nvim/main.png)
![Neovim Screenshot Full](assets/nvim/full.png)
![Neovim Screenshot LazyGit](assets/nvim/lazygit.png)
![Neovim Screenshot Telescope](assets/nvim/telescope.png)

> [!IMPORTANT]
> The Neovim part of this repo can be found in
> [`1git2clone/nvim-config`](https://github.com/1git2clone/nvim-config).

### Full Workflow video

<!-- markdownlint-disable MD034 -->
<!-- Reason: GitHub embeds the link as a video directly. -->

https://github.com/user-attachments/assets/741b4680-d85f-49cb-abff-1d959bdc93c2

<!-- markdownlint-enable MD034 -->

> [!NOTE]
> Video files can be found in [`assets`](assets) in case you're viewing them
> outside of GitHub or you want to view the video files themselves.

## LFS / large binaries

This repo ships wallpapers, themes, fonts, the showcase video, and a
handful of prebuilt CLI helpers (under `dot-config/programs/bin/`).
All of those are tracked through [Git LFS](https://git-lfs.github.com/)
so clones stay small.

- Install LFS once: `git lfs install`.
- New images / fonts / videos / themes / prebuilt binaries you commit
  are routed to LFS automatically by
  [`.gitattributes`](./.gitattributes) — no per-file work needed.
- Large blobs that pre-date LFS are not migrated retroactively.
  Re-importing them is a separate
  [`git lfs migrate`](https://git-lfs.github.com/tools/developer-tools/),
  and is _not_ done by this branch. Run it yourself if you want the
  history scrubbed:

  ```sh
  git lfs migrate import --no-rewrite-refs \
    --include='*.png,*.jpg,*.ttf,*.mp4,*.qbtheme,dot-config/programs/bin/**'
  ```

## Additional resources

- cattpuccin.nvim docs -
  [neovimcraft.com](https://neovimcraft.com/plugin/catppuccin/nvim/index.html)

  - Useful for those who want to change the styling under
    /nvim/lua/plugins/colorscheme.lua

- Make sure to check the `dot-config/programs/` folder which contains a bunch
  of useful utilities like a color hue shift script that changes the hues of
  every 6-digit HEX sequence with your specified offset (1-360) and some other
  apps. They're already added to your `$PATH` variable in `dot-profile`.
