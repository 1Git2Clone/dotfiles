---
name: Feature or change
about: Propose a change to the dotfiles
title: ""
labels: enhancement
assignees: ""
---

## What

A clear, short description of what you want to change.

## Why

Why this change is useful. What problem does it solve?

## How

How would you implement it? Which files would change? Any
trade-offs to consider?

## Area

Pick whichever single area label best matches this feature. The
full list of available labels lives at
<https://github.com/1Git2Clone/dotfiles/labels> (filter by
`area:*`).

- [ ] area: setup (`full-setup.sh`, `stow-setup.sh`, bootstrap)
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

## Scope

- [ ] Affects a single tool/config (e.g. just hyprland)
- [ ] Affects multiple configs
- [ ] Affects repo infrastructure (.gitignore, .stow-local-ignore, CI)

## Checklist

- [ ] I have run `pre-commit run --all-files` locally
- [ ] I have considered whether CI lint jobs need updating
- [ ] I have considered whether `.stow-local-ignore` needs updating

## Labels

The feature request itself gets `enhancement` automatically. Please
also add:

- one **area:**\* label from
  [the full list](https://github.com/1Git2Clone/dotfiles/labels?q=area%3A)
  — pick the tool/config the change affects
- `good first issue` if you're new to the repo and want help onboarding
