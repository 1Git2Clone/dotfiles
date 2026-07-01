# Pull Request

## What

<!-- One-paragraph summary of the change. -->

## Why

<!-- Motivation: bug, missing config, refactor, etc. Link any
     related issue. -->

## Scope

<!-- What tools/configs does this touch? Check all that apply. -->

- [ ] `hyprland` / `dot-config/hypr/`
- [ ] `tmux` / `dot-tmux.conf`
- [ ] `zsh` / `dot-profile.d/`
- [ ] `opencode` / `dot-config/opencode/`
- [ ] `claude` / `dot-claude/`
- [ ] Repo infra (`.gitignore`, `.stow-local-ignore`, CI, pre-commit)
- [ ] Vendored skill update (`dot-config/opencode/skills/`)
- [ ] Other: **\_**

## Risk

<!-- How likely is this to break an existing setup? What did
     you test? -->

- [ ] Low — docs or repo infra only
- [ ] Medium — touches a config but tested locally
- [ ] High — touches a config I can't easily test on this host

## Checklist

- [ ] `pre-commit run --all-files` passes locally
- [ ] `pre-commit run --hook-stage manual --all-files` passes (pre-push set)
- [ ] If I added a new top-level file, I added it to `.stow-local-ignore`
- [ ] If I added a new tool config, the relevant CI job covers it
- [ ] I followed the commit message convention (`type(scope): subject`)
