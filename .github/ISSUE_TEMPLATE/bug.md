---
name: Bug report
about: Something in the dotfiles is broken or misbehaving
title: "[bug] "
labels: bug
assignees: ""
---

## What happened

A clear, short description.

## Steps to reproduce

1.
2.
3.

## Expected

What should have happened.

## Actual

What actually happened.

## Area

Pick whichever single area label best matches this bug. The full
list of available labels lives at
<https://github.com/1Git2Clone/dotfiles/labels> (filter by
`area:*`).

- [ ] area: setup (`full_setup.sh`, `stow_setup.sh`, bootstrap)
- [ ] area: hyprland (`dot-config/hypr/`)
- [ ] area: profile (`dot-profile`, `dot-profile.d`, `dot-bashrc`, `dot-zshrc`)
- [ ] area: waybar (`dot-config/waybar/`)
- [ ] area: wofi (`dot-config/wofi/`)
- [ ] area: wlogout (`dot-config/wlogout/`)
- [ ] area: mako (`dot-config/mako/`)
- [ ] area: swaylock (`dot-config/swaylock/`)
- [ ] area: fastfetch (`dot-config/fastfetch/`)
- [ ] area: kitty (`dot-config/kitty/`)
- [ ] area: mocha (`dot-config/mocha/`)
- [ ] area: caelestia (`dot-config/caelestia/`)
- [ ] area: neovide (`dot-config/neovide/`)
- [ ] area: lazygit (`dot-config/lazygit/`)
- [ ] area: qbittorrent (`dot-config/qBittorrent/`)
- [ ] area: vesktop (`dot-config/vesktop/`)
- [ ] area: btop (`dot-config/btop/`)
- [ ] area: systemd (`dot-config/systemd/`)
- [ ] area: claude (`dot-claude/`)
- [ ] area: hermes (`dot-hermes/`)
- [ ] area: opencode (`dot-config/opencode/` — project-owned files only)
- [ ] area: fish (`dot-config/fish/`)
- [ ] area: starship (`dot-config/starship/`)
- [ ] area: cargo (`dot-cargo/`)
- [ ] area: gh (`dot-config/gh/`)
- [ ] area: ci (`.github/workflows/`, `ci/`)
- [ ] area: docs (non-markdownlint docs)
- [ ] area: readme (`README.md` specifically)
- [ ] area: lint-stack (pre-commit, pre-push, formatter configs)
- [ ] area: gitignore (`.gitignore` and subtree denylist rules)

A maintainer will replace the checklist above with the matching
`area:*` label on triage.

## Environment

- OS / distro / version:
- Stow version (`stow --version`):
- Did you run `pre-commit run --all-files` locally? Result:

## Relevant files

Mark which files this touches (paste `git status` output or list paths):

```text

```

## Notes

Anything else — terminal output, screenshots, related issues.

## Labels

The bug report itself gets `bug` automatically. Please also add:

- one **area:**\* label from
  [the full list](https://github.com/1Git2Clone/dotfiles/labels?q=area%3A)
  — pick the tool/config that broke (`area: setup`, `area: hyprland`,
  `area: opencode`, `area: ci`, etc.)
- a **P**\* priority (`P0` critical, `P3` polish)
